//
//  SHIterableWrapper.c
//  SHUtils_C
//
//  Created by Joel Pridgen on 6/20/20.
//  Copyright © 2020 Joel Gillette. All rights reserved.
//

#include "SHIterableWrapper.h"
#include "SHUtilConstants.h"
#include "SHErrorHandling.h"
#include <stdlib.h>


struct SHIterableWrapper {
	struct SHIterableWrapperFuncs funcs;
	void *backend;
};



struct SHIterableWrapper *SH_iterable_init(struct SHIterableSetup const * const setup,
	int32_t (*sortingFn)(void *, void *), void (*itemCleanup)(void**))
{
	if(!setup) return NULL;
	
	struct SHIterableWrapper *iterable = malloc(sizeof(struct SHIterableWrapper));
	if(!iterable) {
		goto allocErr;
	}
	iterable->backend = setup->initializer(sortingFn, itemCleanup);;
	if(!iterable->backend) goto cleanup;
	setup->fnSetup(&iterable->funcs);
	return iterable;
	cleanup:
		SH_iterable_cleanup(&iterable);
	allocErr:
		SH_notifyOfError(SH_ALLOC_NO_MEM, "Failed to allocate memory to create iterable");
		return NULL;
}



uint64_t SH_iterable_count(struct SHIterableWrapper *iterable) {
	if(!iterable || !iterable->funcs.count) return SH_NOT_FOUND;
	return iterable->funcs.count(iterable->backend);
}


SHErrorCode SH_iterable_addItem(struct SHIterableWrapper *iterable, void *item) {
	if(!iterable || !iterable->funcs.addItem) return SH_ILLEGAL_INPUTS;
	return iterable->funcs.addItem(iterable->backend, item);
}


void *SH_iterable_getItemAtIdx(struct SHIterableWrapper *iterable, uint64_t idx) {
	if(!iterable || !iterable->funcs.getItemAtIdx) return NULL;
	return iterable->funcs.getItemAtIdx(iterable->backend, idx);
}


void *SH_iterable_getFront(struct SHIterableWrapper *iterable) {
	if(!iterable || !iterable->funcs.getFront) return NULL;
	return iterable->funcs.getFront(iterable->backend);
}


void *SH_iterable_popFront(struct SHIterableWrapper *iterable) {
	if(!iterable || !iterable->funcs.popFront) return NULL;
	return iterable->funcs.popFront(iterable->backend);
}


void *SH_iterable_getBack(struct SHIterableWrapper *iterable) {
	if(!iterable || !iterable->funcs.getBack) return NULL;
	return iterable->funcs.getBack(iterable->backend);
}


void *SH_iterable_popBack(struct SHIterableWrapper *iterable) {
	if(!iterable || !iterable->funcs.popBack) return NULL;
	return iterable->funcs.popBack(iterable->backend);
}


SHErrorCode SH_iterable_deleteItemAtIdx(struct SHIterableWrapper *iterable, uint64_t idx) {
	if(!iterable || !iterable->funcs.deleteItemAtIdx) return SH_ILLEGAL_INPUTS;
	return iterable->funcs.deleteItemAtIdx(iterable->backend, idx);
}


struct SHIterableWrapperIterator *SH_iterableIterator_init(struct SHIterableWrapper *iterable) {
	if(!iterable || !iterable->funcs.iteratorInit) return NULL;
	struct SHIterableWrapperIterator* iter;
	if(!(iter = malloc(sizeof(struct SHIterableWrapperIterator)))) {
		goto allocErr;
	}
	iter->internalIter = iterable->funcs.iteratorInit(iterable->backend);
	return iter;
	allocErr:
		
		return NULL;
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


static void _cleanupIterable(struct SHIterableWrapper *iterable, void (*backendCleanup)(void**)) {
	if(backendCleanup) {
		backendCleanup(&iterable->backend);
	}
	free(iterable);
}


void SH_iterable_cleanup(struct SHIterableWrapper **iterableP2) {
	if(!iterableP2) return;
	struct SHIterableWrapper *iterable = *iterableP2;
	if(!iterable) return;
	_cleanupIterable(iterable, iterable->funcs.cleanup);
	*iterableP2 = NULL;
}


void SH_iterable_cleanupIgnoreItems(struct SHIterableWrapper **iterableP2) {
	if(!iterableP2) return;
	struct SHIterableWrapper *iterable = *iterableP2;
	if(!iterable) return;
	_cleanupIterable(iterable, iterable->funcs.cleanupIgnoreItems);
	*iterableP2 = NULL;
}


