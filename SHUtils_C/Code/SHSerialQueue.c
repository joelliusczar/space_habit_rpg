//
//  SHSerialQueue.c
//  SHUtils_C
//
//  Created by Joel Pridgen on 5/23/20.
//  Copyright © 2020 Joel Gillette. All rights reserved.
//

#include "SHSerialQueue.h"
#include "SHLinkedList.h"
#include "SHUtilConstants.h"
#include <pthread.h>
#include <stdlib.h>
#include <errno.h>
#include <stdbool.h>
#include <assert.h>


struct _queuedOp {
	SHErrorCode (*fn)(void*, struct SHQueueStore *, void **);
	void *fnArgs;
	void (*cleanupFn)(void*);
};


struct SHQueueStore {
	void *userItem;
	void (*queueStoreCleanup)(void *);
	struct SHSerialQueue *queueRef;
};


struct SHSerialQueue {
	struct SHQueueStore queueStore;
	struct SHLinkedList *opsQueue;
	struct SHLinkedList *resultQueue;
	pthread_t dbSerialThread;
	pthread_mutex_t lock;
	pthread_cond_t waitable;
	pthread_mutex_t resultLock;
	pthread_cond_t resultWait;
	bool isRunning;
	bool isCanceled;
};


struct _wrappedVoidFnArgs {
	void *fnArgs;
	void (*cleanupFn)(void*);
	SHErrorCode (*wrappedFn)(void*, struct SHQueueStore *);
};


static int32_t _voidResultSentinel = 0;


static void _opCleanup(struct _queuedOp **opP2) {
	if(!opP2) return;
	struct _queuedOp *op = *opP2;
	if(op->cleanupFn) {
		op->cleanupFn(op->fnArgs);
	}
	free(op);
	*opP2 = NULL;
}


static void _opCleanup2(void **args) {
	_opCleanup((struct _queuedOp**)args);
}


static SHErrorCode _wrapVoidCall(void *fnArgs, struct SHQueueStore *store, void **result) {
	
	struct _wrappedVoidFnArgs *wrapped = (struct _wrappedVoidFnArgs*)fnArgs;
	SHErrorCode status = wrapped->wrappedFn(wrapped->fnArgs, store);
	if(wrapped->cleanupFn) {
		wrapped->cleanupFn(fnArgs);
	}
	*result = &_voidResultSentinel;
	free(wrapped);
	return status;
}


SHErrorCode _addOp(
	struct SHSerialQueue *queue,
	SHErrorCode (*fn)(void*, struct SHQueueStore *, void**),
	void *fnArgs,
	void (*cleanupFn)(void*))
{
	SHErrorCode status = SH_NO_ERROR;
	struct _queuedOp *op = malloc(sizeof(struct _queuedOp));
	*op = (struct _queuedOp){.fn = fn, .fnArgs = fnArgs, .cleanupFn = cleanupFn };
	int32_t threadCode = 0;
	if((threadCode = pthread_mutex_lock(&queue->lock)) != 0) { goto threadErr; }
	if(queue->isCanceled) {
		goto canceled;
	}
	SH_list_pushBack(queue->opsQueue, op);
	if((threadCode = pthread_cond_signal(&queue->waitable)) != 0) { goto threadErr; }
	if((threadCode = pthread_mutex_unlock(&queue->lock)) != 0) { goto threadErr; }
	return SH_NO_ERROR;
	
	canceled:
		//don't think we need to exit lock in this case because it should have been destroyed by now
		status |= SH_EXTERNAL_BLOCK;
		goto cleanup;
	threadErr:
		SH_notifyOfError(SH_THREAD_ERROR, "failed to recieve mutex lock");
		status |= SH_THREAD_ERROR;
	cleanup:
		_opCleanup(&op);
		return status;
}


SHErrorCode SH_serialQueue_addOp(struct SHSerialQueue *queue,
	SHErrorCode (*fn)(void*, struct SHQueueStore *), void *fnArgs, void (*cleanupFn)(void*))
{
	assert(queue);
	assert(fn);
	SHErrorCode status = SH_NO_ERROR;
	struct _wrappedVoidFnArgs *wrapped = malloc(sizeof(struct _wrappedVoidFnArgs));
	*wrapped = (struct _wrappedVoidFnArgs){
		.wrappedFn = fn,
		.fnArgs = fnArgs,
		.cleanupFn = cleanupFn
	};
	status = _addOp(queue, _wrapVoidCall, wrapped, free);
	return status;
}


static SHErrorCode _getNextOrWait(struct SHLinkedList *list, pthread_mutex_t *lock, pthread_cond_t *cond,
	void **next)
{
	*next = NULL;
	int32_t threadCode = 0;
	if((threadCode = pthread_mutex_trylock(lock)) != 0) {
		if(threadCode != EBUSY) goto threadErr;
		goto blockedExit;
	}
	*next = SH_list_popBack(list);
	if(*next) goto fnExit;
	if(pthread_cond_wait(cond, lock)) {
		goto threadErr;
	}
	*next = SH_list_popBack(list);
		
	
	fnExit:
		if((threadCode = pthread_mutex_unlock(lock)) != 0) { goto threadErr; }
		return SH_NO_ERROR;
	blockedExit:
		return SH_NO_ERROR;
	threadErr:
		SH_notifyOfError(SH_THREAD_ERROR, "failed to recieve mutex lock");
		return SH_THREAD_ERROR;
}


static SHErrorCode _getNextOpOrWait(struct SHSerialQueue *queue, struct _queuedOp **next) {
	return _getNextOrWait(queue->opsQueue, &queue->lock, &queue->waitable, (void**)next);
}


static void _freeUnusedItemsInQueue(struct SHSerialQueue *queue) {
	if(NULL == queue) return;
	int32_t threadCode = 0;
	if((threadCode = pthread_mutex_lock(&queue->lock)) != 0) {
		SH_notifyOfError(SH_THREAD_ERROR, "Failed to get lock in cleanup function");
	}
	SH_list_cleanup(&queue->opsQueue);
	SH_list_cleanup(&queue->resultQueue);
	queue->isRunning = false;
	queue->isCanceled = true;
	if((threadCode = pthread_mutex_unlock(&queue->lock)) != 0) {
		SH_notifyOfError(SH_THREAD_ERROR, "Failed to get lock in cleanup function");
	}
	pthread_mutex_destroy(&queue->lock);
	pthread_cond_destroy(&queue->waitable);
	pthread_mutex_destroy(&queue->resultLock);
	pthread_cond_destroy(&queue->resultWait);
}


static SHErrorCode _getNextResultOrWait(struct SHSerialQueue *queue, void **result) {
	return _getNextOrWait(queue->resultQueue, &queue->resultLock, &queue->resultWait, result);
}


static SHErrorCode _collectResult(struct SHSerialQueue *queue, void *result) {
	int32_t threadCode = 0;
	SHErrorCode status = SH_NO_ERROR;
	if((threadCode = pthread_mutex_lock(&queue->resultLock)) != 0) { goto threadErr; }
	SH_list_pushBack(queue->resultQueue, result);
	if((threadCode = pthread_cond_signal(&queue->resultWait)) != 0) { goto threadErr; }
	if((threadCode = pthread_mutex_unlock(&queue->resultLock)) != 0) { goto threadErr; }
	return SH_NO_ERROR;
	
	threadErr:
		SH_notifyOfError(SH_THREAD_ERROR, "failed to recieve mutex lock");
		status |= SH_THREAD_ERROR;
		return status;
}


SHErrorCode SH_addOpAndWaitForResult(
	struct SHSerialQueue *queue,
	SHErrorCode (*fn)(void*, struct SHQueueStore *, void**),
	void *fnArgs,
	void (*cleanupFn)(void*),
	void **result)
{

	SHErrorCode status = SH_NO_ERROR;

	status = _addOp(queue, fn, &fnArgs, cleanupFn);
	void *temp = NULL;
	if((status = _getNextResultOrWait(queue, &temp)) != SH_NO_ERROR) {
		goto fnExit;
	}
	if(result) {
		*result = temp;
	}
	
	fnExit:
		return status;
	
}


static SHErrorCode _runSerialQueueLoop(struct SHSerialQueue *queue) {
	struct _queuedOp *node = NULL;
	SHErrorCode status = SH_NO_ERROR;
	queue->isRunning = true;
	while(queue->isRunning) {
		if(NULL == queue) goto fnExit;
		if((status = _getNextOpOrWait(queue, &node)) != SH_NO_ERROR) { goto fnErrGetOp; }
		if(NULL != node) {
			void *result = NULL;
			if((status = node->fn(node->fnArgs, &queue->queueStore, &result)) != SH_NO_ERROR) {
				goto fnErr;
			}
			if(result != &_voidResultSentinel) {
				_collectResult(queue, result);
			}
			_opCleanup(&node);
		}
	}
	fnExit:
		return status;
	fnErrGetOp:
		SH_notifyOfError(status, "Error occured while getting next op");
	fnErr:
		_freeUnusedItemsInQueue(queue);
		return status;
}


static void* _serialQueueLoopWrapper(void *args) {
	SHErrorCode status = SH_NO_ERROR;
	struct SHSerialQueue *queue = (struct SHSerialQueue *)args;
	if((status = _runSerialQueueLoop(queue)) != SH_NO_ERROR) { ; }
	printf("thread ending");
	return NULL;
}


SHErrorCode SH_serialQueue_startLoop(struct SHSerialQueue *queue) {
	int32_t threadStatus = 0;
	if((threadStatus = pthread_create(&queue->dbSerialThread, NULL, _serialQueueLoopWrapper, queue))
		!= SH_NO_ERROR)
	{
		return SH_THREAD_ERROR;
	}
	return SH_NO_ERROR;
}


struct SHSerialQueue * SH_serialQueue_init(void *initArgs, void (*initArgsCleanup)(void*)) {
	struct SHSerialQueue *queue = malloc(sizeof(struct SHSerialQueue));
	*queue = (struct SHSerialQueue){
		.opsQueue = SH_list_init(_opCleanup2),
		.resultQueue = SH_list_init(NULL),
		.queueStore = { .queueRef = queue,
			.userItem = initArgs,
			.queueStoreCleanup = initArgsCleanup
		},
		.isRunning = false,
		.isCanceled = false,
	};
	if(pthread_mutex_init(&queue->lock, NULL)) {
		goto cleanupQueue;
	}
	if(pthread_cond_init(&queue->waitable, NULL)) {
		goto cleanupLock;
	}
	if(pthread_mutex_init(&queue->resultLock, NULL)) {
		goto cleanupWaitable;
	}
	if(pthread_cond_init(&queue->resultWait, NULL)) {
		goto cleanupResultLock;
	}
	return queue;
	cleanupResultLock:
		pthread_mutex_destroy(&queue->resultLock);
	cleanupWaitable:
		pthread_cond_destroy(&queue->waitable);
	cleanupLock:
		pthread_mutex_destroy(&queue->lock);
	cleanupQueue:
		SH_serialQueue_cleanup(queue);
		return NULL;
}


void *SH_serialQueue_getUserItem(struct SHQueueStore *store) {
	return store->userItem;
}


void SH_serialQueue_cleanup(struct SHSerialQueue *queue) {
	if(!queue) return;
	_freeUnusedItemsInQueue(queue);
	if(queue->queueStore.queueStoreCleanup) {
		queue->queueStore.queueStoreCleanup(queue->queueStore.userItem);
	}
	free(queue);
}
