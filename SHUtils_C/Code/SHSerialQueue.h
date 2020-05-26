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
SHErrorCode SH_startSerialQueueLoop(struct SHSerialQueue *queue);
SHErrorCode SH_addOpToSerialQueue(struct SHSerialQueue *queue, SHErrorCode (*fn)(void*), void *fnArgs,
	void (*cleanupFn)(void*));
struct SHSerialQueue * SH_initSerialQueue(void);
void SH_freeSerialQueue(struct SHSerialQueue *queue);

#endif /* SHSerialQueue_h */
