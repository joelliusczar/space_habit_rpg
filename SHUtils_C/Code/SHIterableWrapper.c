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



struct SHIterableWrapper *SH_iterable_init(struct SHIterableWrapperFuncs const * const setup,
	int32_t (*sortingFn)(void *, void *), void (*itemCleanup)(void*))
{
	if(!setup) return NULL;
	
	struct SHIterableWrapper *iterable = malloc(sizeof(struct SHIterableWrapper));
	if(!iterable) {
		goto allocErr;
	}
	iterable->funcs = *setup;
	iterable->backend = setup->initializer(sortingFn, itemCleanup);
	if(!iterable->backend) goto cleanup;
	return iterable;
	cleanup:
		SH_iterable_cleanup(iterable);
	allocErr:
		SH_notifyOfError(SH_ALLOC_NO_MEM, "Failed to allocate memory to create iterable");
		return NULL;
}



uint64_t SH_iterable_count(struct SHIterableWrapper *iterable) {
	if(!iterable || !iterable->funcs.count) return 0;
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


SHErrorCode SH_iterable_removeMatchingItem(struct SHIterableWrapper *iterable, void *item, bool removeAll) {
	if(!iterable || !iterable->funcs.removeMatchingItem) return SH_ILLEGAL_INPUTS;
	return iterable->funcs.removeMatchingItem(iterable->backend, item, removeAll);
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
	if(!iterP2) return NULL;
	struct SHIterableWrapperIterator *it = *iterP2;
	if(!it) return NULL;
	if(!it->iterable || !it->iterable->funcs.iteratorNext) return NULL;
	void* result = it->iterable->funcs.iteratorNext(&it->internalIter);
	if(!it->internalIter) {
		free(it);
		*iterP2 = NULL;
	}
	return result;
}


void SH_iterableIterator_cleanup(struct SHIterableWrapperIterator *iter) {
	if(!iter || !iter->iterable || !iter->iterable->funcs.iteratorCleanup) return;
	iter->iterable->funcs.iteratorCleanup(iter->internalIter);
	free(iter);
}


static void _cleanupIterable(struct SHIterableWrapper *iterable, void (*backendCleanup)(void*)) {
	if(backendCleanup) {
		backendCleanup(iterable->backend);
	}
	free(iterable);
}


void SH_iterable_cleanup(struct SHIterableWrapper *iterable) {
	if(!iterable) return;
	_cleanupIterable(iterable, iterable->funcs.cleanup);
}


void SH_iterable_cleanupIgnoreItems(struct SHIterableWrapper *iterable) {
	if(!iterable) return;
	_cleanupIterable(iterable, iterable->funcs.cleanupIgnoreItems);
}


char *SH_iterable_makeString(struct SHIterableWrapper *iterable, uint64_t *len,
	char *(*itemDescFn)(void*, uint64_t *len))
{
	if(!iterable || !itemDescFn) return NULL;
		char *itemDesc = NULL;
	void *item = NULL;
	uint64_t itemStrLen = 0;
	uint64_t currentMaxLen = (SH_MAX_INT64_LEN * SH_iterable_count(iterable));
	char *result = NULL;
	char *cat = NULL;
	char *tmp = NULL;
	struct SHIterableWrapperIterator *iter = SH_iterableIterator_init(iterable);
	if(!iter) return NULL;
	result = malloc(sizeof(char) * (currentMaxLen + SH_NULL_CHAR_OFFSET));
	if(!result) goto cleanup;
	*len = 0;
	*result = '\0';
	cat = result;
	
	do {
		item = SH_iterableIterator_next(&iter);
		itemDesc = itemDescFn(item, &itemStrLen);
		if(!itemDesc) goto reallocErr;
	
		if((*len + itemStrLen) >= currentMaxLen) {
			currentMaxLen *= 2;
			tmp = realloc(result, currentMaxLen);
			if(!tmp) {
				if(currentMaxLen > 0) goto reallocErr;
				goto cleanup;
			}
			result = tmp;
			cat = result + (*len) -1;
		}
		*len += itemStrLen;
		strncat(cat, itemDesc, itemStrLen);
		free(itemDesc);
	} while(iter);
	
	return result;
	reallocErr:
		free(result);
	cleanup:
		free(itemDesc);
		SH_iterableIterator_cleanup(iter);
		return NULL;

}
