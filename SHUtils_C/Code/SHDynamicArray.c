//
//  SHDynamicArray.c
//  SHUtils_C
//
//  Created by Joel Pridgen on 6/3/20.
//  Copyright © 2020 Joel Gillette. All rights reserved.
//

#include "SHDynamicArray.h"
#include <stdlib.h>
#include <stdbool.h>


const struct SHIterableSetup arraySetup = {
	.initializer = (void* (*)(int32_t (*)(void*, void*), void (*)(void**)))SH_dynamicArray_init2,
	.fnSetup = SH_iterable_loadArrayFuncs,
	.backendCleanup = (void (*)(void**))SH_dynamicArray_cleanup,
	.backendCleanupIgnoreItems = (void (*)(void**))SH_dynamicArray_cleanupIgnoreItems
};


struct SHDynamicArray {
	void **items;
	uint64_t length;
	uint64_t roomLeft;
	void (*itemCleanup)(void**);
};


struct SHDynamicArray *SH_dynamicArray_init(void (*cleanup)(void**)) {
	return SH_dynamicArray_init2(NULL, cleanup);
}


struct SHDynamicArray *SH_dynamicArray_init2(int32_t (*sortingFn)(void*, void*), void (*cleanup)(void**)) {
	return SH_dynamicArray_init3(10, sortingFn, cleanup);
}


struct SHDynamicArray *SH_dynamicArray_init3(uint64_t startSize, int32_t (*sortingFn)(void*, void*),
	void (*cleanup)(void**))
{
	(void)sortingFn;
	uint64_t useRoom = startSize > 0 ? startSize : 16;
	struct SHDynamicArray *arr = malloc(sizeof(struct SHDynamicArray));
	if(!arr) return NULL;
	arr->items = malloc(sizeof(void*) * useRoom);
	if(!arr->items) goto cleanup;
	arr->length = 0;
	arr->roomLeft = useRoom;
	arr->itemCleanup = cleanup;
	goto fnExit;
	cleanup:
		SH_dynamicArray_cleanup(&arr);
		return NULL;
	fnExit:
		return arr;
}


static SHErrorCode _expandRoomLeft(struct SHDynamicArray *array) {
	SHErrorCode status = SH_NO_ERROR;
	void **replacement = malloc(sizeof(void*) * (array->roomLeft * 2));
	if(!replacement) goto allocErr;
	for(uint64_t idx = 0; idx < array->length; idx++) {
		replacement[idx] = array->items[idx];
	}
	free(array->items);
	array->items = replacement;
	array->roomLeft *= 2;
	
	goto fnExit;
	allocErr:
		status = SH_ALLOC_NO_MEM;
		SH_notifyOfError(SH_ALLOC_NO_MEM, "Failed to allocate memory in _expandRoomLeft");
	fnExit:
		return status;
}


SHErrorCode SH_dynamicArray_push(struct SHDynamicArray *array, void *item) {
	if(!array) return SH_ILLEGAL_INPUTS;
	SHErrorCode status = SH_NO_ERROR;
	if(array->length >= array->roomLeft) {
		if((status = _expandRoomLeft(array)) != SH_NO_ERROR) { goto fnExit; }
	}
	array->items[array->length] = item;
	array->length++;
	fnExit:
		return status;
}


void* SH_dynamicArray_get(struct SHDynamicArray *array, uint64_t idx) {
	if(!array) return NULL;
	if(idx > array->length) return NULL;
	return array->items[idx];
}


static SHErrorCode _remove(struct SHDynamicArray *array, uint64_t idx, bool allowCleanup) {
	void *item = array->items[idx];
	if(array->itemCleanup && allowCleanup) {
		array->itemCleanup(item);
	}
	for(uint64_t shiftIdx = idx; shiftIdx < array->length -1; shiftIdx++) {
		array->items[shiftIdx] = array->items[shiftIdx + 1];
	}
	return SH_NO_ERROR;
}


SHErrorCode SH_dynamicArray_remove(struct SHDynamicArray *array, uint64_t idx) {
	if(!array) return SH_ILLEGAL_INPUTS;
	if(idx > array->length) return SH_ILLEGAL_INPUTS;
	return _remove(array, idx, true);
}


void* SH_dynamicArray_popBack(struct SHDynamicArray *array) {
	if(!array) return NULL;
	void *item = array->items[array->length - 1];
	_remove(array, array->length - 1, false);
	return item;
}


void* SH_dynamicArray_popFront(struct SHDynamicArray *array) {
	if(!array) return NULL;
	void *item = array->items[0];
	_remove(array, 0, false);
	return item;
}


SHErrorCode SH_dynamicArray_insert(struct SHDynamicArray *array, uint64_t idx, void *item) {
	if(!array) return SH_ILLEGAL_INPUTS;
	if(idx > array->length + 1) return SH_ILLEGAL_INPUTS;
	
	SHErrorCode status = SH_NO_ERROR;
	if(array->length >= array->roomLeft) {
		if((status = _expandRoomLeft(array)) != SH_NO_ERROR) {
			goto fnExit;
		}
	}
	for(uint64_t shiftIdx = array->length; shiftIdx > idx; shiftIdx--) {
		array->items[shiftIdx] = array->items[shiftIdx - 1];
	}
	array->items[idx] = item;
	fnExit:
		return status;
}


SHErrorCode SH_dynamicArray_replace(struct SHDynamicArray *array, uint64_t idx, void *item) {
	if(!array) return SH_ILLEGAL_INPUTS;
	if(idx >= array->length) return SH_ILLEGAL_INPUTS;
	
	void *olditem = array->items[idx];
	if(array->itemCleanup) {
		array->itemCleanup(olditem);
	}
	array->items[idx] = item;
	return SH_NO_ERROR;
}


uint64_t SH_dynamicArray_count(struct SHDynamicArray *array) {
	if(!array) return 0;
	return array->length;
}


void* SH_dynamicArray_getBack(struct SHDynamicArray *array) {
	if(!array) return NULL;
	return SH_dynamicArray_get(array, array->length - 1);
}


void* SH_dynamicArray_getFront(struct SHDynamicArray *array) {
	return SH_dynamicArray_get(array, 0);
}


static void _cleanupArray(struct SHDynamicArray *array, void (*itemCleanup)(void**)) {
	if(itemCleanup) {
		for(uint64_t idx = 0; idx < array->length; idx++) {
			void *item = SH_dynamicArray_popBack(array);
			itemCleanup(&item);
		}
	}
	free(array->items);
	free(array);
}


void SH_dynamicArray_cleanup(struct SHDynamicArray **arrayP2) {
	if(!arrayP2) return;
	struct SHDynamicArray *array = *arrayP2;
	if(!array) return;
	_cleanupArray(array, array->itemCleanup);
	*arrayP2 = NULL;
}


void SH_dynamicArray_cleanupIgnoreItems(struct SHDynamicArray **arrayP2) {
	if(!arrayP2) return;
	struct SHDynamicArray *array = *arrayP2;
	if(!array) return;
	_cleanupArray(array, NULL);
	*arrayP2 = NULL;
}


SHErrorCode SH_iterable_loadArrayFuncs(struct SHIterableWrapperFuncs *funcsObj) {
	funcsObj->count = (uint64_t (*)(void*))SH_dynamicArray_count;
	funcsObj->addItem = (SHErrorCode (*)(void*, void*))SH_dynamicArray_push;
	funcsObj->getItemAtIdx = (void *(*)(void*, uint64_t))SH_dynamicArray_get;
	funcsObj->getFront = (void* (*)(void*))SH_dynamicArray_getFront;
	funcsObj->popFront = (void* (*)(void*))SH_dynamicArray_popFront;
	funcsObj->getBack = (void* (*)(void*))SH_dynamicArray_getBack;
	funcsObj->popBack = (void* (*)(void*))SH_dynamicArray_popBack;
	funcsObj->deleteItemAtIdx = (SHErrorCode (*)(void*, uint64_t))SH_dynamicArray_remove;
	funcsObj->iteratorInit = (void* (*)(void*))SH_dynamicArrayIterator_init;
	funcsObj->iteratorNext = (void* (*)(void**))SH_dynamicArrayIterator_next;
	funcsObj->cleanup = (void (*)(void**))SH_dynamicArray_cleanup;
	funcsObj->cleanupIgnoreItems = (void (*)(void**))SH_dynamicArray_cleanupIgnoreItems;
	return SH_NO_ERROR;
}


struct SHDynamicArrayIterator *SH_dynamicArrayIterator_init(struct SHDynamicArray *array) {
	if(!array) return NULL;
	struct SHDynamicArrayIterator *iter = malloc(sizeof(struct SHDynamicArrayIterator));
	if(!iter) goto allocErr;
	iter->array = array;
	iter->idx = 0;
	return iter;
	allocErr:
		SH_notifyOfError(SH_ALLOC_NO_MEM, "Failed to allocate in SH_dynamicArrayIterator_init");
		return NULL;;
}


void *SH_dynamicArrayIterator_next(struct SHDynamicArrayIterator **iterP2) {
	if(!iterP2) return NULL;
	struct SHDynamicArrayIterator *iter = *iterP2;
	if(!iter) return NULL;
	if(iter->idx >= iter->array->length) {
		free(iter);
		*iterP2 = NULL;
		return NULL;
	}
	return iter->array->items[iter->idx++];
}
