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

struct SHTreeNode;

struct SHTreeNode {
	struct SHTreeNode *left;
	struct SHTreeNode *right;
	void *item;
	uint64_t childCount;
	int32_t height;
};

struct SHTreeIterator;

struct SHTree *SH_tree_init(int32_t (*sortingFn)(void*, void*), void (*itemCleanup)(void*));
uint64_t SH_tree_count(struct SHTree *tree);
void SH_tree_addItem(struct SHTree *tree, void *item);
void *SH_tree_findNthItem(struct SHTree *tree, uint64_t idx);
void SH_tree_deleteNthItem(struct SHTree *tree, uint64_t idx);
void SH_tree_inorderTraverse(struct SHTree *tree, void (*nodeOp)(struct SHTreeNode *, void *), void *fnArg);
void SH_tree_postorderTraverse(struct SHTree *tree, void (*nodeOp)(struct SHTreeNode *, void *), void *fnArg);
void SH_cleanupTree(struct SHTree *tree);

struct SHTreeIterator *SH_treeIterator_initInorder(struct SHTree *tree);
void *SH_treeIterator_nextInorder(struct SHTreeIterator **iter);

#endif /* SHTree_h */
