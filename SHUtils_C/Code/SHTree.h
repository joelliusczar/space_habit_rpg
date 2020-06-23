//
//  SHTree.h
//  SHUtils_C
//
//  Created by Joel Pridgen on 6/6/20.
//  Copyright © 2020 Joel Gillette. All rights reserved.
//

#ifndef SHTree_h
#define SHTree_h

#include <stdio.h>
#include <inttypes.h>

struct SHTree;

struct SHTreeIterator;

struct SHTree *SH_tree_init(int32_t (*sortingFn)(void*, void*), void (*itemCleanup)(void*));
uint64_t SH_tree_count(struct SHTree *tree);
void SH_tree_addItem(struct SHTree *tree, void *item);
void *SH_tree_findNthItem(struct SHTree *tree, uint64_t idx);
void SH_tree_deleteNthItem(struct SHTree *tree, uint64_t idx);
void SH_tree_cleanup(struct SHTree **tree);
void SH_tree_cleanup2(void **args);

void SH_tree_setLineBreakSentinel(struct SHTree *tree, void *sentinel);
void *SH_tree_getLineBreakSentinel(struct SHTree *tree);
void SH_tree_setNullItemSentinel(struct SHTree *tree, void *sentinel);
void *SH_tree_getNullItemSentinel(struct SHTree *tree);

struct SHTreeIterator *SH_treeIterator_init(struct SHTree *tree);
void *SH_treeIterator_nextInorder(struct SHTreeIterator **iter);
void *SH_treeIterator_skipInorder(struct SHTreeIterator **iter, uint64_t skip);
void *SH_treeIterator_nextPostOrder(struct SHTreeIterator **iter);
void *SH_treeIterator_skipPostOrder(struct SHTreeIterator **iter, uint64_t skip);
void *SH_treeIterator_nextPreorder(struct SHTreeIterator **iter);
void *SH_treeIterator_skipPreorder(struct SHTreeIterator **iter, uint64_t skip);
void *SH_treeIterator_nextLineOrder(struct SHTreeIterator **iter);
void *SH_treeIterator_skipLineOrder(struct SHTreeIterator **iter, uint64_t skip);

char * SH_tree_printLineOrder(struct SHTree *tree, char *(*itemDescFn)(void *));

#endif /* SHTree_h */
