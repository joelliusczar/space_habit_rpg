//
//  SHPipeline.h
//  SHUtils_C
//
//  Created by Joel Pridgen on 7/11/20.
//  Copyright © 2020 Joel Gillette. All rights reserved.
//

#ifndef SHPipeline_h
#define SHPipeline_h

#include "SHMap.h"
#include "SHIterableWrapper.h"
#include <stdio.h>
#include <inttypes.h>
#include <stdbool.h>

struct SHPipeline;

struct SHPipelineIterator;


struct SHPipeline *SH_pipeline_init(void *source, void *(*genFn)(void*, bool*), void (*sourceCleanup)(void**));


/*
	if an item has been transformed then we try to free it if it is skiped. If it's an original
	element, we leave it alone
*/
struct SHPipeline *SH_pipeline_useTransform(struct SHPipeline *source, void *(*fn)(void*, void*, uint64_t),
	void *fnArgs, void (*fnArgsCleanup)(void **), void (*transformCleanup)(void **));

struct SHPipeline *SH_pipeline_useFilter(struct SHPipeline *source, bool (*fn)(void*, void*, uint64_t),
	void *fnArgs, void (*fnArgsCleanup)(void **));

/*
	retains elements until retrival, then it removes the item from interal containers.
	Then it is upon the function caller to managed to the memory of each returned list
*/
struct SHPipeline *SH_pipeline_useGrouping(struct SHPipeline *source, void *(*fn)(void*, void*, uint64_t),
	void *fnArgs, void (*fnArgsCleanup)(void **), struct SHIterableSetup *iterableSetup,
	int32_t (*sortingFn)(void*, void*), void (*keyCleanup)(void**), void (*itemCleanup)(void**));
	
struct SHPipeline *SH_pipeline_useSkip(struct SHPipeline *source, uint64_t skip);
struct SHPipeline *SH_pipeline_useTake(struct SHPipeline *source, uint64_t skip);

struct SHPipelineIterator *SH_pipelineIterator_init(struct SHPipeline *pipeline);
void *SH_pipelineIterator_next(struct SHPipelineIterator **iter);

void SH_pipeline_cleanup(struct SHPipeline **pipelineP2);
#endif /* SHPipeline_h */
