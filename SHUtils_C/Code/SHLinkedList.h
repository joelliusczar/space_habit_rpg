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
#include <inttypes.h>


struct SHLLNode;

struct SHLinkedList;


struct SHLinkedListIterator {
	struct SHLLNode *current;
};

struct SHLinkedList *SH_list_init(void (*itemCleanup)(void**));
void SH_list_pushBack(struct SHLinkedList *list, void *item);
void * SH_list_popFront(struct SHLinkedList *list);
void * SH_list_popBack(struct SHLinkedList *list);
void * SH_list_getBack(struct SHLinkedList *list);
void * SH_list_getFront(struct SHLinkedList *list);
uint64_t SH_list_count(struct SHLinkedList *list);
void SH_list_cleanup(struct SHLinkedList **listP2);

void SH_listIterator_init(struct SHLinkedList *list, struct SHLinkedListIterator *iter);
void *SH_listIterator_next(struct SHLinkedListIterator *iter);

#endif /* SHLinkedList_h */
