//
//  SHLinkedList.c
//  SHUtils_C
//
//  Created by Joel Pridgen on 6/14/20.
//  Copyright © 2020 Joel Gillette. All rights reserved.
//

#include "SHLinkedList.h"
#include <stdlib.h>

struct SHLLNode;

struct SHLLNode {
	void *item;
	struct SHLLNode *next;
	struct SHLLNode *prev;
};

struct SHLinkedList {
	struct SHLLNode *front;
	struct SHLLNode *back;
	void (*itemCleanup)(void*);
};


struct SHLinkedList *SH_list_init(void (*itemCleanup)(void*)) {
	struct SHLinkedList *list = malloc(sizeof(struct SHLinkedList));
	list->itemCleanup = itemCleanup;
	list->back = NULL;
	list->front = NULL;
	return list;
}


void SH_list_pushBack(struct SHLinkedList *queue, void *item) {
	if(!queue) return;
	if(!queue->front) {
		queue->front = malloc(sizeof(struct SHLLNode));
		queue->back = queue->front;
		queue->front->item = item;
		queue->front->prev = NULL;
		queue->front->next = NULL;
		return;
	}
	queue->back->next = malloc(sizeof(struct SHLLNode));
	queue->back->next->prev = queue->back;
	queue->back = queue->back->next;
}


void * SH_list_popFront(struct SHLinkedList *queue) {
	if(!queue || !queue->front) return NULL;
	struct SHLLNode *front = queue->front;
	queue->front = front->next;
	if(queue->front) {
		queue->front->prev = NULL;
	}
	else {
		queue->back = NULL;
	}
	void *item = front->item;
	free(front);
	return item;
}


void * SH_list_popBack(struct SHLinkedList *queue) {
	if(!queue || !queue->back) return NULL;
	struct SHLLNode *back = queue->back;
	queue->back = back->prev;
	if(queue->back) {
		queue->back->next = NULL;
	}
	else {
		queue->front = NULL;
	}
	void *item = back->item;
	free(back);
	return item;
}


void SH_listIterator_init(struct SHLinkedList *queue, struct SHLinkedListIterator *iter) {
	iter->current = queue->front;
}


void *SH_listIterator_next(struct SHLinkedListIterator *iter) {
	if(!iter->current) return NULL;
	iter->current = iter->current->next;
	return iter->current->item;
}


void SH_list_cleanup(struct SHLinkedList *queue) {
	if(!queue) return;
	while(queue->front) {
		if(queue->itemCleanup) {
			queue->itemCleanup(queue->front->item);
		}
		struct SHLLNode *trash = queue->front;
		queue->front = queue->front->next;
		free(trash);
	}
	free(queue);
}

