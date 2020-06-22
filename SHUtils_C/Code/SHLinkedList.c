//
//  SHLinkedList.c
//  SHUtils_C
//
//  Created by Joel Pridgen on 6/14/20.
//  Copyright © 2020 Joel Gillette. All rights reserved.
//

#include "SHLinkedList.h"
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
	struct SHLinkedList *list = malloc(sizeof(struct SHLinkedList));
	list->itemCleanup = itemCleanup;
	list->back = NULL;
	list->front = NULL;
	list->count = 0;
	return list;
}



void SH_list_pushBack(struct SHLinkedList *list, void *item) {
	if(!list) return;
	list->count++;
	if(!list->front) {
		list->front = malloc(sizeof(struct SHLLNode));
		*list->front = (struct SHLLNode){0};
		list->back = list->front;
		list->front->item = item;
		return;
	}
	list->back->next = malloc(sizeof(struct SHLLNode));
	*list->back->next = (struct SHLLNode){0};
	list->back->next->prev = list->back;
	list->back = list->back->next;
	list->back->item = item;
}


void * SH_list_popFront(struct SHLinkedList *list) {
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


void * SH_list_popBack(struct SHLinkedList *list) {
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


void * SH_list_getBack(struct SHLinkedList *list) {
	if(!list || !list->back) return NULL;
	return list->back->item;
}


void * SH_list_getFront(struct SHLinkedList *list) {
	if(!list || !list->front) return NULL;
	return list->front->item;
}


uint64_t SH_list_count(struct SHLinkedList *list) {
	if(!list) return 0;
	return list->count;
}


void SH_listIterator_init(struct SHLinkedList *list, struct SHLinkedListIterator *iter) {
	iter->current = list->front;
}


void *SH_listIterator_next(struct SHLinkedListIterator *iter) {
	if(!iter->current) return NULL;
	iter->current = iter->current->next;
	return iter->current->item;
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

