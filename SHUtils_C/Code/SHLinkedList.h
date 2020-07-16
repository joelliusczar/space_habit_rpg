//
//  SHLinkedList.h
//  SHUtils_C
//
//  Created by Joel Pridgen on 6/14/20.
//  Copyright © 2020 Joel Gillette. All rights reserved.
//

#ifndef SHLinkedList_h
#define SHLinkedList_h

#include "SHErrorHandling.h"
#include "SHIterableWrapper.h"
#include <stdio.h>
#include <stdbool.h>
#include <inttypes.h>


struct SHLLNode;

struct SHLinkedList;


struct SHLinkedListIterator {
	struct SHLLNode *current;
};

extern const struct SHIterableSetup listSetup;

struct SHLinkedList *SH_list_init(void (*itemCleanup)(void**));
struct SHLinkedList *SH_list_init2(int32_t (*sortingFn)(void*, void*), void (*itemCleanup)(void**));
SHErrorCode SH_list_pushBack(struct SHLinkedList *list, void *item);
void *SH_list_findNthItem(struct SHLinkedList *list, uint64_t idx);
void *SH_list_popFront(struct SHLinkedList *list);
void *SH_list_popBack(struct SHLinkedList *list);
void *SH_list_getBack(struct SHLinkedList *list);
void *SH_list_getFront(struct SHLinkedList *list);
SHErrorCode SH_list_deleteNthItem(struct SHLinkedList *list, uint64_t idx);
SHErrorCode SH_list_removeMatchingItem(struct SHLinkedList *list, void *item, bool removeAll);
uint64_t SH_list_count(struct SHLinkedList *list);
void SH_list_cleanup(struct SHLinkedList **listP2);
void SH_list_cleanupIgnoreItems(struct SHLinkedList **listP2);

SHErrorCode SH_iterable_loadListFuncs(struct SHIterableWrapperFuncs *funcsObj);

struct SHLinkedListIterator *SH_listIterator_init(struct SHLinkedList *list);
void *SH_listIterator_next(struct SHLinkedListIterator **iter);

struct SHLLNode *SH_list_pushBack2(struct SHLinkedList *list, void *item);

struct SHLLNode *SH_llnode_getNext(struct SHLLNode *node);
struct SHLLNode *SH_llnode_getPrev(struct SHLLNode *node);
void *SH_llnode_getItem(struct SHLLNode *node);
struct SHLLNode *SH_llnode_pushBack(struct SHLLNode *node, void *item);
struct SHLLNode *SH_llnode_getFront(struct SHLLNode *node);

#endif /* SHLinkedList_h */
