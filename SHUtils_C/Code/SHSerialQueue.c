//
//  SHSerialQueue.c
//  SHUtils_C
//
//  Created by Joel Pridgen on 5/23/20.
//  Copyright © 2020 Joel Gillette. All rights reserved.
//

#include "SHSerialQueue.h"
#include "SHLinkedList.h"
#include "SHIterableWrapper.h"
#include "SHSyncedList.h"
#include "SHUtilConstants.h"
#include "SHGenAlgos.h"
#include <pthread.h>
#include <stdlib.h>
#include <errno.h>
#include <assert.h>


struct _queuedOp {
	SHErrorCode (*fn)(void*, struct SHQueueStore *, void **);
	void *fnArgs;
	void (*cleanupFn)(void**);
};


struct SHQueueStore {
	void *userItem;
	void (*queueStoreCleanup)(void **);
	struct SHSerialQueue *queueRef;
};


struct SHSerialQueue {
	struct SHQueueStore queueStore;
	struct SHSyncedList *opsQueue;
	struct SHSyncedList *resultQueue;
	pthread_t dbSerialThread;
	pthread_cond_t waitable;
	pthread_cond_t resultWait;
	pthread_mutex_t isCanceledLock;
	pthread_mutex_t isRunningLock;
	pthread_cond_t isOpsQueueEmpty;
	bool isRunning;
	bool isCanceled;
};


struct _wrappedVoidFnArgs {
	void *fnArgs;
	void (*cleanupFn)(void**);
	SHErrorCode (*wrappedFn)(void*, struct SHQueueStore *);
};


static int32_t _voidResultSentinel = 0;


static void _opCleanup(struct _queuedOp **opP2) {
	if(!opP2) return;
	struct _queuedOp *op = *opP2;
	if(op->cleanupFn) {
		op->cleanupFn(&op->fnArgs);
	}
	free(op);
	*opP2 = NULL;
}


static void _opCleanup2(void **args) {
	_opCleanup((struct _queuedOp**)args);
}


static bool _isCanceled(struct SHSerialQueue *queue) {
	int32_t threadCode = 0;
	bool ans = true;
	if((threadCode = pthread_mutex_lock(&queue->isCanceledLock)) != 0) { return true; }
	ans = queue->isCanceled;
	if((threadCode = pthread_mutex_unlock(&queue->isCanceledLock)) != 0) { return true; }
	return ans;
}


static SHErrorCode _setIsCanceled(struct SHSerialQueue *queue, bool value) {
	SHErrorCode status = SH_NO_ERROR;
	if(pthread_mutex_lock(&queue->isCanceledLock)) { return SH_THREAD_ERROR; }
	printf("set isCanceled %d\n", value);
	queue->isCanceled = value;
	if(pthread_mutex_unlock(&queue->isCanceledLock)) { return SH_THREAD_ERROR; }
	return status;
}


static bool _isRunning(struct SHSerialQueue *queue) {
	int32_t threadCode = 0;
	bool ans = false;
	if((threadCode = pthread_mutex_lock(&queue->isRunningLock)) != 0) { return false; }
	ans = queue->isRunning;
	if((threadCode = pthread_mutex_unlock(&queue->isRunningLock)) != 0) { return false; }
	return ans;
}


static SHErrorCode _setIsRunning(struct SHSerialQueue *queue, bool value) {
	SHErrorCode status = SH_NO_ERROR;
	if(pthread_mutex_lock(&queue->isRunningLock)) { return SH_THREAD_ERROR; }
	printf("set isRunning %d\n", value);
	queue->isRunning = value;
	if(pthread_mutex_unlock(&queue->isRunningLock)) { return SH_THREAD_ERROR; }
	return status;
}


static SHErrorCode _waitForQueueToEmpty(struct SHSerialQueue *queue) {
	SHErrorCode status = SH_NO_ERROR;
	if((status = _setIsCanceled(queue, true)) != SH_NO_ERROR) { goto cleanup; }
	int32_t threadCode = 0;
	//if((threadCode = pthread_mutex_lock(&queue->lock)) != 0) { goto threadErr; }
	
	if(SH_list_count(queue->opsQueue) < 1) {
		_setIsRunning(queue, false);
		if((threadCode = pthread_mutex_unlock(&queue->lock)) != 0) { goto threadErr; }
		goto fnExit;
	}
	printf("waiting\n");
	if(pthread_cond_wait(&queue->isOpsQueueEmpty, &queue->lock)) {
		goto threadErr;
	}
	printf("never gets here right?\n");
	if(SH_list_count(queue->opsQueue) < 1) {
		_setIsRunning(queue, false);
	}
	if((threadCode = pthread_mutex_unlock(&queue->lock)) != 0) { goto threadErr; }
	goto fnExit;
	
	threadErr:
		status |= SH_THREAD_ERROR;
		SH_notifyOfError(status, "There was a thread mishap\n");
	cleanup:
		SH_serialQueue_cleanup(&queue);
	fnExit:
		return status;
}


static SHErrorCode _wrapVoidCall(void *fnArgs, struct SHQueueStore *store, void **result) {
	
	struct _wrappedVoidFnArgs *wrapped = (struct _wrappedVoidFnArgs*)fnArgs;
	SHErrorCode status = wrapped->wrappedFn(wrapped->fnArgs, store);
	if(wrapped->cleanupFn) {
		wrapped->cleanupFn(&fnArgs);
	}
	*result = &_voidResultSentinel;
	return status;
}


SHErrorCode _addOp(
	struct SHSerialQueue *queue,
	SHErrorCode (*fn)(void*, struct SHQueueStore *, void**),
	void *fnArgs,
	void (*cleanupFn)(void**))
{
	SHErrorCode status = SH_NO_ERROR;
	struct _queuedOp *op = malloc(sizeof(struct _queuedOp));
	*op = (struct _queuedOp){ .fn = fn, .fnArgs = fnArgs, .cleanupFn = cleanupFn };
	int32_t threadCode = 0;
	//if((threadCode = pthread_mutex_lock(&queue->lock)) != 0) { goto threadErr; }
	if(_isCanceled(queue)) {
		goto canceled;
	}
	SH_syncedList_pushBack(queue->opsQueue, op);
	printf("added\n");
//	if((threadCode = pthread_cond_signal(&queue->waitable)) != 0) { goto threadErr; }
//	if((threadCode = pthread_mutex_unlock(&queue->lock)) != 0) { goto threadErr; }
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


SHErrorCode SH_serialQueue_addOp(
	struct SHSerialQueue *queue,
	SHErrorCode (*fn)(void*, struct SHQueueStore *),
	void *fnArgs,
	void (*cleanupFn)(void**))
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
	status = _addOp(queue, _wrapVoidCall, wrapped, SH_cleanup);
	return status;
}


static SHErrorCode _getNextOrWait(struct SHSyncedList *list, pthread_mutex_t *lock, pthread_cond_t *cond,
	pthread_cond_t *emptyCond, void **next)
{
	*next = NULL;
	int32_t threadCode = 0;
	if((threadCode = pthread_mutex_trylock(lock)) != 0) {
		if(threadCode != EBUSY) goto threadErr;
		goto blockedExit;
	}
	*next = SH_syncedList_waitForPopFront(list);
	
	
//	while(!(*next = SH_list_popBack(list))) {
//		if(pthread_cond_wait(cond, lock)) {
//			goto threadErr;
//		}
//		if(SH_list_count(list) < 1 && emptyCond) {
//			printf("signal\n");
//			if((threadCode = pthread_cond_signal(emptyCond)) != 0) { goto threadErr; }
//		}
//	}
	
	fnExit:
		if((threadCode = pthread_mutex_unlock(lock)) != 0) { goto threadErr; }
		return SH_NO_ERROR;
	blockedExit:
		return SH_NO_ERROR;
	threadErr:
		SH_notifyOfError(SH_THREAD_ERROR, "There was an error with a condition or a mutex");
		return SH_THREAD_ERROR;
}


static SHErrorCode _getNextOpOrWait(struct SHSerialQueue *queue, struct _queuedOp **next) {
	return _getNextOrWait(queue->opsQueue, &queue->lock, &queue->waitable, &queue->isOpsQueueEmpty, (void**)next);
}


static void _freeUnusedItemsInQueue(struct SHSerialQueue *queue) {
	if(NULL == queue) return;
	int32_t threadCode = 0;
	if((threadCode = pthread_mutex_lock(&queue->lock)) != 0) {
		SH_notifyOfError(SH_THREAD_ERROR, "Failed to get lock in cleanup function");
	}
	SH_syncedList_cleanup(&queue->opsQueue);
	SH_syncedList_cleanup(&queue->resultQueue);
	queue->isRunning = false;
	queue->isCanceled = true;
	if((threadCode = pthread_mutex_unlock(&queue->lock)) != 0) {
		SH_notifyOfError(SH_THREAD_ERROR, "Failed to get lock in cleanup function");
	}
	pthread_cond_destroy(&queue->waitable);
	pthread_cond_destroy(&queue->resultWait);
}


static SHErrorCode _getNextResultOrWait(struct SHSerialQueue *queue, void **result) {
	return _getNextOrWait(queue->resultQueue, &queue->resultLock, &queue->resultWait, NULL, result);
}


static SHErrorCode _collectResult(struct SHSerialQueue *queue, void *result) {
	int32_t threadCode = 0;
	SHErrorCode status = SH_NO_ERROR;
	SH_syncedList_pushBack(queue->resultQueue, result);
	if((threadCode = pthread_cond_signal(&queue->resultWait)) != 0) { goto threadErr; }
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
	void (*cleanupFn)(void**),
	void **result)
{

	SHErrorCode status = SH_NO_ERROR;
	
	printf("about to call");
	status = _addOp(queue, fn, &fnArgs, cleanupFn);
	void *temp = NULL;
	if((status = _getNextResultOrWait(queue, &temp)) != SH_NO_ERROR) {
		goto fnExit;
	}
	printf("get result");
	if(result) {
		*result = temp;
	}
	
	fnExit:
		return status;
	
}


static SHErrorCode _runSerialQueueLoop(struct SHSerialQueue *queue) {
	struct _queuedOp *node = NULL;
	SHErrorCode status = SH_NO_ERROR;
	while(_isRunning(queue)) {
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
	if(!queue) return SH_ILLEGAL_INPUTS;
	int32_t threadStatus = 0;
	SHErrorCode status = SH_NO_ERROR;
	if((status = _setIsRunning(queue, true)) != SH_NO_ERROR) { return status; }
	if((threadStatus = pthread_create(&queue->dbSerialThread, NULL, _serialQueueLoopWrapper, queue))
		!= SH_NO_ERROR)
	{
		return SH_THREAD_ERROR;
	}
	return status;
}


static SHErrorCode _initMutexesAndConditions(struct SHSerialQueue *queue) {
	int32_t threadErr = 0;
	if((threadErr = pthread_cond_init(&queue->waitable, NULL))) {
		goto cleanupLock;
	}
	if((threadErr = pthread_cond_init(&queue->resultWait, NULL))) {
		goto cleanupResultLock;
	}
	if((threadErr = pthread_mutex_init(&queue->isRunningLock, NULL))) {
		goto cleanupResultWait;
	}
	if((threadErr = pthread_mutex_init(&queue->isCanceledLock, NULL))) {
		goto cleanupIsRunningLock;
	}
	if((threadErr = pthread_cond_init(&queue->isOpsQueueEmpty, NULL))) {
		goto cleanupIsCanceledLock;
	}
	goto fnExit;
	cleanupIsCanceledLock:
		pthread_mutex_destroy(&queue->isCanceledLock);
	cleanupIsRunningLock:
		pthread_mutex_destroy(&queue->isRunningLock);
	cleanupResultWait:
		pthread_cond_destroy(&queue->resultWait);
	cleanupWaitable:
		pthread_cond_destroy(&queue->waitable);
	fnExit:
		return threadErr == 0 ? SH_NO_ERROR : SH_THREAD_ERROR;
}


struct SHSerialQueue * SH_serialQueue_init(void *initArgs, void (*initArgsCleanup)(void**)) {
	struct SHSerialQueue *queue = malloc(sizeof(struct SHSerialQueue));
	struct SHIterableWrapper *opsList = SH_iterable_initAsLinkedList(_opCleanup);
	struct SHIterableWrapper *resultList = SH_iterable_initAsLinkedList(NULL);
	*queue = (struct SHSerialQueue){
		.opsQueue = SH_syncedList_init(opsList),
		.resultQueue = SH_syncedList_init(resultList),
		.queueStore = { .queueRef = queue,
			.userItem = initArgs,
			.queueStoreCleanup = initArgsCleanup
		},
		.isRunning = false,
		.isCanceled = false,
	};
	SHErrorCode status = SH_NO_ERROR;
	if((status = _initMutexesAndConditions(queue)) != SH_NO_ERROR) {
		goto cleanupQueue;
	}
	return queue;
	
	cleanupQueue:
		SH_serialQueue_cleanup(&queue);
		return NULL;
}


void *SH_serialQueue_getUserItem(struct SHQueueStore *store) {
	return store->userItem;
}


bool SH_serialQueue_isLoopRunning(struct SHSerialQueue *queue) {
	if(!queue) return false;
	return _isRunning(queue) && !_isCanceled(queue);
}


SHErrorCode SH_serialQueue_endLoop(struct SHSerialQueue *queue) {
	if(!queue) return SH_ILLEGAL_INPUTS;
	SHErrorCode status = SH_NO_ERROR;
	status = _setIsRunning(queue, false);
	if((pthread_join(queue->dbSerialThread, NULL)) != 0) {
		return status | SH_THREAD_ERROR;
	}
	return status;
}


SHErrorCode SH_serialQueue_closeLoop(struct SHSerialQueue *queue) {
	if(!queue) return SH_ILLEGAL_INPUTS;
	if(!_isRunning(queue)) return SH_PRECONDITIONS_NOT_FULFILLED;
	SHErrorCode status = SH_NO_ERROR;
	status = _waitForQueueToEmpty(queue);
	if((pthread_join(queue->dbSerialThread, NULL)) != 0) {
		return status | SH_THREAD_ERROR;
	}
	return status;
}


void SH_serialQueue_cleanup(struct SHSerialQueue **queueP2) {
	if(!queueP2) return;
	struct SHSerialQueue *queue = *queueP2;
	if(!queue) return;
	_freeUnusedItemsInQueue(queue);
	if(queue->queueStore.queueStoreCleanup) {
		queue->queueStore.queueStoreCleanup(&queue->queueStore.userItem);
	}
	free(queue);
	*queueP2 = NULL;
}
