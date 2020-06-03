//
//  SHSerialQueue.h
//  SHUtils_C
//
//  Created by Joel Pridgen on 5/23/20.
//  Copyright © 2020 Joel Gillette. All rights reserved.
//

#ifndef SHSerialQueue_h
#define SHSerialQueue_h

#include "SHErrorHandling.h"
#include <stdio.h>

struct SHSerialQueue;
struct SHQueueStore;
SHErrorCode SH_startSerialQueueLoop(struct SHSerialQueue *queue);
SHErrorCode SH_addOp(struct SHSerialQueue *queue,
	SHErrorCode (*fn)(void*, struct SHQueueStore *), void *fnArgs, void (*cleanupFn)(void*));
struct SHSerialQueue * SH_initSerialQueue(void *(*getStoreItem)(void*), void (*storeCleanup)(void*),
	void *initArgs, void (*initArgsCleanup)(void*));
void *SH_getUserItemFromStore(struct SHQueueStore *store);
SHErrorCode SH_startSerialQueueLoop(struct SHSerialQueue *queue);
void SH_freeSerialQueue(struct SHSerialQueue *queue);
#endif /* SHSerialQueue_h */
