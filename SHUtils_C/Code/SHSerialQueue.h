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
struct SHSerialQueue * SH_serialQueue_init(void *initArgs, void (*initArgsCleanup)(void*));
	
SHErrorCode SH_serialQueue_startLoop(struct SHSerialQueue *queue);
SHErrorCode SH_serialQueue_addOp(
	struct SHSerialQueue *queue,
	SHErrorCode (*fn)(void*, struct SHQueueStore *),
	void *fnArgs, void (*cleanupFn)(void*));
	
SHErrorCode SH_addOpAndWaitForResult(
	struct SHSerialQueue *queue,
	SHErrorCode (*fn)(void*, struct SHQueueStore *, void**),
	void *fnArgs,
	void (*cleanupFn)(void*),
	void **result);

void *SH_serialQueue_getUserItem(struct SHQueueStore *store);
SHErrorCode SH_serialQueue_startLoop(struct SHSerialQueue *queue);
void SH_serialQueue_cleanup(struct SHSerialQueue *queue);
#endif /* SHSerialQueue_h */
