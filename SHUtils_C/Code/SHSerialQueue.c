//
//  SHSerialQueue.c
//  SHUtils_C
//
//  Created by Joel Pridgen on 5/23/20.
//  Copyright © 2020 Joel Gillette. All rights reserved.
//

#include "SHSerialQueue.h"
#include <pthread.h>
#include <stdlib.h>
#include <errno.h>
#include <stdbool.h>
#include <assert.h>
#include <semaphore.h>

struct SHOpLinkedListNode;

struct SHOpLinkedListNode {
	SHErrorCode (*fn)(void*, struct SHQueueStore *store);
	void *fnArgs;
	void (*cleanupFn)(void*);
	struct SHOpLinkedListNode *next;
};

struct SHQueueStore {
	void *userItem;
	void (*queueStoreCleanup)(void *);
	struct SHSerialQueue *queueRef;
};

struct SHSerialQueue {
	struct SHOpLinkedListNode *opsBegin;
	struct SHOpLinkedListNode *opsEnd;
	struct SHQueueStore queueStore;
	pthread_t dbSerialThread;
	pthread_mutex_t lock;
	pthread_cond_t waitable;
	bool isRunning;
};



SHErrorCode SH_addOp(struct SHSerialQueue *queue,
	SHErrorCode (*fn)(void*, struct SHQueueStore *), void *fnArgs, void (*cleanupFn)(void*))
{
	assert(queue);
	assert(fn);
	SHErrorCode status = SH_NO_ERROR;
	struct SHOpLinkedListNode *opNode = malloc(sizeof(struct SHOpLinkedListNode));
	*opNode = (struct SHOpLinkedListNode){.fn = fn, .fnArgs = fnArgs, .cleanupFn = cleanupFn, .next = NULL };
	int32_t threadCode = 0;
	if((threadCode = pthread_mutex_lock(&queue->lock)) != 0) { goto threadErr; }
		if(!queue->isRunning) {
			goto canceled;
		}
		if(NULL == queue->opsBegin) {
			queue->opsBegin = opNode;
			goto fnExit;
		}
		if(NULL == queue->opsEnd) {
			queue->opsEnd = opNode;
			queue->opsBegin->next = queue->opsEnd;
			goto fnExit;
		}
		queue->opsEnd->next = opNode;
	fnExit:
		if((threadCode = pthread_cond_signal(&queue->waitable)) != SH_NO_ERROR) { goto threadErr; }
		if((threadCode = pthread_mutex_unlock(&queue->lock)) != 0) { goto threadErr; }
		return SH_NO_ERROR;
	canceled:
		//don't think we need to exit lock in this case because it should have been destroyed by now
		status = SH_EXTERNAL_BLOCK;
		goto cleanup;
	threadErr:
		SH_notifyOfError(SH_THREAD_ERROR, "failed to recieve mutex lock");
		status = SH_THREAD_ERROR;
	cleanup:
		free(opNode);
		if(cleanupFn) {
			cleanupFn(fnArgs);
		}
		return status;
}


struct _wrappedFunctionArgs {
	SHErrorCode (*wrappedFn)(void*, struct SHQueueStore *store);
	void *fnArgs;
	pthread_mutex_t lock;
	pthread_cond_t waitable;
};


static SHErrorCode _wrapForSync(void* arg, struct SHQueueStore *store) {
	SHErrorCode status = SH_NO_ERROR;
	struct _wrappedFunctionArgs *wrapped = (struct _wrappedFunctionArgs*)arg;
	if(pthread_mutex_lock(&wrapped->lock)) {
		status = SH_THREAD_ERROR;
		SH_notifyOfError(SH_THREAD_ERROR, "Failed to get lock in _wrappedForSync");
		goto fnExit;
	}
		
	status = wrapped->wrappedFn(wrapped->fnArgs, store);
	
	fnExit:
		if(pthread_cond_signal(&wrapped->waitable)) {
			status |= SH_THREAD_ERROR;
		}
		if(pthread_mutex_unlock(&wrapped->lock)) {
			status |= SH_THREAD_ERROR;
			SH_notifyOfError(SH_THREAD_ERROR, "failed to relase mutex synclock in _wrappedForSync");
		}
		return status;
}


SHErrorCode SH_addOpAndWait(struct SHSerialQueue *queue,
	SHErrorCode (*fn)(void*, struct SHQueueStore *), void *fnArgs, void (*cleanupFn)(void*))
{
	struct _wrappedFunctionArgs wrapped = {
		.wrappedFn = fn,
		.fnArgs = fnArgs,
		.lock = PTHREAD_MUTEX_INITIALIZER,
		.waitable = PTHREAD_COND_INITIALIZER
	};
	SHErrorCode status = SH_NO_ERROR;
	status = SH_addOp(queue, _wrapForSync, &wrapped, cleanupFn);
	if(pthread_cond_wait(&wrapped.waitable, &wrapped.lock)) {
		status |= SH_THREAD_ERROR;
	}
	if(pthread_mutex_unlock(&wrapped.lock)) {
		status |= SH_THREAD_ERROR;
		SH_notifyOfError(SH_THREAD_ERROR, "failed to relase mutex synclock in _wrappedForSync");
	}
	if(pthread_mutex_destroy(&wrapped.lock)) {
		status |= SH_THREAD_ERROR;
	}
	if(pthread_cond_destroy(&wrapped.waitable)) {
		status |= SH_THREAD_ERROR;
	}
	return status;
}


static SHErrorCode _getNextOp(struct SHSerialQueue *queue, struct SHOpLinkedListNode **next) {
	assert(queue);
	*next = NULL;
	int32_t threadCode = 0;
	if((threadCode = pthread_mutex_trylock(&queue->lock)) != 0) {
		if(threadCode != EBUSY) goto threadErr;
	}
	if(pthread_cond_wait(&queue->waitable, &queue->lock)) {
		goto threadErr;
	}
		*next = queue->opsBegin;
		if(NULL == *next) goto fnExit;
		queue->opsBegin = queue->opsBegin->next;
		if(queue->opsBegin == queue->opsEnd) queue->opsEnd = NULL;
	
	fnExit:
		if((threadCode = pthread_mutex_unlock(&queue->lock)) != 0) { goto threadErr; }
		return SH_NO_ERROR;
	threadErr:
		SH_notifyOfError(SH_THREAD_ERROR, "failed to recieve mutex lock");
		return SH_THREAD_ERROR;
}


static void _freeUnusedItemsInQueue(struct SHSerialQueue *queue) {
	if(NULL == queue) return;
	int32_t threadCode = 0;
	if((threadCode = pthread_mutex_lock(&queue->lock)) != 0) {
		SH_notifyOfError(SH_THREAD_ERROR, "Failed to get lock in cleanup function");
	}
	struct SHOpLinkedListNode *node = queue->opsBegin;
	while(NULL != node) {
		struct SHOpLinkedListNode *next = node->next;
		if(node->cleanupFn) {
			node->cleanupFn(node->fnArgs);
		}
		free(node);
		node = next;
	}
	queue->opsBegin = NULL;
	queue->opsEnd = NULL;
	queue->isRunning = false;
	if((threadCode = pthread_mutex_unlock(&queue->lock)) != 0) {
		SH_notifyOfError(SH_THREAD_ERROR, "Failed to get lock in cleanup function");
	}
	pthread_mutex_destroy(&queue->lock);
	pthread_cond_destroy(&queue->waitable);
}


static SHErrorCode _runSerialQueueLoop(struct SHSerialQueue *queue) {
	struct SHOpLinkedListNode *node = NULL;
	SHErrorCode status = SH_NO_ERROR;
	queue->isRunning = true;
	while(1) {
		if(NULL == queue) goto fnExit;
		if((status = _getNextOp(queue, &node)) != SH_NO_ERROR) { goto fnErrGetOp; }
		if(NULL != node) {
			if((status = node->fn(node->fnArgs, &queue->queueStore)) != SH_NO_ERROR) {
				goto fnErr;
			}
			if(node->cleanupFn) {
				node->cleanupFn(node->fnArgs);
			}
			free(node);
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


SHErrorCode SH_startSerialQueueLoop(struct SHSerialQueue *queue) {
	int32_t threadStatus = 0;
	if((threadStatus = pthread_create(&queue->dbSerialThread, NULL, _serialQueueLoopWrapper, queue))
		!= SH_NO_ERROR)
	{
		return SH_THREAD_ERROR;
	}
	return SH_NO_ERROR;
}


struct _initialSetupObj {
	void *(*getStoreItem)(void*);
	void (*storeCleanup)(void*);
	void *initArgs;
	void (*initArgsCleanup)(void*);
};


static SHErrorCode _queueInitialAction(void* arg, struct SHQueueStore *store) {
	struct _initialSetupObj *setupObject = (struct _initialSetupObj *)arg;
	if(setupObject->getStoreItem) {
		store->userItem = setupObject->getStoreItem(setupObject->initArgs);
		store->queueStoreCleanup = setupObject->storeCleanup;
	}
	return SH_NO_ERROR;
}


static void _initialActionCleanup(void *arg) {
	struct _initialSetupObj *setupObject = (struct _initialSetupObj *)arg;
	if(setupObject->initArgsCleanup) {
		setupObject->initArgsCleanup(setupObject->initArgs);
	}
	free(setupObject);
}


struct SHSerialQueue * SH_initSerialQueue(void *(*getStoreItem)(void*), void (*storeCleanup)(void*),
	void *initArgs, void (*initArgsCleanup)(void*))
{
	struct SHSerialQueue *queue = malloc(sizeof(struct SHSerialQueue));
	*queue = (struct SHSerialQueue){
		.opsBegin = NULL,
		.opsEnd = NULL,
		.queueStore = { .queueRef = queue },
		.lock = PTHREAD_MUTEX_INITIALIZER,
		.isRunning = false,
	};
	
	struct _initialSetupObj *setupObj = malloc(sizeof(struct _initialSetupObj));
	*setupObj = (struct _initialSetupObj){
		.getStoreItem = getStoreItem,
		.storeCleanup = storeCleanup,
		.initArgs = initArgs,
		.initArgsCleanup = initArgsCleanup,
	};
	
	if((SH_addOp(queue, _queueInitialAction, setupObj, _initialActionCleanup)) != SH_NO_ERROR) {
		SH_freeSerialQueue(queue);
		free(setupObj);
		return NULL;
	}
	return queue;
}


void *SH_getUserItemFromStore(struct SHQueueStore *store) {
	return store->userItem;
}


void SH_freeSerialQueue(struct SHSerialQueue *queue) {
	if(!queue) return;
	_freeUnusedItemsInQueue(queue);
	if(queue->queueStore.queueStoreCleanup) {
		queue->queueStore.queueStoreCleanup(queue->queueStore.userItem);
	}
	free(queue);
}
