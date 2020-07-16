//
//  SHDynamicArray.h
//  SHUtils_C
//
//  Created by Joel Pridgen on 6/3/20.
//  Copyright © 2020 Joel Gillette. All rights reserved.
//

#ifndef SHDynamicArray_h
#define SHDynamicArray_h

#include "SHErrorHandling.h"
#include "SHDynamicArray.h"
#include <stdio.h>
#include <inttypes.h>

struct SHDynamicArray;

struct SHDynamicArrayIterator {
	struct SHDynamicArray *array;
	uint64_t idx;
};

struct SHDynamicArray *SH_dynamicArray_init(void (*cleanup)(void**));
struct SHDynamicArray *SH_dynamicArray_init2(int32_t (*sortingFn)(void*, void*), void (*cleanup)(void**));
struct SHDynamicArray *SH_dynamicArray_init3(uint64_t startSize, int32_t (*sortingFn)(void*, void*),
	void (*cleanup)(void**));
uint64_t SH_dynamicArray_count(struct SHDynamicArray *array);
SHErrorCode SH_dynamicArray_push(struct SHDynamicArray *array, void *item);
void* SH_dynamicArray_popBack(struct SHDynamicArray *array);
void* SH_dynamicArray_popFront(struct SHDynamicArray *array);
void* SH_dynamicArray_getBack(struct SHDynamicArray *array);
void* SH_dynamicArray_getFront(struct SHDynamicArray *array);
void* SH_dynamicArray_get(struct SHDynamicArray *array, uint64_t idx);
SHErrorCode SH_dynamicArray_remove(struct SHDynamicArray *array, uint64_t idx);
SHErrorCode SH_dynamicArray_insert(struct SHDynamicArray *array, uint64_t idx, void *item);
SHErrorCode SH_dynamicArray_replace(struct SHDynamicArray *array, uint64_t idx, void *item);
void SH_dynamicArray_cleanup(struct SHDynamicArray **arrayP2);
void SH_dynamicArray_cleanupIgnoreItems(struct SHDynamicArray **arrayP2);

SHErrorCode SH_iterable_loadArrayFuncs(struct SHIterableWrapperFuncs *funcsObj);

struct SHDynamicArrayIterator *SH_dynamicArrayIterator_init(struct SHDynamicArray *array);
void *SH_dynamicArrayIterator_next(struct SHDynamicArrayIterator **iter);

#endif /* SHDynamicArray_h */
