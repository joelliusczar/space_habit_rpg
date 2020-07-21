//
//  SHSyncedList.c
//  SHUtils_C
//
//  Created by Joel Pridgen on 6/23/20.
//  Copyright © 2020 Joel Gillette. All rights reserved.
//

#include "SHSyncedList.h"
#include "SHErrorHandling.h"
#include "SHUtilConstants.h"
#include <pthread.h>
#include <stdlib.h>
#include <inttypes.h>

struct SHSyncedList {
	struct SHIterableWrapper *iterable;
	pthread_mutex_t iterableLock;
	pthread_mutex_t squeezeModeLock;
	pthread_cond_t hasItems;
	pthread_cond_t isEmpty;
	bool isSqueezeMode;
};


struct _nullWrapper {
	void *item;
};

static struct _nullWrapper _nullWraperObj = {0};

bool SH_syncedList_isSqueezeMode(struct SHSyncedList *list) {
	int32_t threadCode = 0;
	bool ans = true;
	char msg[75];
	if((threadCode = pthread_mutex_lock(&list->squeezeModeLock)) != 0) { goto fnErr; }
	ans = list->isSqueezeMode;
	if((threadCode = pthread_mutex_unlock(&list->squeezeModeLock)) != 0) { goto fnErr; }
	return ans;
	fnErr:
		sprintf(msg,"pthread error: %d\nerror while locking or unlocking mutex. \n", threadCode);
		SH_notifyOfError(SH_THREAD_ERROR, msg);
		return true;
}


SHErrorCode SH_syncedList_setIsSqueezeMode(struct SHSyncedList *list, bool value) {
	SHErrorCode status = SH_NO_ERROR;
	if(pthread_mutex_lock(&list->squeezeModeLock)) { return SH_THREAD_ERROR; }
	list->isSqueezeMode = value;
	if(pthread_mutex_unlock(&list->squeezeModeLock)) { return SH_THREAD_ERROR; }
	return status;
}


struct SHSyncedList *SH_syncedList_init(struct SHIterableWrapper *iterable) {
	struct SHSyncedList *list = malloc(sizeof(struct SHSyncedList));
	if(!list) return NULL;
	list->iterable = iterable;
	list->isSqueezeMode = false;
	int32_t threadCode = 0;
	char msg[80];
	if((threadCode = pthread_mutex_init(&list->iterableLock, NULL))) {
		goto cleanup;
	}
	if((threadCode = pthread_mutex_init(&list->squeezeModeLock, NULL))) {
		goto cleanup;
	}
	if((threadCode = pthread_cond_init(&list->hasItems, NULL))) {
		goto cleanup;
	}
	if((threadCode = pthread_cond_init(&list->isEmpty, NULL))) {
		goto cleanup;
	}
	return list;
	cleanup:
		SH_syncedList_cleanup(list);
		sprintf(msg,"pthread error: %d\nerror while initializing mutex or condition. \n", threadCode);
		SH_notifyOfError(SH_THREAD_ERROR, msg);
		return NULL;
}


SHErrorCode SH_syncedList_pushBack(struct SHSyncedList *list, void *item) {
	if(!list) return SH_ILLEGAL_INPUTS;
	int32_t threadCode = 0;
	SHErrorCode status = SH_NO_ERROR;
	char msg[95];
	if(SH_syncedList_isSqueezeMode(list)) {
		status = SH_EXTERNAL_BLOCK;
		goto fnExit;
	}
	if((threadCode = pthread_mutex_lock(&list->iterableLock)) != 0) { goto threadErr; }
	if(item) {
		if((status = SH_iterable_addItem(list->iterable, item)) != SH_NO_ERROR) { goto cleanupLocks; }
	}
	else {
		//SHSyncedList chokes on nulls, and will deadlock
		//so, we're adding a placeholder instead
		if((status = SH_iterable_addItem(list->iterable, &_nullWraperObj)) != SH_NO_ERROR) { goto cleanupLocks; }
	}
	cleanupLocks:
		if((threadCode = pthread_cond_signal(&list->hasItems)) != 0) { goto threadErr; }
		if((threadCode = pthread_mutex_unlock(&list->iterableLock)) != 0) { goto threadErr; }
	goto fnExit;
	threadErr:
		status |= SH_THREAD_ERROR;
		sprintf(msg,"pthread error: %d\nerror while locking, unlocking mutex or signaling condidtion.", threadCode);
		SH_notifyOfError(status, msg);
	fnExit:
		return status;
}


void *SH_syncedList_popFront(struct SHSyncedList *list) {
	if(!list) return NULL;
	int32_t threadCode = 0;
	void *item = NULL;
	char msg[95];
	if((threadCode = pthread_mutex_lock(&list->iterableLock)) != 0) { goto threadErr; }
	item = SH_iterable_popFront(list->iterable);
	if(SH_iterable_count(list->iterable) < 1) {
		if((threadCode = pthread_cond_signal(&list->isEmpty)) != 0) {
			SH_notifyOfError(SH_THREAD_ERROR, "thread Failure in popFont");
			goto threadErrSignal;
		}
	}
	if((threadCode = pthread_mutex_unlock(&list->iterableLock)) != 0) { goto threadErr; }
	if(&_nullWraperObj == item) {
		item = NULL;
	}
	return item;
	threadErrSignal:
		pthread_mutex_unlock(&list->iterableLock);
	threadErr:
		sprintf(msg,"pthread error: %d\nerror while locking, unlocking mutex or signaling condidtion.", threadCode);
		SH_notifyOfError(SH_THREAD_ERROR, msg);
		goto fnExit;
	fnExit:
		return NULL;
}


void *SH_syncedList_waitForPopFront(struct SHSyncedList *list) {
	if(!list) return NULL;
	int32_t threadCode = 0;
	void *item = NULL;
	char msg[95];
	if((threadCode = pthread_mutex_lock(&list->iterableLock)) != 0) { goto threadErr; }
	while(!(item = SH_iterable_popFront(list->iterable))) {
		if(SH_iterable_count(list->iterable) < 1) {
			if((threadCode = pthread_cond_signal(&list->isEmpty)) != 0) {
				SH_notifyOfError(SH_THREAD_ERROR, "thread Failure in waitForPopFront");
				goto threadErrSignal;
			}
		}
		if(SH_syncedList_isSqueezeMode(list)) {
			break;
		}
		if((threadCode = pthread_cond_wait(&list->hasItems, &list->iterableLock)) != 0) { goto threadErr; }
	}
	if((threadCode = pthread_mutex_unlock(&list->iterableLock)) != 0) { goto threadErr; }
	if(&_nullWraperObj == item) {
		item = NULL;
	}
	return item;
	threadErrSignal:
		pthread_mutex_unlock(&list->iterableLock);
	threadErr:
		sprintf(msg,"pthread error: %d\nerror while locking, unlocking mutex or signaling condidtion.", threadCode);
		SH_notifyOfError(SH_THREAD_ERROR, msg);
		goto fnExit;
	fnExit:
		return NULL;
}


void *SH_syncedList_popBack(struct SHSyncedList *list) {
	if(!list) return NULL;
	int32_t threadCode = 0;
	void *item = NULL;
	char msg[95];
	if((threadCode = pthread_mutex_lock(&list->iterableLock)) != 0) { goto threadErr; }
	item = SH_iterable_popBack(list->iterable);
	if(SH_iterable_count(list->iterable) < 1) {
		if((threadCode = pthread_cond_signal(&list->isEmpty)) != 0) {
			SH_notifyOfError(SH_THREAD_ERROR, "thread Failure in popBack");
			goto threadErrSignal;
		}
	}
	if((threadCode = pthread_mutex_unlock(&list->iterableLock)) != 0) { goto threadErr; }
	if(&_nullWraperObj == item) {
		item = NULL;
	}
	return item;
	threadErrSignal:
		pthread_mutex_unlock(&list->iterableLock);
	threadErr:
		sprintf(msg,"pthread error: %d\nerror while locking, unlocking mutex or signaling condidtion.", threadCode);
		SH_notifyOfError(SH_THREAD_ERROR, msg);
		goto fnExit;
	fnExit:
		return NULL;
}


void *SH_syncedList_getBack(struct SHSyncedList *list) {
	if(!list) return NULL;
	int32_t threadCode = 0;
	void *item = NULL;
	char msg[80];
	if((threadCode = pthread_mutex_lock(&list->iterableLock)) != 0) { goto threadErr; }
	item = SH_iterable_getBack(list->iterable);
	if((threadCode = pthread_mutex_unlock(&list->iterableLock)) != 0) { goto threadErr; }
	if(&_nullWraperObj == item) {
		item = NULL;
	}
	return item;
	threadErr:
		sprintf(msg,"pthread error: %d\nerror while locking or unlocking mutex.", threadCode);
		SH_notifyOfError(SH_THREAD_ERROR, msg);
		return NULL;
}


void *SH_syncedList_getFront(struct SHSyncedList *list) {
	if(!list) return NULL;
	int32_t threadCode = 0;
	void *item = NULL;
	char msg[80];
	if((threadCode = pthread_mutex_lock(&list->iterableLock)) != 0) { goto threadErr; }
	item = SH_iterable_getFront(list->iterable);
	if((threadCode = pthread_mutex_unlock(&list->iterableLock)) != 0) { goto threadErr; }
	if(&_nullWraperObj == item) {
		item = NULL;
	}
	return item;
	threadErr:
		sprintf(msg,"pthread error: %d\nerror while locking or unlocking mutex.", threadCode);
		SH_notifyOfError(SH_THREAD_ERROR, msg);
		return NULL;
}


uint64_t SH_syncedList_count(struct SHSyncedList *list) {
	if(!list) return NULL;
	int32_t threadCode = 0;
	uint64_t count = SH_NOT_FOUND;
	char msg[80];
	if((threadCode = pthread_mutex_lock(&list->iterableLock)) != 0) { goto threadErr; }
	count = SH_iterable_count(list->iterable);
	if((threadCode = pthread_mutex_unlock(&list->iterableLock)) != 0) { goto threadErr; }
	return count;
	threadErr:
		sprintf(msg,"pthread error: %d\nerror while locking or unlocking mutex.", threadCode);
		SH_notifyOfError(SH_THREAD_ERROR, msg);
		return count;
}

SHErrorCode SH_syncedList_runActionOnEmpty(struct SHSyncedList *list, SHErrorCode (*onEmpty)(void *), void* fnArgs) {
	int32_t threadCode = 0;
	SHErrorCode status = SH_NO_ERROR;
	char msg[100];
	if((threadCode = pthread_mutex_lock(&list->iterableLock)) != 0) { goto threadCodeExit; }
	while(SH_iterable_count(list->iterable) > 0) {
		if((threadCode = pthread_cond_wait(&list->isEmpty, &list->iterableLock)) != 0) {
			goto threadCodeExit;
		}
	}
	if(onEmpty) {
		status = onEmpty(fnArgs);
	}
	if((threadCode = pthread_mutex_unlock(&list->iterableLock)) != 0) { goto threadCodeExit; }
	goto fnExit;
	threadCodeExit:
		status |= SH_THREAD_ERROR;
		SH_notifyOfError(status, "There was an error in runActionOnEmpty");
		sprintf(msg,"pthread error: %d\nerror while locking, or unlocking mutex or while waiting for signal.", threadCode);
		SH_notifyOfError(SH_THREAD_ERROR, msg);
	fnExit:
		return status;
}


SHErrorCode SH_syncedList_stirHasItems(struct SHSyncedList *list) {
	if(!list) return SH_ILLEGAL_INPUTS;
	int32_t threadCode = 0;
	SHErrorCode status = SH_NO_ERROR;
	char msg[95];
	if((threadCode = pthread_mutex_lock(&list->iterableLock)) != 0) { goto threadErr; }
	if((threadCode = pthread_cond_signal(&list->hasItems)) != 0) { goto threadErr; }
	if((threadCode = pthread_mutex_unlock(&list->iterableLock)) != 0) { goto threadErr; }
	goto fnExit;
	threadErr:
		status |= SH_THREAD_ERROR;
		sprintf(msg,"pthread error: %d\nerror while locking, unlocking mutex or signaling condidtion.", threadCode);
		SH_notifyOfError(status, msg);
	fnExit:
		return status;
}


void SH_syncedList_cleanup(struct SHSyncedList *list) {
	if(!list) return;
	pthread_mutex_lock(&list->iterableLock);
	SH_iterable_cleanup(list->iterable);
	pthread_mutex_unlock(&list->iterableLock);
	
	pthread_mutex_destroy(&list->iterableLock);
	pthread_mutex_destroy(&list->squeezeModeLock);
	pthread_cond_destroy(&list->hasItems);
	pthread_cond_destroy(&list->isEmpty);
	free(list);
}


