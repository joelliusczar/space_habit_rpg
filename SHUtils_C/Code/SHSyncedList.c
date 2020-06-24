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
	pthread_mutex_t lock;
	pthread_cond_t hasItems;
	pthread_cond_t isEmpty;
};


struct SHSyncedList *SH_syncedList_init(struct SHIterableWrapper *iterable) {
	struct SHSyncedList *list = malloc(sizeof(struct SHSyncedList));
	if(!list) return NULL;
	list->iterable = iterable;
	int32_t threadErr = 0;
	if((threadErr = pthread_mutex_init(&list->lock, NULL))) {
		goto cleanup;
	}
	if((threadErr = pthread_cond_init(&list->hasItems, NULL))) {
		goto cleanup;
	}
	if((threadErr = pthread_cond_init(&list->isEmpty, NULL))) {
		goto cleanup;
	}
	return list;
	cleanup:
		SH_syncedList_cleanup(&list);
		return NULL;
}


void SH_syncedList_pushBack(struct SHSyncedList *list, void *item) {
	if(!list) return;
	int32_t threadErr = 0;
	if((threadErr = pthread_mutex_lock(&list->lock)) != SH_NO_ERROR) { goto fnExit; }
	SH_iterable_addItem(list->iterable, item);
	if((threadErr = pthread_cond_signal(&list->hasItems)) != SH_NO_ERROR) { goto fnExit; }
	if((threadErr = pthread_mutex_unlock(&list->lock)) != SH_NO_ERROR) { goto fnExit; }
	fnExit:
		return;
}


void *SH_syncedList_popFront(struct SHSyncedList *list) {
	if(!list) return NULL;
	int32_t threadErr = 0;
	void *item = NULL;
	if((threadErr = pthread_mutex_lock(&list->lock)) != SH_NO_ERROR) { goto fnExit; }
	item = SH_iterable_popFront(list->iterable);
	if(SH_iterable_count(list->iterable) < 1) {
		if((threadErr = pthread_cond_signal(&list->isEmpty)) != SH_NO_ERROR) { goto fnExit; }
	}
	if((threadErr = pthread_mutex_unlock(&list->lock)) != SH_NO_ERROR) { goto fnExit; }
	return item;
	fnExit:
		return NULL;
}


void *SH_syncedList_waitForPopFront(struct SHSyncedList *list) {
	if(!list) return NULL;
	int32_t threadErr = 0;
	void *item = NULL;
	if((threadErr = pthread_mutex_lock(&list->lock)) != SH_NO_ERROR) { goto fnExit; }
	while((item = SH_iterable_popFront(list->iterable);)) {
		if((threadErr = pthread_cond_wait(&list->hasItems, &list->lock)) != SH_NO_ERROR) { goto fnExit; }
	}
	if((threadErr = pthread_mutex_unlock(&list->lock)) != SH_NO_ERROR) { goto fnExit; }
	return item;
	fnExit:
		return NULL;
}


void *SH_syncedList_popBack(struct SHSyncedList *list) {
	if(!list) return NULL;
	int32_t threadErr = 0;
	void *item = NULL;
	if((threadErr = pthread_mutex_lock(&list->lock)) != SH_NO_ERROR) { goto fnExit; }
	item = SH_iterable_popBack(list->iterable);
	if(SH_iterable_count(list->iterable) < 1) {
		if((threadErr = pthread_cond_signal(&list->isEmpty)) != SH_NO_ERROR) { goto fnExit; }
	}
	if((threadErr = pthread_mutex_unlock(&list->lock)) != SH_NO_ERROR) { goto fnExit; }
	return item;
	fnExit:
		return NULL;
}


void *SH_syncedList_getBack(struct SHSyncedList *list) {
	if(!list) return NULL;
	int32_t threadErr = 0;
	void *item = NULL;
	if((threadErr = pthread_mutex_lock(&list->lock)) != SH_NO_ERROR) { goto fnExit; }
	item = SH_iterable_getBack(list->iterable);
	if((threadErr = pthread_mutex_unlock(&list->lock)) != SH_NO_ERROR) { goto fnExit; }
	return item;
	fnExit:
		return NULL;
}


void *SH_syncedList_getFront(struct SHSyncedList *list) {
	if(!list) return NULL;
	int32_t threadErr = 0;
	void *item = NULL;
	if((threadErr = pthread_mutex_lock(&list->lock)) != SH_NO_ERROR) { goto fnExit; }
	item = SH_iterable_getFront(list->iterable);
	if((threadErr = pthread_mutex_unlock(&list->lock)) != SH_NO_ERROR) { goto fnExit; }
	return item;
	fnExit:
		return NULL;
}


uint64_t SH_syncedList_count(struct SHSyncedList *list) {
	if(!list) return NULL;
	int32_t threadErr = 0;
	uint64_t count = SH_NOT_FOUND;
	if((threadErr = pthread_mutex_lock(&list->lock)) != SH_NO_ERROR) { goto fnExit; }
	count = SH_iterable_count(list->iterable);
	if((threadErr = pthread_mutex_unlock(&list->lock)) != SH_NO_ERROR) { goto fnExit; }
	return count;
	fnExit:
		return count;
}


void SH_syncedList_waitForEmpty(struct SHSyncedList *list) {
	if((threadErr = pthread_mutex_lock(&list->lock)) != SH_NO_ERROR) { goto fnExit; }
	if((threadErr = pthread_cond_wait(&list->isEmpty, &list->lock)) != SH_NO_ERROR) { goto fnExit; }
	if((threadErr = pthread_mutex_unlock(&list->lock)) != SH_NO_ERROR) { goto fnExit; }
	fnExit:
		return;
}


void SH_syncedList_cleanup(struct SHSyncedList **listP2) {
	if(!listP2) return;
	struct SHSyncedList *list = *listP2;
	if(!list) return;
	SH_iterable_cleanup(&list->iterable);
	pthread_mutex_destroy(&list->lock);
	pthread_cond_destroy(&list->hasItems);
	pthread_cond_destroy(&list->isEmpty);
	free(list);
	*listP2 = NULL;
}


