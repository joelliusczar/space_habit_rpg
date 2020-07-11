//
//  SHIterableWrapper.h
//  SHUtils_C
//
//  Created by Joel Pridgen on 6/20/20.
//  Copyright © 2020 Joel Gillette. All rights reserved.
//

#ifndef SHIterableWrapper_h
#define SHIterableWrapper_h

#include "SHErrorHandling.h"
#include "SHDynamicArray.h"
#include <stdio.h>
#include <inttypes.h>

struct SHIterableWrapper;

struct SHIterableWrapperIterator {
	void *internalIter;
	struct SHIterableWrapper *iterable;
};

struct SHIterableWrapperFuncs {
	uint64_t (*count)(void *);
	void *(*getItemAtIdx)(void *, uint64_t);
	void *(*getFront)(void *);
	void *(*popFront)(void *);
	void *(*getBack)(void *);
	void *(*popBack)(void *);
	SHErrorCode (*addItem)(void *, void *);
	SHErrorCode (*deleteItemAtIdx)(void *, uint64_t);
	void *(*iteratorInit)(void *);
	void *(*iteratorNext)(void**);
	void (*itemCleanup)(void**);
};


struct SHIterableWrapper;

struct SHIterableWrapper *SH_iterable_init(void* (*initializer)(int32_t (*)(void*, void*), void (*)(void**)),
	SHErrorCode (*fnSetup)(struct SHIterableWrapperFuncs *),
	void (*subIterableCleanup)(void**),
	int32_t (*defaultSortingFn)(void *, void *),
	void (*defaultItemCleanup)(void**));
	
SHErrorCode SH_iterable_createSubIterable(struct SHIterableWrapper *iterable, int32_t (*sortingFn)(void *, void *),
	void (*itemCleanup)(void**));
SHErrorCode SH_iterable_setGroupingFn(struct SHIterableWrapper *iterable, uint64_t (*groupingFn)(void*));
uint64_t SH_iterable_count(struct SHIterableWrapper *iterable);
SHErrorCode SH_iterable_addItem(struct SHIterableWrapper *iterable, void *item);
void *SH_iterable_getItemAtIdx(struct SHIterableWrapper *iterable, uint64_t idx);
void *SH_iterable_getItemAtIdx2(struct SHIterableWrapper *iterable, uint64_t iterableIdx, uint64_t idx);
void *SH_iterable_getFront(struct SHIterableWrapper *iterable);
void *SH_iterable_popFront(struct SHIterableWrapper *iterable);
void *SH_iterable_getBack(struct SHIterableWrapper *iterable);
void *SH_iterable_popBack(struct SHIterableWrapper *iterable);
SHErrorCode SH_iterable_deleteItemAtIdx(struct SHIterableWrapper *iterable, uint64_t idx);
struct SHIterableWrapperIterator *SH_iterableIterator_init(struct SHIterableWrapper *iterable);
void *SH_iterableIterator_next(struct SHIterableWrapperIterator **iter);
SHErrorCode SH_iterable_setInternalIterable(struct SHIterableWrapper *iterable, uint64_t idx);

void SH_iterable_cleanup(struct SHIterableWrapper **iterable);

#endif /* SHIterableWrapper_h */
