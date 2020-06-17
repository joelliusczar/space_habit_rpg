//
//  SHTree.c
//  SHUtils_C
//
//  Created by Joel Pridgen on 6/6/20.
//  Copyright © 2020 Joel Gillette. All rights reserved.
//

#include "SHTree.h"
#include "SHUtilConstants.h"
#include "SHErrorHandling.h"
#include "SHGenAlgos.h"
#include "SHLinkedList.h"
#include <stdlib.h>
#include <stdbool.h>
#include <math.h>
#include <string.h>


typedef enum {
	_start = 0,
	_afterInit = 1,
	_afterYield = 2,
} _postOrderState;

struct SHTreeNode;

struct SHTreeNode {
	struct SHTreeNode *left;
	struct SHTreeNode *right;
	void *item;
	uint64_t childCount;
	int32_t height;
};

struct SHTree {
	struct SHTreeNode *root;
	int32_t (*sortingFn)(void*, void*);
	void (*itemCleanup)(void*);
	uintptr_t version;
};


struct SHTreeIterator {
	struct SHLinkedList *stack;
	struct SHTree *tree;
	struct SHTreeNode *current;
	struct SHTreeNode *postOrderCurrent;
	struct SHTreeNode *last; //for post order
	uintptr_t version;
	_postOrderState stateNum;
};


static struct SHTreeNode _lineBreakNode;


struct SHTree *SH_tree_init(int32_t (*sortingFn)(void*, void*), void (*itemCleanup)(void*)) {
	struct SHTree *tree = malloc(sizeof(struct SHTree));
	tree->sortingFn = sortingFn;
	tree->itemCleanup = itemCleanup;
	tree->version = 0;
	
	return tree;
}


uint64_t SH_tree_count(struct SHTree *tree) {
	if(NULL == tree) return SH_NOT_FOUND;
	return tree->root ? tree->root->childCount + 1 : 0;
}


static void _updateChildCount(struct SHTreeNode *root) {
	if(!root) return;
	root->childCount = 0;
	if(root->left) {
		root->childCount += root->left->childCount + 1;
	}
	if(root->right) {
		root->childCount += root->right->childCount + 1;
	}
}


static int32_t _getHeight(struct SHTreeNode *root) {
	if(!root) return 0;
	return root->height;
}


static void _updateHeight(struct SHTreeNode *root) {
	root->height = fmax(_getHeight(root->left), _getHeight(root->right)) + 1;
}


static int32_t _getBalance(struct SHTreeNode *root) {
	if(!root) return 0;
	return fmax(_getHeight(root->left), _getHeight(root->right)) + 1;
}


static struct SHTreeNode *_rotateLeft(struct SHTreeNode *root) {
	struct SHTreeNode *newRoot = root->right;
	root->right = newRoot->left;
	newRoot->left = root;
	
	_updateHeight(newRoot);
	_updateHeight(root);
	
	return newRoot;
}


static struct SHTreeNode *_rotateRight(struct SHTreeNode *root){
	struct SHTreeNode *newRoot = root->left;
	root->left = newRoot->right;
	newRoot->right = root;
	
	_updateHeight(newRoot);
	_updateHeight(root);
	
	return newRoot;
}


static bool _isLeftHeavy(struct SHTreeNode *root) {
	return _getBalance(root) > 0;
}


static bool _isRightHeavy(struct SHTreeNode *root) {
	return _getBalance(root) < 0;
}


static struct SHTreeNode *_rebalance(struct SHTreeNode *root) {
	if(_isRightHeavy(root)) {
		if(_isLeftHeavy(root->right)) {
			root->right = _rotateRight(root->right);
			return _rotateLeft(root);
		}
		return _rotateLeft(root);
	}
	else if(_isLeftHeavy(root)) {
		if(_isRightHeavy(root->left)) {
			root->left = _rotateLeft(root->left);
			return _rotateRight(root);
		}
		return _rotateRight(root);
	}
	return root;
}


static struct SHTreeNode * _nodeInit(void *item) {
	struct SHTreeNode *node = malloc(sizeof(struct SHTreeNode));
	node->item = item;
	node->height = 1;
	node->childCount = 0;
	return node;
}


static struct SHTreeNode *_addItem(struct SHTreeNode *root, void *item,
	int32_t (*sortingFn)(void*, void*))
{
	if(!root) {
		return _nodeInit(item);
	}
	int32_t compareResult = sortingFn(root->item, item);
	if(compareResult < 0) {
		root->left = _addItem(root->left, item, sortingFn);
	}
	else if(compareResult > 0) {
		//right
		root->right = _addItem(root->right, item, sortingFn);
	}
	else {
		return root;
	}
	root = _rebalance(root);
	_updateChildCount(root);
	return root;
	
}


void SH_tree_addItem(struct SHTree *tree, void *item) {
	if(!tree) return;
	uint64_t beforeCount = SH_tree_count(tree);
	tree->root = _addItem(tree->root, item, tree->sortingFn);
	if(SH_tree_count(tree) > beforeCount) { //if item was added
		tree->version ^= (uintptr_t)item;
	}
}


static struct SHTreeNode *_findNthItem(struct SHTreeNode *root, uint64_t idx, uint64_t leftCount)
{
	uint64_t localLeftCount = root->left ? root->left->childCount : 0;
	uint64_t totalLeftCount = localLeftCount + leftCount;
	if(totalLeftCount > idx) {
		struct SHTreeNode *node = _findNthItem(root->left, idx, leftCount);
		return node;
	}
	if(totalLeftCount == idx) {
		return root;
	}
	if(root->right) {
		struct SHTreeNode *node = _findNthItem(root->right, idx, totalLeftCount + 1);
		return node;
	}
	return NULL;
}


void *SH_tree_findNthItem(struct SHTree *tree, uint64_t idx) {
	if(!tree || !tree->root) return NULL;
	if(idx > tree->root->childCount) return NULL;
	struct SHTreeNode *nthNode = _findNthItem(tree->root, idx, 0);
	return nthNode ? nthNode->item : NULL;
}


static struct SHTreeNode * _getMaxNode(struct SHTreeNode *root) {
	if(!root) return NULL;
	if(!root->right) return root;
	struct SHTreeNode *node = root->right;
	while(node) {
		node = node->right;
	}
	return node;
}


static struct SHTreeNode *_getParent(struct SHTreeNode *root, struct SHTreeNode *child,
	int32_t (*sortingFn)(void*, void*))
{
	if(!root) return NULL;
	if(root->left == child || root->right == child) return root;
	int32_t compareResult = sortingFn(root->item, child->item);
	if(compareResult < 0) {
		return _getParent(root->left, child, sortingFn);
	}
	else if(compareResult > 0) {
		return _getParent(root->right, child, sortingFn);
	}
	else {
		return NULL;
	}
}

static void _nodeCleanup(struct SHTreeNode *root, void (*itemCleanup)(void*)) {
	if(!root) return;
	if(itemCleanup) {
		itemCleanup(root->item);
	}
	free(root);
}


static void _iteratorCleanup(struct SHTreeIterator *iter) {
	if(!iter) return;
	free(iter->stack);
	free(iter);
}


static struct SHTreeNode *_deleteNode(struct SHTreeNode *root,struct SHTreeNode *deleted,
	int32_t (*sortingFn)(void*, void*))
{
	if(!root) return NULL;
	struct SHTreeNode *replacement = root;
	int32_t compareResult = sortingFn(root->item, deleted->item);
	if(compareResult < 0){
		root->left = _deleteNode(root->left, deleted, sortingFn);
	}
	else if(compareResult > 0) {
		root->right = _deleteNode(root->right, deleted, sortingFn);
	}
	else {
		if(!root->left) {
			replacement = root->right;
		}
		else if(!root->right) {
			replacement = root->left;
		}
		else {
			replacement = _getMaxNode(root->left);
			struct SHTreeNode *parent = _getParent(root, replacement, sortingFn);
			parent->right = NULL;
			replacement->left = root->left;
			replacement->right = root->right;
		}
	}
	
	if(!replacement) return NULL;
	_updateHeight(replacement);
	_rebalance(replacement);
	_updateChildCount(replacement);
	
	return replacement;
}



void SH_tree_deleteNthItem(struct SHTree *tree, uint64_t idx) {
	if(!tree || !tree->root) return;
	uint64_t beforeCount = SH_tree_count(tree);
	struct SHTreeNode *nthNode = _findNthItem(tree->root, idx, 0);
	_deleteNode(tree->root, nthNode, tree->sortingFn);
	if(SH_tree_count(tree) > beforeCount) { //if item was successfully removed
		tree->version ^= (uintptr_t)nthNode->item;
	}
	_nodeCleanup(nthNode, tree->itemCleanup);
}


static void _resizeIteratorStack(struct SHTreeIterator *iter) {
	struct SHTreeNode **newStack = malloc(sizeof(void *) * (iter->stackSize * 2));
	memcpy(newStack, iter->stack,sizeof(void*) * iter->stackSize);
	free(iter->stack);
	iter->stack = newStack;
	iter->stackSize *= 2;
}


static struct SHTreeNode *_nextPostOrder(struct SHTreeIterator *it) {
	switch(it->stateNum) {
		case _afterInit: goto afterInit;
		case _afterYield: goto afterYield;
		default:;
	}
	it->postOrderCurrent = it->current;
	it->last = NULL;
	struct SHTreeNode *result = NULL;
	afterInit:
	loopStart:
	if(!it->postOrderCurrent || it->stackIdx < 1) {
		goto fnExit;
	}
		if(!it->current) { goto elseBlock1; }
			if(it->stackIdx >= it->stackSize) {
				_resizeIteratorStack(it);
			}
			it->stack[it->stackIdx++] = it->current;
			it->current = it->current->left;
			goto loopStart;
		
		elseBlock1:
			if(!it->stack[it->stackIdx]->right || it->stack[it->stackIdx]->right == it->last) {
				goto elseBlock2;
			}
				it->postOrderCurrent = it->stack[it->stackIdx]->right;
			elseBlock2:
				result = it->stack[it->stackIdx];
				return result;
				afterYield:
					it->last = it->stack[it->stackIdx];
					it->stackIdx--;
			goto loopStart;
	fnExit:
	return NULL;
}


void *SH_treeIterator_nextPostOrder(struct SHTreeIterator **iter) {
	if(!iter || !(*iter)) return NULL;
	if((*iter)->version != (*iter)->tree->version) {
		SH_notifyOfError(SH_ILLEGAL_STATE_CHANGED, "The tree has change in the middle of traversal");
		return NULL;
	}
	struct SHTreeNode *next = _nextPostOrder(*iter);
	if(!next) {
		_iteratorCleanup(*iter);
		*iter = NULL;
	}
	return next;
}


static struct SHTreeNode *_nextInorder(struct SHTreeIterator *it) {
	while(it->current && it->stackIdx > 0) {
		if(it->current) {
			if(it->stackIdx >= it->stackSize) {
				_resizeIteratorStack(it);
			}
			it->stack[it->stackIdx++] = it->current;
			it->current = it->current->left;
		}
		else {
			struct SHTreeNode *node = it->stack[it->stackIdx--];
			struct SHTreeNode *result = node;
			it->current = node->right;
			return result;
		}
	}
	return NULL;
}


void *SH_treeIterator_nextInorder(struct SHTreeIterator **iter) {
	if(!iter || !(*iter)) return NULL;
	if((*iter)->version != (*iter)->tree->version) {
		SH_notifyOfError(SH_ILLEGAL_STATE_CHANGED, "The tree has change in the middle of traversal");
		return NULL;
	}
	struct SHTreeNode *next = _nextInorder(*iter);
	if(!next) {
		_iteratorCleanup(*iter);
		*iter = NULL;
	}
	return next;
}


static struct SHTreeNode *_nextLineOrder(struct SHTreeIterator *it, void *lineBreakElement) {
	if(it->stackIdx >= it->stackSize) {
		_resizeIteratorStack(it);
	}
	
	
}


void *SH_treeIterator_nextLineOrder(struct SHTreeIterator **iter, void *lineBreakElement) {
	if(!iter || !(*iter)) return NULL;
	if((*iter)->version != (*iter)->tree->version) {
		SH_notifyOfError(SH_ILLEGAL_STATE_CHANGED, "The tree has change in the middle of traversal");
		return NULL;
	}
	struct SHTreeNode *next = _nextLineOrder(*iter);
	if(!next) {
		free((*iter)->stack);
		free((*iter));
	}
	return next;
}


struct SHTreeIterator *SH_treeIterator_init(struct SHTree *tree) {
	if(!tree) return NULL;
	struct SHTreeIterator *iter = malloc(sizeof(struct SHTreeIterator));
	iter->current = tree->root;
	iter->stackSize = SH_highestBit(SH_tree_count(tree));
	iter->stack = malloc(sizeof(void*) * (iter->stackSize + 1) * 2);
	iter->stackIdx = 0;
	iter->version = tree->version;
	iter->postOrderCurrent = NULL;
	iter->last = NULL;
	iter->stateNum = _start;
	return iter;
}



void SH_cleanupTree(struct SHTree *tree) {
	if(!tree) return;
	struct SHTreeIterator *iter = SH_treeIterator_init(tree);
	struct SHTreeNode *node = NULL;
	struct SHTreeNode *prev = NULL;
	while((node = _nextPostOrder(iter))) {
		_nodeCleanup(prev, tree->itemCleanup);
		prev = node;
	}
	_nodeCleanup(prev, tree->itemCleanup);
	_iteratorCleanup(iter);
	free(tree);
}


