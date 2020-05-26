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

struct SHOpNode;

struct SHOpNode {
  SHErrorCode (*fn)(void*);
	void *fnArgs;
	void (*cleanupFn)(void*);
  struct SHOpNode *next;
};

struct SHSerialQueue {
	struct SHOpNode *opsBegin;
	struct SHOpNode *opsEnd;
	pthread_mutex_t lock;
	bool isCanceled;
};


SHErrorCode SH_addOpToSerialQueue(struct SHSerialQueue *queue, SHErrorCode (*fn)(void*), void *fnArgs,
	void (*cleanupFn)(void*))
{
	assert(queue);
	assert(fn);
	struct SHOpNode *opNode = malloc(sizeof(struct SHOpNode));
	*opNode = (struct SHOpNode){.fn = fn, .fnArgs = fnArgs, .cleanupFn = cleanupFn, .next = NULL };
	int32_t threadCode = 0;
	if((threadCode = pthread_mutex_lock(&queue->lock)) != 0) { goto threadErr; }
		if(queue->isCanceled) {
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
		if((threadCode = pthread_mutex_unlock(&queue->lock)) != 0) { goto threadErr; }
		return SH_NO_ERROR;
	canceled:
		free(opNode);
		free(fnArgs);
		//don't think we need to exit lock in this case because it should have been destroyed by now
		return SH_EXTERNAL_BLOCK;
	threadErr:
		free(opNode);
		SH_notifyOfError(SH_THREAD_ERROR, "failed to recieve mutex lock");
		return SH_THREAD_ERROR;
}


static SHErrorCode _getNextOp(struct SHSerialQueue *queue, struct SHOpNode **next) {
	assert(queue);
	*next = NULL;
	int32_t threadCode = 0;
	if((threadCode = pthread_mutex_trylock(&queue->lock)) != 0) {
		if(threadCode != EBUSY) goto threadErr;
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
	struct SHOpNode *node = queue->opsBegin;
	while(NULL != node) {
		struct SHOpNode *next = node->next;
		if(node->cleanupFn) {
			node->cleanupFn(node->fnArgs);
		}
		free(node);
		node = next;
	}
	queue->opsBegin = NULL;
	queue->opsEnd = NULL;
	queue->isCanceled = true;
	if((threadCode = pthread_mutex_unlock(&queue->lock)) != 0) {
		SH_notifyOfError(SH_THREAD_ERROR, "Failed to get lock in cleanup function");
	}
	pthread_mutex_destroy(&queue->lock);
}


SHErrorCode SH_startSerialQueueLoop(struct SHSerialQueue *queue) {
	struct SHOpNode *node = NULL;
	SHErrorCode status = SH_NO_ERROR;
  while(1) {
		if(NULL == queue) goto fnExit;
		if((status = _getNextOp(queue, &node)) != SH_NO_ERROR) { goto fnErrGetOp; }
		if(NULL != node) {
			if((status = node->fn(node->fnArgs)) != SH_NO_ERROR) {
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


struct SHSerialQueue * SH_initSerialQueue() {
	struct SHSerialQueue *queue = malloc(sizeof(struct SHSerialQueue));
	*queue = (struct SHSerialQueue){
		.opsBegin = NULL,
		.opsEnd = NULL,
		.lock = PTHREAD_MUTEX_INITIALIZER,
		.isCanceled = false
	};
	return queue;
}


void SH_freeSerialQueue(struct SHSerialQueue *queue) {
	_freeUnusedItemsInQueue(queue);
	free(queue);
}
