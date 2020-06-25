//
//  SHSyncedList.h
//  SHUtils_C
//
//  Created by Joel Pridgen on 6/23/20.
//  Copyright © 2020 Joel Gillette. All rights reserved.
//

#ifndef SHSyncedList_h
#define SHSyncedList_h

#include "SHIterableWrapper.h"
#include "SHErrorHandling.h"
#include <stdio.h>
#include <stdbool.h>

struct SHSyncedList;

struct SHSyncedList * SH_syncedList_init(struct SHIterableWrapper *iterable);

bool SH_syncedList_isSqueezeMode(struct SHSyncedList *list);
SHErrorCode SH_syncedList_setIsSqueezeMode(struct SHSyncedList *list, bool value);

SHErrorCode SH_syncedList_pushBack(struct SHSyncedList *list, void *item);
void *SH_syncedList_popFront(struct SHSyncedList *list);
void *SH_syncedList_waitForPopFront(struct SHSyncedList *list);
void *SH_syncedList_popBack(struct SHSyncedList *list);
void *SH_syncedList_getBack(struct SHSyncedList *list);
void *SH_syncedList_getFront(struct SHSyncedList *list);
uint64_t SH_syncedList_count(struct SHSyncedList *list);
SHErrorCode SH_syncedList_runActionOnEmpty(struct SHSyncedList *list, SHErrorCode (*onEmpty)(void *), void* fnArgs);
void SH_syncedList_cleanup(struct SHSyncedList **listP2);


#endif /* SHSyncedList_h */
