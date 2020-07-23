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
	struct SHSyncedList *opsQueue;
	struct SHSyncedList *resultQueue;
	pthread_t serialThread;
	pthread_mutex_t isRunningLock;
	bool isRunning;
};


struct _wrappedVoidFnArgs {
	void *fnArgs;
	void (*cleanupFn)(void*);
	SHErrorCode (*wrappedFn)(void*, struct SHQueueStore *);
};


static int32_t _voidResultSentinel = 0;


static void _opCleanup(struct _queuedOp *op) {
	if(op->cleanupFn) {
		op->cleanupFn(op->fnArgs);
	}
	free(op);
}


static bool _isRunning(struct SHSerialQueue *queue) {
	int32_t threadCode = 0;
	bool ans = false;
	char msg[80];
	if((threadCode = pthread_mutex_lock(&queue->isRunningLock)) != 0) { goto fnErr; }
	ans = queue->isRunning;
	if((threadCode = pthread_mutex_unlock(&queue->isRunningLock)) != 0) { goto fnErr; }
	return ans;
	fnErr:
		sprintf(msg,"pthread error: %d\nerror while initializing mutex or condition. \n", threadCode);
		SH_notifyOfError(SH_THREAD_ERROR, msg);
		return false;
}


static SHErrorCode _setIsRunning(struct SHSerialQueue *queue, bool value) {
	SHErrorCode status = SH_NO_ERROR;
	if(pthread_mutex_lock(&queue->isRunningLock)) { return SH_THREAD_ERROR; }
	queue->isRunning = value;
	if(pthread_mutex_unlock(&queue->isRunningLock)) { return SH_THREAD_ERROR; }
	return status;
}



static SHErrorCode _waitForQueueToEmpty(struct SHSerialQueue *queue) {
	SHErrorCode status = SH_NO_ERROR;
	if((status = SH_syncedList_setIsSqueezeMode(queue->opsQueue, true)) != SH_NO_ERROR) { goto fnExit; }
	if((status = SH_syncedList_runActionOnEmpty(queue->opsQueue, (SHErrorCode (*)(void*))SH_serialQueue_pauseLoop,
		queue)) != SH_NO_ERROR)
	{
		goto fnExit;
	}
	if((status = SH_syncedList_stirHasItems(queue->opsQueue)) != SH_NO_ERROR) { goto fnExit; }
		
	fnExit:
		return status;
}


static SHErrorCode _wrapVoidCall(void *fnArgs, struct SHQueueStore *store, void **result) {
	
	struct _wrappedVoidFnArgs *wrapped = (struct _wrappedVoidFnArgs*)fnArgs;
	SHErrorCode status = wrapped->wrappedFn(wrapped->fnArgs, store);
	if(wrapped->cleanupFn) {
		wrapped->cleanupFn(wrapped->fnArgs);
	}
	*result = &_voidResultSentinel;
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
	if(!op) goto allocErr;
	*op = (struct _queuedOp){ .fn = fn, .fnArgs = fnArgs, .cleanupFn = cleanupFn };
	if((status = SH_syncedList_pushBack(queue->opsQueue, op)) != SH_NO_ERROR) { goto cleanup; }
	goto fnExit;
	
	cleanup:
		SH_notifyOfError(status, "Item could not be added. This list is in squeezeMode");
		_opCleanup(op);
		goto fnExit;
	allocErr:
		if(cleanupFn) {
			cleanupFn(fnArgs);
		}
		status |= SH_ALLOC_NO_MEM;
		SH_notifyOfError(SH_ALLOC_NO_MEM, "Failed to allocate memory in _addOp");
	fnExit:
		return status;
	
}


SHErrorCode SH_serialQueue_addOp(
	struct SHSerialQueue *queue,
	SHErrorCode (*fn)(void*, struct SHQueueStore *),
	void *fnArgs,
	void (*cleanupFn)(void*))
{
	if(!queue) return SH_ILLEGAL_INPUTS;
	if(!fn) return SH_ILLEGAL_INPUTS;
	
	SHErrorCode status = SH_NO_ERROR;
	struct _wrappedVoidFnArgs *wrapped = malloc(sizeof(struct _wrappedVoidFnArgs));
	if(!wrapped) goto allocErr;
	*wrapped = (struct _wrappedVoidFnArgs){
		.wrappedFn = fn,
		.fnArgs = fnArgs,
		.cleanupFn = cleanupFn
	};
	if((status = _addOp(queue, _wrapVoidCall, wrapped, free))) { goto fnExit; }
	goto fnExit;
	allocErr:
		status |= SH_ALLOC_NO_MEM;
		SH_notifyOfError(status, "Failed to allocate memory in SH_serialQueue_addOp");
		goto fnExit;
	fnExit:
		return status;
}


static void _freeUnusedItemsInQueue(struct SHSerialQueue *queue) {
	if(NULL == queue) return;
	SH_syncedList_cleanup(queue->opsQueue);
	SH_syncedList_cleanup(queue->resultQueue);
	queue->isRunning = false;
}


SHErrorCode SH_addOpAndWaitForResult(
	struct SHSerialQueue *queue,
	SHErrorCode (*fn)(void*, struct SHQueueStore *, void**),
	void *fnArgs,
	void (*cleanupFn)(void*),
	void **result)
{

	SHErrorCode status = SH_NO_ERROR;
	
	status = _addOp(queue, fn, fnArgs, cleanupFn);
	void *temp = SH_syncedList_waitForPopFront(queue->resultQueue);
	if(result) {
		*result = temp;
	}
	
	return status;
}


static SHErrorCode _runSerialQueueLoop(struct SHSerialQueue *queue) {
	struct _queuedOp *node = NULL;
	SHErrorCode status = SH_NO_ERROR;
	while(_isRunning(queue)) {
		if(NULL == queue) goto fnExit;
		node = SH_syncedList_waitForPopFront(queue->opsQueue);
		if(NULL != node) {
			void *result = NULL;
			if((status = node->fn(node->fnArgs, &queue->queueStore, &result)) != SH_NO_ERROR) {
				goto fnErr;
			}
			if(result != &_voidResultSentinel) {
				SH_syncedList_pushBack(queue->resultQueue, result);
			}
			_opCleanup(node);
		}
	}
	fnExit:
		return status;
	fnErr:
		SH_notifyOfError(status, "There was an error in the serial queue loop");
		_freeUnusedItemsInQueue(queue);
		return status;
}


static void* _serialQueueLoopWrapper(void *args) {
	SHErrorCode status = SH_NO_ERROR;
	struct SHSerialQueue *queue = (struct SHSerialQueue *)args;
	if((status = _runSerialQueueLoop(queue)) != SH_NO_ERROR) { goto fnErr; }
	printf("thread ending\n");
	return NULL;
	fnErr:
		SH_notifyOfError(status, "There was an error in the serial queue loop");
		return NULL;
}


SHErrorCode SH_serialQueue_startLoop(struct SHSerialQueue *queue) {
	if(!queue) return SH_ILLEGAL_INPUTS;
	int32_t threadStatus = 0;
	SHErrorCode status = SH_NO_ERROR;
	char msg[65];
	if(_isRunning(queue)) {
		return SH_PRECONDITIONS_NOT_FULFILLED;
	}
	if((status = SH_syncedList_setIsSqueezeMode(queue->opsQueue, false))) { return status; }
	if((status = _setIsRunning(queue, true)) != SH_NO_ERROR) { return status; }
	if((threadStatus = pthread_create(&queue->serialThread, NULL, _serialQueueLoopWrapper, queue))
		!= SH_NO_ERROR)
	{
		status = SH_THREAD_ERROR;
		goto fnErr;
	}
	return status;
	fnErr:
		sprintf(msg, "pthread error: %d\n while creating thread object. \n", threadStatus);
		SH_notifyOfError(status, msg);
		return status;
}


static SHErrorCode _initMutexesAndConditions(struct SHSerialQueue *queue) {
	int32_t threadErr = 0;
	if((threadErr = pthread_mutex_init(&queue->isRunningLock, NULL))) {
		goto fnExit;
	}
	fnExit:
		return threadErr == 0 ? SH_NO_ERROR : SH_THREAD_ERROR;
}


struct SHSerialQueue * SH_serialQueue_init(void *initArgs, void (*initArgsCleanup)(void*)) {
	struct SHSerialQueue *queue = malloc(sizeof(struct SHSerialQueue));
	if(!queue) return NULL;
	*queue = (struct SHSerialQueue){
		.opsQueue = NULL,
		.resultQueue = NULL,
		.queueStore = { .queueRef = queue,
			.userItem = initArgs,
			.queueStoreCleanup = initArgsCleanup
		},
		.isRunning = false,
	};
	SHErrorCode status = SH_NO_ERROR;
	struct SHIterableWrapper *opsList = NULL;
	struct SHIterableWrapper *resultList = NULL;
	
	opsList = SH_iterable_init(&SH_LIST_FN_DEFS, NULL, (void (*)(void*))_opCleanup);
	if(!opsList) goto cleanupQueue;
	
	resultList = SH_iterable_init(&SH_LIST_FN_DEFS, NULL, NULL);
	if(!resultList) goto cleanupQueue;
	
	queue->opsQueue = SH_syncedList_init(opsList);
	queue->resultQueue = SH_syncedList_init(resultList);
	
	if((status = _initMutexesAndConditions(queue)) != SH_NO_ERROR) {
		goto cleanupQueue;
	}
	return queue;
	
	cleanupQueue:
		SH_notifyOfError(status, "Error while initializing mutexes and conditions");
		SH_iterable_cleanup(opsList);
		SH_iterable_cleanup(resultList);
		SH_serialQueue_cleanup(queue);
		return NULL;
}


void *SH_serialQueue_getUserItem(struct SHQueueStore *store) {
	return store->userItem;
}


void *SH_serialQueue_getUserItem2(struct SHSerialQueue *queue) {
	if(!queue) return NULL;
	return queue->queueStore.userItem;
}

bool SH_serialQueue_isLoopRunning(struct SHSerialQueue *queue) {
	if(!queue) return false;
	return _isRunning(queue) && !SH_syncedList_isSqueezeMode(queue->opsQueue);
}


SHErrorCode SH_serialQueue_pauseLoop(struct SHSerialQueue *queue) {
	if(!queue) return SH_ILLEGAL_INPUTS;
	SHErrorCode status = SH_NO_ERROR;
	status = _setIsRunning(queue, false);
	return status;
}


SHErrorCode SH_serialQueue_closeLoop(struct SHSerialQueue *queue) {
	if(!queue) return SH_ILLEGAL_INPUTS;
	if(!_isRunning(queue)) return SH_PRECONDITIONS_NOT_FULFILLED;
	SHErrorCode status = SH_NO_ERROR;
	if((status = _waitForQueueToEmpty(queue)) != SH_NO_ERROR) { }
	
	if((pthread_join(queue->serialThread, NULL)) != 0) {
		status |= SH_THREAD_ERROR;
	}
	if(status != SH_NO_ERROR) {
		SH_serialQueue_cleanup(queue);
	}
	return status;
}


SHErrorCode SH_serialQueue_waitToFinishOps(struct SHSerialQueue *queue) {
	if(!queue) return SH_ILLEGAL_INPUTS;
	if(!_isRunning(queue)) return SH_PRECONDITIONS_NOT_FULFILLED;
	SHErrorCode status = SH_NO_ERROR;
	if((status = SH_syncedList_runActionOnEmpty(queue->opsQueue, NULL, queue)) != SH_NO_ERROR) { goto waitErr; }
	goto fnExit;
	waitErr:
		SH_notifyOfError(status, "Could not wait for empty for some reason");
	fnExit:
		return status;
}


void SH_serialQueue_cleanup(struct SHSerialQueue *queue) {
	if(!queue) return;
	_freeUnusedItemsInQueue(queue);
	if(queue->queueStore.queueStoreCleanup) {
		queue->queueStore.queueStoreCleanup(&queue->queueStore.userItem);
	}
	pthread_mutex_destroy(&queue->isRunningLock);
	//don't need to free queueStore since it is not a pointer
	free(queue);
}
