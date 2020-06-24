//
//  SHIterableWrapper.c
//  SHUtils_C
//
//  Created by Joel Pridgen on 6/20/20.
//  Copyright © 2020 Joel Gillette. All rights reserved.
//

#include "SHIterableWrapper.h"
#include "SHTree.h"
#include "SHLinkedList.h"
#include "SHUtilConstants.h"
#include <stdlib.h>


struct SHIterableWrapper *SH_iterable_initAsTree(int32_t (*sortingFn)(void*, void*), void (*itemCleanup)(void**)) {
	struct SHTree *tree = SH_tree_init(sortingFn, itemCleanup);
	struct SHIterableWrapper *iterable = malloc(sizeof(struct SHIterableWrapper));
	iterable->backend = tree;
	iterable->count = (uint64_t (*)(void*))SH_tree_count;
	iterable->addItem = (void (*)(void*, void*))SH_tree_addItem;
	iterable->getItemAtIdx = (void *(*)(void*, uint64_t))SH_tree_findNthItem;
	iterable->getFront = (void* (*)(void*))SH_tree_getFront;
	iterable->popFront = (void* (*)(void*))SH_tree_popFront;
	iterable->getBack = (void* (*)(void*))SH_tree_getBack;
	iterable->popBack = (void* (*)(void*))SH_tree_popBack;
	iterable->deleteItemAtIdx = (void (*)(void*, uint64_t))SH_tree_deleteNthItem;
	iterable->iteratorInit = (void* (*)(void*))SH_treeIterator_init;
	iterable->iteratorNext = (void* (*)(void**))SH_treeIterator_nextInorder;
	iterable->backendCleanup = (void (*)(void**))SH_tree_cleanup;
	return iterable;
}


struct SHIterableWrapper *SH_iterable_initAsLinkedList(void (*itemCleanup)(void**)) {
	struct SHLinkedList *list = SH_list_init(itemCleanup);
	struct SHIterableWrapper *iterable = malloc(sizeof(struct SHIterableWrapper));
	iterable->backend = list;
	iterable->count = (uint64_t (*)(void*))SH_list_count;
	iterable->addItem = (void (*)(void*, void*))SH_list_pushBack;
	iterable->getItemAtIdx = (void *(*)(void*, uint64_t))SH_list_findNthItem;
	iterable->getFront = (void* (*)(void*))SH_list_getFront;
	iterable->popFront = (void* (*)(void*))SH_list_popFront;
	iterable->getBack = (void* (*)(void*))SH_list_getBack;
	iterable->popBack = (void* (*)(void*))SH_list_popBack;
	iterable->deleteItemAtIdx = (void (*)(void*, uint64_t))SH_list_deleteNthItem;
	iterable->iteratorInit = (void* (*)(void*))SH_listIterator_init;
	iterable->iteratorNext = (void* (*)(void**))SH_listIterator_next;
	iterable->backendCleanup = (void (*)(void**))SH_list_cleanup;
	return iterable;
}


uint64_t SH_iterable_count(struct SHIterableWrapper *iterable) {
	if(!iterable || !iterable->count) return SH_NOT_FOUND;
	return iterable->count(iterable->backend);
}


void SH_iterable_addItem(struct SHIterableWrapper *iterable, void *item) {
	if(!iterable || !iterable->addItem) return;
	iterable->addItem(iterable->backend, item);
}


void *SH_iterable_getItemAtIdx(struct SHIterableWrapper *iterable, uint64_t idx) {
	if(!iterable || !iterable->getItemAtIdx) return NULL;
	return iterable->getItemAtIdx(iterable->backend, idx);
}


void *SH_iterable_getFront(struct SHIterableWrapper *iterable) {
	if(!iterable || !iterable->getFront) return NULL;
	return iterable->getFront(iterable->backend);
}


void *SH_iterable_popFront(struct SHIterableWrapper *iterable) {
	if(!iterable || !iterable->popFront) return NULL;
	return iterable->popFront(iterable->backend);
}


void *SH_iterable_getBack(struct SHIterableWrapper *iterable) {
	if(!iterable || !iterable->getBack) return NULL;
	return iterable->getBack(iterable->backend);
}


void *SH_iterable_popBack(struct SHIterableWrapper *iterable) {
	if(!iterable || !iterable->popBack) return NULL;
	return iterable->popBack(iterable->backend);
}




void SH_iterable_deleteItemAtIdx(struct SHIterableWrapper *iterable, uint64_t idx) {
	if(!iterable || !iterable->deleteItemAtIdx) return;
	iterable->deleteItemAtIdx(iterable->backend, idx);
}


struct SHIterableWrapperIterator *SH_iterableIterator_init(struct SHIterableWrapper *iterable) {
	if(!iterable || !iterable->iteratorInit) return NULL;
	struct SHIterableWrapperIterator* iter = malloc(sizeof(struct SHIterableWrapperIterator));
	iter->internalIter = iterable->iteratorInit(iterable);
	return iter;
}


void *SH_iterableIterator_next(struct SHIterableWrapperIterator **iterP2) {
	if(!iterP2 || !*iterP2) return NULL;
	struct SHIterableWrapperIterator *it = *iterP2;
	if(!it->iterable || it->iterable->iteratorNext) return NULL;
	void* result = it->iterable->iteratorNext(&it->internalIter);
	if(!it->internalIter) {
		free(it);
		*iterP2 = NULL;
	}
	return result;
}


void SH_iterable_cleanup(struct SHIterableWrapper **iterableP2) {
	if(!iterableP2) return;
	struct SHIterableWrapper *iterable = *iterableP2;
	if(!iterable) return;
	if(iterable->backendCleanup) {
		iterable->backendCleanup(iterable->backend);
	}
	free(iterable);
	*iterableP2 = NULL;
}

