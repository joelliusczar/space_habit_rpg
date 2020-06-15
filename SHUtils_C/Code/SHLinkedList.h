//
//  SHLinkedList.h
//  SHUtils_C
//
//  Created by Joel Pridgen on 6/14/20.
//  Copyright © 2020 Joel Gillette. All rights reserved.
//

#ifndef SHLinkedList_h
#define SHLinkedList_h

#include <stdio.h>

struct SHLinkedList;
struct SHLLNode;

struct SHLinkedListIterator {
	struct SHLLNode *current;
};

struct SHLinkedList *SH_list_init(void (*itemCleanup)(void*));
void SH_list_pushBack(struct SHLinkedList *queue, void *item);
void * SH_list_popFront(struct SHLinkedList *queue);
void * SH_list_popBack(struct SHLinkedList *queue);
void SH_list_cleanup(struct SHLinkedList *queue);

void SH_listIterator_init(struct SHLinkedList *queue, struct SHLinkedListIterator *iter);
void *SH_listIterator_next(struct SHLinkedListIterator *iter);

#endif /* SHLinkedList_h */
