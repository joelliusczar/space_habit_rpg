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
	_afterLineBreak = 3,
	_loopStart = 4,
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
	void *lineBreakSentinel;
	void *nullItemSentinel;
	uintptr_t version;
};


struct SHTreeIterator {
	struct SHLinkedList *stack;
	struct SHLinkedList *backupStack;
	struct SHTree *tree;
	struct SHTreeNode *current;
	struct SHTreeNode *postOrderCurrent;
	struct SHTreeNode *last; //for post order
	uintptr_t version;
	_postOrderState stateNum;
};


static struct SHTreeNode _lineBreakNode;
static struct SHTreeNode _nullNode;


struct SHTree *SH_tree_init(int32_t (*sortingFn)(void*, void*), void (*itemCleanup)(void*)) {
	struct SHTree *tree = malloc(sizeof(struct SHTree));
	tree->root = NULL;
	tree->sortingFn = sortingFn;
	tree->itemCleanup = itemCleanup;
	tree->version = 0;
	tree->lineBreakSentinel = NULL;
	tree->nullItemSentinel = NULL;
	
	return tree;
}


void SH_tree_setLineBreakSentinel(struct SHTree *tree, void *sentinel) {
	if(!tree) return;
	tree->lineBreakSentinel = sentinel;
}


void *SH_tree_getLineBreakSentinel(struct SHTree *tree) {
	if(!tree) return NULL;
	return tree->lineBreakSentinel;
}


void SH_tree_setNullItemSentinel(struct SHTree *tree, void *sentinel) {
	if(!tree) return;
	tree->nullItemSentinel = sentinel;
}


void *SH_tree_getNullItemSentinel(struct SHTree *tree) {
	if(!tree) return NULL;
	return tree->nullItemSentinel;
}


uint64_t SH_tree_count(struct SHTree *tree) {
	if(!tree) return SH_NOT_FOUND;
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

static void _updateNodeTotals(struct SHTreeNode *root) {
	_updateHeight(root);
	_updateChildCount(root);
}


static int32_t _getBalance(struct SHTreeNode *root) {
	if(!root) return 0;
	return _getHeight(root->left) - _getHeight(root->right);
}


static struct SHTreeNode *_rotateLeft(struct SHTreeNode *oldRoot) {
	struct SHTreeNode *newRoot = oldRoot->right;
	oldRoot->right = newRoot->left;
	newRoot->left = oldRoot;
	
	_updateNodeTotals(oldRoot);
	_updateNodeTotals(newRoot);
	
	return newRoot;
}


static struct SHTreeNode *_rotateRight(struct SHTreeNode *oldRoot){
	struct SHTreeNode *newRoot = oldRoot->left;
	oldRoot->left = newRoot->right;
	newRoot->right = oldRoot;
	
	_updateNodeTotals(oldRoot);
	_updateNodeTotals(newRoot);
	
	return newRoot;
}


static struct SHTreeNode *_rebalance(struct SHTreeNode *root) {
	_updateHeight(root);
	if(_getBalance(root) < -1) {
		if(_getHeight(root->right->left) > _getHeight(root->right->right)) {
			root->right = _rotateRight(root->right);
		}
		return _rotateLeft(root);
	}
	else if(_getBalance(root) > 1) {
		if(_getHeight(root->left->right) > _getHeight(root->left->left)) {
			root->left = _rotateLeft(root->left);
		}
		return _rotateRight(root);
	}
	return root;
}


static struct SHTreeNode * _nodeInit(void *item) {
	struct SHTreeNode *node = malloc(sizeof(struct SHTreeNode));
	node->item = item;
	node->left = NULL;
	node->right = NULL;
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
	if(!tree || !item) return;
	uint64_t beforeCount = SH_tree_count(tree);
	struct SHTreeNode *newRoot = _addItem(tree->root, item, tree->sortingFn);
	tree->root = newRoot;
	if(SH_tree_count(tree) > beforeCount) { //if item was added
		tree->version ^= (uintptr_t)item;
	}
}


static struct SHTreeNode *_findNthItem(struct SHTreeNode *root, uint64_t idx, uint64_t leftCount)
{
	uint64_t localLeftCount = root->left ? root->left->childCount + 1: 0;
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
	struct SHTreeNode *prev = node;
	while(node) {
		prev = node;
		node = node->right;
	}
	return prev;
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
	SH_list_cleanup(&iter->stack);
	SH_list_cleanup(&iter->backupStack);
	free(iter);
}


static struct SHTreeNode *_detachNode(struct SHTreeNode *root,struct SHTreeNode *detached,
	int32_t (*sortingFn)(void*, void*))
{
	if(!root) return NULL;
	struct SHTreeNode *newRoot = root;
	int32_t compareResult = sortingFn(root->item, detached->item);
	if(compareResult < 0){
		root->left = _detachNode(root->left, detached, sortingFn);
	}
	else if(compareResult > 0) {
		root->right = _detachNode(root->right, detached, sortingFn);
	}
	else {
		if(!root->left) {
			newRoot = root->right;
		}
		else if(!root->right) {
			newRoot = root->left;
		}
		else {
			newRoot = _getMaxNode(root->left);
			newRoot->left = _detachNode(root->left, newRoot, sortingFn);
			newRoot->right = root->right;
		}
	}
	
	if(!newRoot) return NULL;
	newRoot = _rebalance(newRoot);
	_updateChildCount(newRoot);
	
	return newRoot;
}



void SH_tree_deleteNthItem(struct SHTree *tree, uint64_t idx) {
	if(!tree || !tree->root) return;
	uint64_t beforeCount = SH_tree_count(tree);
	struct SHTreeNode *nthNode = _findNthItem(tree->root, idx, 0);
	tree->root = _detachNode(tree->root, nthNode, tree->sortingFn);
	if(SH_tree_count(tree) > beforeCount) { //if item was successfully removed
		tree->version ^= (uintptr_t)nthNode->item;
	}
	_nodeCleanup(nthNode, tree->itemCleanup);
}


static void *_next(struct SHTreeIterator **iter, uint64_t skip,
	struct SHTreeNode *(*iterPathFn)(struct SHTreeIterator *iter))
{
	if(!iter || !(*iter)) return NULL;
	if((*iter)->version != (*iter)->tree->version) {
		SH_notifyOfError(SH_ILLEGAL_STATE_CHANGED, "The tree has change in the middle of traversal");
		return NULL;
	}
	for(uint64_t i = 0; i < skip; i++) {
		struct SHTreeNode *next = iterPathFn(*iter);
		if(!next) {
			_iteratorCleanup(*iter);
			*iter = NULL;
			return NULL;
		}
	}
	struct SHTreeNode *next = iterPathFn(*iter);
	if(!next) {
		_iteratorCleanup(*iter);
		*iter = NULL;
		return NULL;
	}
	return next->item;
}


static struct SHTreeNode *_nextPostOrder(struct SHTreeIterator *it) {
	struct SHTreeNode *top = NULL;
	struct SHTreeNode *result = NULL;
	switch(it->stateNum) {
		case _afterInit: goto afterInit;
		case _afterYield: goto afterYield;
		default:;
	}
	it->postOrderCurrent = it->current;
	it->last = NULL;
	it->stateNum = _afterYield;
	afterInit:
	while(it->postOrderCurrent || SH_list_count(it->stack) > 0) {
		if(it->postOrderCurrent) {
			SH_list_pushBack(it->stack, it->postOrderCurrent);
			it->postOrderCurrent = it->postOrderCurrent->left;
		}
		else {
			top = SH_list_getBack(it->stack);
			if(top->right && top->right != it->last) {
				it->postOrderCurrent = top->right;
			}
			else {
				result = top;
				it->stateNum = _afterYield;
				return result;
				afterYield:
					it->stateNum = _afterInit;
					it->last = SH_list_popBack(it->stack);
				
			}
		}
	}
	return NULL;
}


void *SH_treeIterator_skipPostOrder(struct SHTreeIterator **iter, uint64_t skip) {
	return _next(iter, skip, _nextPostOrder);
}


void *SH_treeIterator_nextPostOrder(struct SHTreeIterator **iter) {
	return SH_treeIterator_skipPostOrder(iter, 0);
}


static struct SHTreeNode *_nextInorder(struct SHTreeIterator *it) {
	while(it->current || SH_list_count(it->stack) > 0) {
		if(it->current) {
			SH_list_pushBack(it->stack, it->current);
			it->current = it->current->left;
		}
		else {
			struct SHTreeNode *node = SH_list_popBack(it->stack);
			struct SHTreeNode *result = node;
			it->current = node->right;
			return result;
		}
	}
	return NULL;
}


void *SH_treeIterator_skipInorder(struct SHTreeIterator **iter, uint64_t skip) {
	return _next(iter, skip, _nextInorder);
}


void *SH_treeIterator_nextInorder(struct SHTreeIterator **iter) {
	return SH_treeIterator_skipInorder(iter, 0);
}


static struct SHTreeNode *_nextPreorder(struct SHTreeIterator *it) {
	while(it->current || SH_list_count(it->stack) > 0) {
		if(it->current) {
			struct SHTreeNode *result = it->current;
			SH_list_pushBack(it->stack, it->current);
			it->current = it->current->left;
			return result;
		}
		else {
			struct SHTreeNode *node = SH_list_popBack(it->stack);
			it->current = node->right;
		}
	}
	return NULL;
}


void *SH_treeIterator_skipPreorder(struct SHTreeIterator **iter, uint64_t skip) {
	return _next(iter, skip, _nextPreorder);
}


void *SH_treeIterator_nextPreorder(struct SHTreeIterator **iter) {
	return SH_treeIterator_skipPreorder(iter, 0);
}


static struct SHTreeNode *_nextLineOrder(struct SHTreeIterator *it) {
	struct SHLinkedList *temp = NULL;
	switch(it->stateNum) {
		case _afterInit: goto afterInit;
		case _afterYield: goto afterYield;
		case _afterLineBreak: goto afterLineBreak;
		case _loopStart: goto beforeInnerLoop;
		default:;
	}
	SH_list_pushBack(it->stack, it->current);
	afterInit:
	while(SH_list_count(it->stack) > 0) {
		beforeInnerLoop:
		while(SH_list_count(it->stack) > 0) {
			it->current = SH_list_popFront(it->stack);
			it->stateNum = _afterYield;
			if(!it->current) {
				if(it->tree->nullItemSentinel) {
					_nullNode.item = it->tree->nullItemSentinel;
					it->stateNum = _loopStart;
					return &_nullNode;
				}
				continue;
			}
			return it->current;
			afterYield:
				it->stateNum = _loopStart;
				SH_list_pushBack(it->backupStack, it->current->left);
				SH_list_pushBack(it->backupStack, it->current->right);
		}
		if(it->tree->lineBreakSentinel) {
			_lineBreakNode.item = it->tree->lineBreakSentinel;
			it->stateNum = _afterLineBreak;
			return &_lineBreakNode;
		}
		afterLineBreak:
			it->stateNum = _afterInit;
			temp = it->stack;
			it->stack = it->backupStack;
			it->backupStack = temp;
	}
	return NULL;
}


void *SH_treeIterator_skipLineOrder(struct SHTreeIterator **iter, uint64_t skip)
{
	return _next(iter, skip, _nextLineOrder);
}


void *SH_treeIterator_nextLineOrder(struct SHTreeIterator **iter) {
	return SH_treeIterator_skipLineOrder(iter, 0);
}


struct SHTreeIterator *SH_treeIterator_init(struct SHTree *tree) {
	if(!tree) return NULL;
	struct SHTreeIterator *iter = malloc(sizeof(struct SHTreeIterator));
	iter->tree = tree;
	iter->current = tree->root;
	iter->stack = SH_list_init(NULL);
	iter->backupStack = SH_list_init(NULL);
	iter->version = tree->version;
	iter->postOrderCurrent = NULL;
	iter->last = NULL;
	iter->stateNum = _start;
	
	return iter;
}



void SH_tree_cleanup(struct SHTree **treeP2) {
	if(!treeP2) return;
	struct SHTree *tree = *treeP2;
	if(!tree) return;
	struct SHTreeIterator *iter = SH_treeIterator_init(tree);
	struct SHTreeNode *node = NULL;
	struct SHTreeNode *prev = NULL;
	while((node = _nextPostOrder(iter))) {
		_nodeCleanup(prev, tree->itemCleanup);
		prev = node;
	}
	if(tree->itemCleanup) {
		tree->itemCleanup(tree->lineBreakSentinel);
		tree->itemCleanup(tree->nullItemSentinel);
	}
	_nodeCleanup(prev, tree->itemCleanup);
	_iteratorCleanup(iter);
	free(tree);
	*treeP2 = NULL;
}


void SH_tree_cleanup2(void **args) {
	SH_tree_cleanup((struct SHTree **)args);
}

char * SH_tree_printLineOrder(struct SHTree *tree, char *(*itemDescFn)(void *)) {
	if(!tree || !itemDescFn) return NULL;
	struct SHTreeIterator *iter = SH_treeIterator_init(tree);
	void *item = SH_treeIterator_nextLineOrder(&iter);
	if(!item) return SH_constStrCopy("");
	char *itemDesc = itemDescFn(item);
	if(!itemDesc) {
		itemDesc = SH_constStrCopy("");
	}
	int32_t itemStrLen = strlen(itemDesc);
	uint64_t currentMaxLen = (itemStrLen * SH_tree_count(tree));
	char * result = malloc(sizeof(char) * (currentMaxLen + SH_NULL_CHAR_OFFSET));
	if(!result) return NULL;
	*result = 0;
	char *cat = result;
	cat = strncat(cat, itemDesc, itemStrLen + SH_NULL_CHAR_OFFSET);
	uint64_t currentLen = itemStrLen + SH_NULL_CHAR_OFFSET;
	while((item = SH_treeIterator_nextLineOrder(&iter))) {
		if(itemDesc) {
			free(itemDesc);
		}
		itemDesc = itemDescFn(item);
		if(!itemDesc) {
			itemDesc = SH_constStrCopy("");
		}
		itemStrLen = strlen(itemDesc);
		if((currentLen + itemStrLen) >= currentMaxLen) {
			currentMaxLen *= 2;
			result = realloc(result, currentMaxLen);
			if(!result) {
				return NULL;
			}
			cat = result + currentLen -1;
		}
		currentLen += itemStrLen;
		strncat(cat, itemDesc, itemStrLen);
	}
	if(itemDesc) {
		free(itemDesc);
	}
	return result;
}

