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
	void (*itemCleanup)(void*);
};


struct SHDynamicArray *SH_dynamicArray_init(uint64_t startSize, void (*cleanup)(void*)) {
	uint64_t useRoom = startSize > 0 ? startSize : 10;
	struct SHDynamicArray *arr = malloc(sizeof(struct SHDynamicArray));
	arr->items = malloc(sizeof(void*) * useRoom);
	arr->length = 0;
	arr->roomLeft = useRoom;
	arr->itemCleanup = cleanup;
	return arr;
}


void SH_dynamicArray_push(struct SHDynamicArray *array, void *item) {
	if(array->length < array->roomLeft) {
		array->items[array->length] = item;
		array->length++;
	}
}


void* SH_dynamicArray_get(struct SHDynamicArray *array, uint64_t idx) {
	if(idx > array->length) return NULL;
	return array->items[idx];
}


void SH_dynamicArray_free(struct SHDynamicArray *array) {
	if(array->itemCleanup) {
		for(uint64_t idx = 0; idx < array->length; idx++) {
			array->itemCleanup(SH_dynamicArray_get(array, idx));
		}
	}
	free(array->items);
	free(array);
}
