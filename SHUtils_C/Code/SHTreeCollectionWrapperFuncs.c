//
//  SHTreeCollectionWrapperFuncs.c
//  SHUtils_C
//
//  Created by Joel Pridgen on 6/20/20.
//  Copyright © 2020 Joel Gillette. All rights reserved.
//

#include "SHTreeCollectionWrapperFuncs.h"
#include "SHTree.h"
#include <stdlib.h>


uint64_t SH_treeCollection_count(struct SHCollection *collection) {
	struct SHTree *tree = (struct SHTree*)collection->backend;
	return SH_tree_count(tree);
}


void SH_treeCollection_addItem(struct SHCollection *collection, void *item) {
	struct SHTree *tree = (struct SHTree*)collection->backend;
	SH_tree_addItem(tree, item);
}


void *SH_treeCollection_getItemAtIdx(struct SHCollection *collection, uint64_t idx) {
	struct SHTree *tree = (struct SHTree*)collection->backend;
	return SH_tree_findNthItem(tree, idx);
}


void SH_treeCollection_deleteItemAtIdx(struct SHCollection *collection, uint64_t idx) {
	struct SHTree *tree = (struct SHTree*)collection->backend;
	SH_tree_deleteNthItem(tree, idx);
}


struct SHCollectionIterator *SH_treeCollectionIterator_init(struct SHCollection *collection) {
	struct SHTree *tree = (struct SHTree*)collection->backend;
	struct SHCollectionIterator *iter = malloc(sizeof(struct SHCollectionIterator));
	iter->backend = SH_treeIterator_init(tree);
	return iter;
}


void *SH_treeCollectionIterator_next(struct SHCollectionIterator **iter) {
	struct SHCollectionIterator *it = *iter;
	struct SHTreeIterator *treeIter = (struct SHTreeIterator *)it->backend;
	void *item = SH_treeIterator_nextInorder(&treeIter);
	if(!treeIter) {
		free(it);
		*iter = NULL;
	}
	return item;
}
