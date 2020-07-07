//
//  SHIterableWrapper.c
//  SHUtils_C
//
//  Created by Joel Pridgen on 6/20/20.
//  Copyright © 2020 Joel Gillette. All rights reserved.
//

#include "SHIterableWrapper.h"
#include "SHUtilConstants.h"
#include <stdlib.h>


struct SHIterableWrapper {
	struct SHIterableWrapperFuncs funcs;
	struct SHDynamicArray *backend;
	uint64_t defaultSubIterableIdx;
	void* (*initializer)(int32_t (*)(void*, void*), void (*)(void**));
	int32_t (*defaultSortingFn)(void *, void *);
	void (*subIterableCleanup)(void**);
	void (*defaultItemCleanup)(void**);
};



struct SHIterableWrapper *SH_iterable_init(void* (*initializer)(int32_t (*)(void*, void*), void (*)(void**)),
	void (*fnSetup)(struct SHIterableWrapperFuncs *),
	void (*subIterableCleanup)(void**),
	int32_t (*defaultSortingFn)(void *, void *),
	void (*defaultItemCleanup)(void**))
{
	struct SHIterableWrapper *iterable = malloc(sizeof(struct SHIterableWrapper));
	iterable->backend = SH_dynamicArray_init(subIterableCleanup);
	iterable->initializer = initializer;
	iterable->defaultSortingFn = defaultSortingFn;
	iterable->defaultItemCleanup = defaultItemCleanup;
	iterable->defaultSubIterableIdx = 0;
	fnSetup(&iterable->funcs);
	void * subIterable = initializer(defaultSortingFn, defaultItemCleanup);
	SH_dynamicArray_push(iterable->backend, subIterable);
	return iterable;
}


uint64_t SH_iterable_count(struct SHIterableWrapper *iterable) {
	if(!iterable || !iterable->funcs.count) return SH_NOT_FOUND;
	return iterable->funcs.count(SH_dynamicArray_get(iterable->backend, iterable->defaultSubIterableIdx));
}


void SH_iterable_addItem(struct SHIterableWrapper *iterable, void *item) {
	if(!iterable || !iterable->funcs.addItem) return;
	iterable->funcs.addItem(SH_dynamicArray_get(iterable->backend, iterable->defaultSubIterableIdx), item);
}


void *SH_iterable_getItemAtIdx(struct SHIterableWrapper *iterable, uint64_t idx) {
	if(!iterable || !iterable->funcs.getItemAtIdx) return NULL;
	return iterable->funcs.getItemAtIdx(SH_dynamicArray_get(iterable->backend, iterable->defaultSubIterableIdx), idx);
}


void *SH_iterable_getFront(struct SHIterableWrapper *iterable) {
	if(!iterable || !iterable->funcs.getFront) return NULL;
	return iterable->funcs.getFront(SH_dynamicArray_get(iterable->backend, iterable->defaultSubIterableIdx));
}


void *SH_iterable_popFront(struct SHIterableWrapper *iterable) {
	if(!iterable || !iterable->funcs.popFront) return NULL;
	return iterable->funcs.popFront(SH_dynamicArray_get(iterable->backend, iterable->defaultSubIterableIdx));
}


void *SH_iterable_getBack(struct SHIterableWrapper *iterable) {
	if(!iterable || !iterable->funcs.getBack) return NULL;
	return iterable->funcs.getBack(SH_dynamicArray_get(iterable->backend, iterable->defaultSubIterableIdx));
}


void *SH_iterable_popBack(struct SHIterableWrapper *iterable) {
	if(!iterable || !iterable->funcs.popBack) return NULL;
	return iterable->funcs.popBack(SH_dynamicArray_get(iterable->backend, iterable->defaultSubIterableIdx));
}


void SH_iterable_deleteItemAtIdx(struct SHIterableWrapper *iterable, uint64_t idx) {
	if(!iterable || !iterable->funcs.deleteItemAtIdx) return;
	iterable->funcs.deleteItemAtIdx(SH_dynamicArray_get(iterable->backend, iterable->defaultSubIterableIdx), idx);
}


struct SHIterableWrapperIterator *SH_iterableIterator_init(struct SHIterableWrapper *iterable) {
	if(!iterable || !iterable->funcs.iteratorInit) return NULL;
	struct SHIterableWrapperIterator* iter = malloc(sizeof(struct SHIterableWrapperIterator));
	iter->internalIter = iterable->funcs.iteratorInit(
		SH_dynamicArray_get(iterable->backend, iterable->defaultSubIterableIdx));
	return iter;
}


void *SH_iterableIterator_next(struct SHIterableWrapperIterator **iterP2) {
	if(!iterP2 || !*iterP2) return NULL;
	struct SHIterableWrapperIterator *it = *iterP2;
	if(!it->iterable || it->iterable->funcs.iteratorNext) return NULL;
	void* result = it->iterable->funcs.iteratorNext(&it->internalIter);
	if(!it->internalIter) {
		free(it);
		*iterP2 = NULL;
	}
	return result;
}


void SH_iterable_setInternalIterable(struct SHIterableWrapper *iterable, uint64_t idx) {
	if(!iterable) return;
	iterable->defaultSubIterableIdx = idx;
}


void SH_iterable_cleanup(struct SHIterableWrapper **iterableP2) {
	if(!iterableP2) return;
	struct SHIterableWrapper *iterable = *iterableP2;
	if(!iterable) return;
	SH_dynamicArray_free(&iterable->backend);
	free(iterable);
	*iterableP2 = NULL;
}


