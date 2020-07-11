//
//  SHLinkedList.c
//  SHUtils_C
//
//  Created by Joel Pridgen on 6/14/20.
//  Copyright © 2020 Joel Gillette. All rights reserved.
//

#include "SHLinkedList.h"
#include "SHGenAlgos.h"
#include <stdlib.h>


struct SHLLNode {
	void *item;
	struct SHLLNode *next;
	struct SHLLNode *prev;
};

struct SHLinkedList {
	struct SHLLNode *front;
	struct SHLLNode *back;
	void (*itemCleanup)(void**);
	uint64_t count;
};


struct SHLinkedList *SH_list_init(void (*itemCleanup)(void**)) {
	return SH_list_init2(NULL, itemCleanup);
}


struct SHLinkedList *SH_list_init2(int32_t (*sortingFn)(void*, void*), void (*itemCleanup)(void**)) {
	(void)sortingFn;
	struct SHLinkedList *list = malloc(sizeof(struct SHLinkedList));
	if(!list) goto allocErr;
	list->itemCleanup = itemCleanup;
	list->back = NULL;
	list->front = NULL;
	list->count = 0;
	return list;
	allocErr:
		SH_notifyOfError(SH_ALLOC_NO_MEM, "Failed to allocate memory in SH_list_init2");
		return NULL;
}



SHErrorCode SH_list_pushBack(struct SHLinkedList *list, void *item) {
	if(!list) return SH_ILLEGAL_INPUTS;
	SHErrorCode status = SH_NO_ERROR;
	struct SHLLNode *newNode = NULL;
	list->count++;
	if(!list->front) {
		newNode =  malloc(sizeof(struct SHLLNode));
		if(!newNode) goto allocErr;
		
		*newNode = (struct SHLLNode){0};
		list->front = newNode;
		list->back = newNode;
		newNode->item = item;
		goto fnExit;
	}
	newNode =  malloc(sizeof(struct SHLLNode));
	if(!newNode) goto allocErr;
	
	*newNode = (struct SHLLNode){0};
	list->back->next = newNode;
	newNode->prev = list->back;
	list->back = list->back->next;
	newNode->item = item;
	fnExit:
		return status;
	allocErr:
		return SH_ALLOC_NO_MEM;
}


struct SHLLNode *_searchFromFront(struct SHLinkedList *list, uint64_t count) {
	struct SHLLNode *node = SH_list_getFront(list);
	for(uint64_t i = 0; i < count; i++) {
		node = node->next;
	}
	return node;
}


struct SHLLNode *_searchFromBack(struct SHLinkedList *list, uint64_t count) {
	struct SHLLNode *node = SH_list_getBack(list);
	for(uint64_t i = 0; i < count; i++) {
		node = node->prev;
	}
	return node;
}


void *SH_list_findNthItem(struct SHLinkedList *list, uint64_t idx) {
	uint64_t count = SH_list_count(list);
	if(count < 1 || idx >= count) return NULL;
	if(idx == 0) {
		return SH_list_getFront(list);
	}
	else if(idx == count - 1) {
		return SH_list_getBack(list);
	}
	uint64_t mid = count / 2;
	struct SHLLNode *node = NULL;
	if(idx <= mid) {
		node = _searchFromFront(list, mid + 1);
	}
	else {
		node = _searchFromBack(list, mid);
	}
	return node->item;
}


SHErrorCode SH_list_deleteNthItem(struct SHLinkedList *list, uint64_t idx) {
	if(!list) return SH_ILLEGAL_INPUTS;
	SHErrorCode status = SH_NO_ERROR;
	uint64_t count = SH_list_count(list);
	if(count < 1 || idx >= count) return SH_OUT_OF_RANGE;
	if(idx == 0) {
		void *item = SH_list_popFront(list);
		if(list->itemCleanup) list->itemCleanup(item);
	}
	else if(idx == count - 1) {
		void *item = SH_list_popBack(list);
		if(list->itemCleanup) list->itemCleanup(item);
	}
	uint64_t mid = count / 2;
	struct SHLLNode *node = NULL;
	if(idx <= mid) {
		node = _searchFromFront(list, mid + 1);
	}
	else {
		node = _searchFromBack(list, mid);
	}
	struct SHLLNode *next = node->next;
	struct SHLLNode *prev = node->prev;
	next->prev = prev;
	prev->next = next;
	if(list->itemCleanup) {
		list->itemCleanup(&node->item);
	}
	SH_cleanup((void**)&node);
	return status;
}


void *SH_list_popFront(struct SHLinkedList *list) {
	if(!list || !list->front) return NULL;
	list->count--;
	struct SHLLNode *front = list->front;
	list->front = front->next;
	if(list->front) {
		list->front->prev = NULL;
	}
	else {
		list->back = NULL;
	}
	void *item = front->item;
	free(front);
	return item;
}


void *SH_list_popBack(struct SHLinkedList *list) {
	if(!list || !list->back) return NULL;
	list->count--;
	struct SHLLNode *back = list->back;
	list->back = back->prev;
	if(list->back) {
		list->back->next = NULL;
	}
	else {
		list->front = NULL;
	}
	void *item = back->item;
	free(back);
	return item;
}


void *SH_list_getBack(struct SHLinkedList *list) {
	if(!list || !list->back) return NULL;
	return list->back->item;
}


void *SH_list_getFront(struct SHLinkedList *list) {
	if(!list || !list->front) return NULL;
	return list->front->item;
}


uint64_t SH_list_count(struct SHLinkedList *list) {
	if(!list) return 0;
	return list->count;
}


struct SHLinkedListIterator *SH_listIterator_init(struct SHLinkedList *list) {
	if(!list) return NULL;
	struct SHLinkedListIterator *iter = malloc(sizeof(struct SHLinkedListIterator));
	if(!iter) goto allocErr;
	
	iter->current = list->front;
	return iter;
	allocErr:
		return NULL;
}


void *SH_listIterator_next(struct SHLinkedListIterator **iterP2) {
	if(!iterP2) return NULL;
	struct SHLinkedListIterator *iter = *iterP2;
	if(!iter) return NULL;
	iter->current = iter->current->next;
	if(!iter->current) {
		free(iter);
		*iterP2 = NULL;
		return NULL;
	}
	return iter->current->item;
}


SHErrorCode SH_iterable_loadListFuncs(struct SHIterableWrapperFuncs *funcsObj) {
	funcsObj->count = (uint64_t (*)(void*))SH_list_count;
	funcsObj->addItem = (SHErrorCode (*)(void*, void*))SH_list_pushBack;
	funcsObj->getItemAtIdx = (void *(*)(void*, uint64_t))SH_list_findNthItem;
	funcsObj->getFront = (void* (*)(void*))SH_list_getFront;
	funcsObj->popFront = (void* (*)(void*))SH_list_popFront;
	funcsObj->getBack = (void* (*)(void*))SH_list_getBack;
	funcsObj->popBack = (void* (*)(void*))SH_list_popBack;
	funcsObj->deleteItemAtIdx = (SHErrorCode (*)(void*, uint64_t))SH_list_deleteNthItem;
	funcsObj->iteratorInit = (void* (*)(void*))SH_listIterator_init;
	funcsObj->iteratorNext = (void* (*)(void**))SH_listIterator_next;
	funcsObj->itemCleanup = (void (*)(void**))SH_list_cleanup;
	return SH_NO_ERROR;
}


void SH_list_cleanup(struct SHLinkedList **listP2) {
	if(!listP2) return;
	struct SHLinkedList *list = *listP2;
	if(!list) return;
	while(list->front) {
		if(list->itemCleanup) {
			list->itemCleanup(list->front->item);
		}
		struct SHLLNode *trash = list->front;
		list->front = list->front->next;
		free(trash);
		trash = NULL;
	}
	free(list);
	*listP2 = NULL;
}

