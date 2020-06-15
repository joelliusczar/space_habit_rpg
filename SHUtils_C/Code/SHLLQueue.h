//
//  SHLinkedList.h
//  SHUtils_C
//
//  Created by Joel Pridgen on 6/14/20.
//  Copyright © 2020 Joel Gillette. All rights reserved.
//

#ifndef SHLLQueue_h
#define SHLLQueue_h

#include <stdio.h>

struct SHLinkedList;

struct SHLinkedList *SH_queue_init(void (*itemCleanup)(void*));
void SH_queue_enqueue(struct SHLinkedList *queue, void *item);
void * SH_queue_dequeue(struct SHLinkedList *queue);
void SH_queue_cleanup(struct SHLinkedList *queue);

#endif /* SHLLQueue_h */
