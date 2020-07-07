//
//  SHDynamicArray.c
//  SHUtils_C
//
//  Created by Joel Pridgen on 6/3/20.
//  Copyright © 2020 Joel Gillette. All rights reserved.
//

#include "SHDynamicArray.h"
#include <stdlib.h>

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
	uint64_t useRoom = startSize > 0 ? startSize : 10;
	struct SHDynamicArray *arr = malloc(sizeof(struct SHDynamicArray));
	arr->items = malloc(sizeof(void*) * useRoom);
	arr->length = 0;
	arr->roomLeft = useRoom;
	arr->itemCleanup = cleanup;
	return arr;
}


static void _expandRoomLeft(struct SHDynamicArray *array) {
	void **replacement = malloc(sizeof(void*) * (array->roomLeft * 2));
	for(uint64_t idx = 0; idx < array->length; idx++) {
		replacement[idx] = array->items[idx];
	}
	free(array->items);
	array->items = replacement;
	array->roomLeft *= 2;
}


void SH_dynamicArray_push(struct SHDynamicArray *array, void *item) {
	if(array->length >= array->roomLeft) {
		_expandRoomLeft(array);
	}
	array->items[array->length] = item;
	array->length++;
	
}


void* SH_dynamicArray_get(struct SHDynamicArray *array, uint64_t idx) {
	if(!array) return NULL;
	if(idx > array->length) return NULL;
	return array->items[idx];
}


void SH_dynamicArray_remove(struct SHDynamicArray *array, uint64_t idx) {
	if(!array) return;
	if(idx > array->length) return;
	void *item = array->items[idx];
	if(array->itemCleanup) {
		array->itemCleanup(item);
	}
	for(uint64_t shiftIdx = idx; shiftIdx < array->length -1; shiftIdx++) {
		array->items[shiftIdx] = array->items[shiftIdx + 1];
	}
}


void SH_dynamicArray_popBack(struct SHDynamicArray *array) {
	SH_dynamicArray_remove(array, array->length - 1);
}


void SH_dynamicArray_popFront(struct SHDynamicArray *array) {
	SH_dynamicArray_remove(array, 0);
}


void SH_dynamicArray_insert(struct SHDynamicArray *array, uint64_t idx, void *item) {
	if(!array) return;
	if(idx > array->length + 1) return;
	if(array->length >= array->roomLeft) {
		_expandRoomLeft(array);
	}
	for(uint64_t shiftIdx = array->length; shiftIdx > idx; shiftIdx--) {
		array->items[shiftIdx] = array->items[shiftIdx - 1];
	}
	array->items[idx] = item;
}


void SH_dynamicArray_replace(struct SHDynamicArray *array, uint64_t idx, void *item) {
	if(!array) return;
	if(idx >= array->length) return;
	void *olditem = array->items[idx];
	if(array->itemCleanup) {
		array->itemCleanup(olditem);
	}
	array->items[idx] = item;
}


uint64_t SH_dynamicArray_count(struct SHDynamicArray *array) {
	if(!array) return 0;
	return array->length;
}


void SH_dynamicArray_getBack(struct SHDynamicArray *array) {
	if(!array) return;
	SH_dynamicArray_get(array, array->length - 1);
}


void SH_dynamicArray_getFront(struct SHDynamicArray *array) {
	SH_dynamicArray_get(array, 0);
}


void SH_dynamicArray_free(struct SHDynamicArray **arrayP2) {
	if(!arrayP2) return;
	struct SHDynamicArray *array = *arrayP2;
	if(!array) return;
	if(array->itemCleanup) {
		for(uint64_t idx = 0; idx < array->length; idx++) {
			SH_dynamicArray_popBack(array);
		}
	}
	free(array->items);
	free(array);
	*arrayP2 = NULL;
}


struct SHDynamicArrayIterator *SH_dynamicArrayIterator_init(struct SHDynamicArray *array) {
	struct SHDynamicArrayIterator *iter = malloc(sizeof(struct SHDynamicArrayIterator));
	iter->array = array;
	iter->idx = 0;
	return iter;
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
