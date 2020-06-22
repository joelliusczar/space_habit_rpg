//
//  SHCollection.c
//  SHUtils_C
//
//  Created by Joel Pridgen on 6/20/20.
//  Copyright © 2020 Joel Gillette. All rights reserved.
//

#include "SHCollection.h"
#include "SHTree.h"
#include "SHTreeCollectionWrapperFuncs.h"
#include "SHUtilConstants.h"
#include <stdlib.h>


struct SHCollection *SH_collection_initAsTree(int32_t (*sortingFn)(void*, void*), void (*itemCleanup)(void*)) {
	struct SHTree *tree = SH_tree_init(sortingFn, itemCleanup);
	struct SHCollection *collection = malloc(sizeof(struct SHCollection));
	collection->backend = tree;
	collection->count = SH_treeCollection_count;
	collection->addItem = SH_treeCollection_addItem;
	collection->getItemAtIdx = SH_treeCollection_getItemAtIdx;
	collection->deleteItemAtIdx = SH_treeCollection_deleteItemAtIdx;
	collection->iteratorInit = SH_treeCollectionIterator_init;
	collection->iteratorNext = SH_treeCollectionIterator_next;
	collection->backendCleanup = SH_tree_cleanup2;
	return collection;
}


uint64_t SH_collection_count(struct SHCollection *collection) {
	if(!collection || !collection->count) return SH_NOT_FOUND;
	return collection->count(collection);
}


void SH_collection_addItem(struct SHCollection *collection, void *item) {
	if(!collection || !collection->addItem) return;
	collection->addItem(collection, item);
}


void *SH_collection_getItemAtIdx(struct SHCollection *collection, uint64_t idx) {
	if(!collection || !collection->getItemAtIdx) return NULL;
	return collection->getItemAtIdx(collection, idx);
}


void SH_collection_deleteItemAtIdx(struct SHCollection *collection, uint64_t idx) {
	if(!collection || !collection->deleteItemAtIdx) return;
	collection->deleteItemAtIdx(collection, idx);
}


struct SHCollectionIterator *SH_collectionIterator_init(struct SHCollection *collection) {
	if(!collection || !collection->iteratorInit) return NULL;
	return collection->iteratorInit(collection);
}


void *SH_collectionIterator_next(struct SHCollectionIterator **iter) {
	if(!iter || !*iter) return NULL;
	struct SHCollectionIterator *it = *iter;
	if(!it->collection || it->collection->iteratorNext) return NULL;
	return it->collection->iteratorNext(iter);
}


void SH_collection_cleanup(struct SHCollection *collection) {
	if(!collection || !collection->backendCleanup) return;
	collection->backendCleanup(collection->backend);
	free(collection);
}


void SH_collection_cleanup2(void *args) {
	struct SHCollection *collection = (struct SHCollection *)args;
	SH_collection_cleanup(collection);
}
