//
//  SHTree.h
//  SHUtils_C
//
//  Created by Joel Pridgen on 6/6/20.
//  Copyright © 2020 Joel Gillette. All rights reserved.
//

#ifndef SHTree_h
#define SHTree_h

#include "SHErrorHandling.h"
#include "SHIterableWrapper.h"
#include <stdio.h>
#include <inttypes.h>

struct SHTree;

struct SHTreeIterator;

extern const struct SHIterableWrapperFuncs treeSetup;

struct SHTree *SH_tree_init(int32_t (*sortingFn)(void*, void*), void (*itemCleanup)(void*));
uint64_t SH_tree_count(struct SHTree *tree);
SHErrorCode SH_tree_addItem(struct SHTree *tree, void *item);
void *SH_tree_findNthItem(struct SHTree *tree, uint64_t idx);
void *SH_tree_getFront(struct SHTree *tree);
void *SH_tree_popFront(struct SHTree *tree);
void *SH_tree_getBack(struct SHTree *tree);
void *SH_tree_popBack(struct SHTree *tree);
SHErrorCode SH_tree_deleteNthItem(struct SHTree *tree, uint64_t idx);
void SH_tree_cleanup(struct SHTree *tree);
void SH_tree_cleanupIgnoreItems(struct SHTree *tree);

SHErrorCode SH_tree_setLineBreakSentinel(struct SHTree *tree, void * const sentinel);
void *SH_tree_getLineBreakSentinel(struct SHTree *tree);
SHErrorCode SH_tree_setNullItemSentinel(struct SHTree *tree, void * const sentinel);
void *SH_tree_getNullItemSentinel(struct SHTree *tree);

struct SHTreeIterator *SH_treeIterator_init(struct SHTree *tree);
void *SH_treeIterator_nextInorder(struct SHTreeIterator **iter);
void *SH_treeIterator_nextPostOrder(struct SHTreeIterator **iter);
void *SH_treeIterator_nextPreorder(struct SHTreeIterator **iter);
void *SH_treeIterator_nextLineOrder(struct SHTreeIterator **iter);

void SH_treeIterator_cleanup(struct SHTreeIterator *iter);


#endif /* SHTree_h */
