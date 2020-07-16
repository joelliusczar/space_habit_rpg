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

struct SHPipeline *SH_pipeline_init(void *source, void *(*genFn)(void*), void (*sourceCleanup)(void**));

struct SHMap *SH_pipeline_completeAsMap(struct SHPipeline *pipeline, void* (*keyProducer)(void*),
	void* (*itemProducer)(void*), uint64_t (*mappingFn)(void*), int32_t (*keyCompareFn)(void*, void*),
	void *(*itemCleanup)(void**),void *(*keyCleanup)(void**));
	
struct SHPipeline *SH_pipeline_useGroupingFn(struct SHPipeline *pipeline, void *(*groupingFn)(void*),
	void (*groupingCleanup)(void**));
//struct SHIterableWrapper *SH_pipeline_completeAsMatrix(struct SHPipeline *pipeline, uint64_t (*groupingFn)(void*),
//	void *(*itemCleanup)(void**));
SHErrorCode SH_pipeline_setIterableTypeSetup(struct SHPipeline *pipeline, struct SHIterableSetup *setup);

void *SH_pipelineIterator_next(struct SHPipelineIterator **iter);
#endif /* SHPipeline_h */
