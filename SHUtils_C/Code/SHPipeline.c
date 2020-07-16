//
//  SHPipeline.c
//  SHUtils_C
//
//  Created by Joel Pridgen on 7/11/20.
//  Copyright © 2020 Joel Gillette. All rights reserved.
//

#include "SHPipeline.h"
#include "SHLinkedList.h"
#include "SHGenAlgos.h"
#include "SHDynamicArray.h"
#include "SHUtilConstants.h"
#include <stdlib.h>

typedef enum {
	SH_EMPTY_FN = 0,
	SH_FILTER_FN = 1,
	SH_TRANSFORM_FN = 2,
	SH_GROUPING_FN = 3,
} SHFuncType;


typedef enum {
	SH_PIPELINE_START = 0,
} SHPipelineStage;

struct SHPipeline {
	struct SHLLNode *nodeLink;
	void *source;
	void *(*genFn)(void*, bool*);
	void *(*stepFn)(void*, void*, uint64_t);
	void *stepFnArgs;
	void (*stepFnArgsCleanup)(void**);
	void (*sourceCleanup)(void**);
};


struct _groupinPipeline {
	struct SHPipeline base;
	struct SHIterableSetup iterableSetup;
	int32_t (*sortingFn)(void*, void*);
	void (*keyCleanup)(void**);
	void (*itemCleanup)(void**);
};


struct _transformPipeline {
	struct SHPipeline base;
	void (*transformedItemCleanup)(void**);
};


struct SHPipelineIterator {
	struct SHPipeline *pipeline;
	struct SHPipelineState *state;
	struct SHLLNode *nodeLink;
	uint64_t idx;
	void *storage;
	void (*storageCleanup)(void**);
};

/*
	/I thought of if itemCleanup should go on the iterator obj instead, but I decided
	to keep it here because it's possible we may determine that it be freed much later in the
	pipeline process
*/
struct _itemWrapper {
	void *item;
	void (*itemCleanup)(void**);
};


struct SHPipeline *SH_pipeline_init(void *source, void *(*genFn)(void*), void (*sourceCleanup)(void**)) {
	if(!source || !genFn) return NULL;
	struct SHPipeline *pipeline = malloc(sizeof(struct SHPipeline));
	if(!pipeline) return NULL;
	struct SHLinkedList *list = SH_list_init(NULL);
	if(!list) goto allocErr:
	struct SHLLNode *node = SH_list_pushBack2(list, pipeline);
	if(!node) goto allocErr;
	*pipeline = (struct SHPipeline){
		.nodeLink = node,
		.source = source,
		.genFn = genFn,
		.sourceCleanup = sourceCleanup
	};
	return pipeline;
	allocErr:
		SH_list_cleanup(&list);
		SH_pipeline_cleanup(&pipeline);
		return NULL;
}


static struct SHPipeline *_wrapPipeline2(struct SHPipeline *source, void *(*applyFn)(struct SHPipelineIterator *),
	void *(*fn)(void*, void*, uint64_t), void *fnArgs, void (*fnArgsCleanup)(void **), size_t objSize)
{
	struct SHPipeline *pipeline = malloc(objSize);
	if(!pipeline) return NULL;
	struct SHLLNode *node = SH_llnode_pushBack(source->nodeLink, pipeline);
	if(!node) goto allocErr;
	*pipeline = (struct SHPipeline){
		.iterableSetup = *source->iterableSetup,
		.source = source,
		.nodeLink = node,
		.genFn = (void* (*)(void*))applyFn,
		.sourceCleanup = SH_pipeline_cleanup;
		.stepFn = fn,
		.stepFnArgs = fnArgs,
		.stepFnArgsCleanup = fnArgsCleanup
	};
	return pipeline;
	allocErr:
		SH_cleanup((void**)&node);
		SH_pipeline_cleanup(&pipeline);
		return NULL;
}


static struct SHPipeline *_wrapPipeline(struct SHPipeline *source, void *(*applyFn)(struct SHPipelineIterator *),
	void *(*fn)(void*, void*, uint64_t), void *fnArgs, void (*fnArgsCleanup)(void **))
{
	return _wrapPipeline2(source, applyFn, fn, fnArgs, fnArgsCleanup, sizeof(struct SHPipeline));
}



static struct _itemWrapper *_sourceApply(struct SHPipelineIterator *iter, bool *hasNext) {
	struct _itemWrapper *wrapper = calloc(1, sizeof(struct _itemWrapper));
	if(!wrapper) return NULL;
	wrapper->item = iter->pipeline->genFn(iter->pipeline->source, hasNext);
	
	return wrapper;
}


static struct _itemWrapper *_transformApply(struct SHPipelineIterator *iter, bool *hasNext) {
	struct SHPipelineIterator *prev = SH_llnode_getItem(SH_llnode_getPrev(iter->nodeLink));
	struct _itemWrapper *wrapper = prev->pipeline->genFn(prev, hasNext);
	struct _transformPipeline *pipeline = (struct _transformPipeline*)iter->pipeline;
	if(!wrapper) return NULL;
	void *transformed = iter->pipeline->stepFn(wrapper->item, iter->pipeline->source, iter->idx++);
	if(wrapper->itemCleanup) {
		wrapper->itemCleanup(wrapper->item);
	}
	wrapper->item = transformed;
	wrapper->itemCleanup = pipeline->transformedItemCleanup; //new item, new cleanup
	
	return wrapper;
}


static struct _itemWrapper *_filterApply(struct SHPipelineIterator *iter, bool *hasNext) {
	struct SHPipelineIterator *prev = SH_llnode_getItem(SH_llnode_getPrev(iter->nodeLink));
	bool skip = true;
	struct _itemWrapper *wrapper = NULL;
	do {
		wrapper = prev->genFn(prev, hasNext);
		skip = !iter->pipeline->stepFn(wrapper->item, iter->pipeline->source, iter->idx++);
		if(skip && wrapper->itemCleanup) {
			wrapper->itemCleanup(wrapper->item);
		}
		SH_cleanup((void**)&wrapper);
	} while(skip && *hasNext)
	
	
	return wrapper;
}


static struct SHIterableWrapper *_groupingApply(struct SHPipelineIterator *iter, bool *hasNext) {
	init:
		struct SHPipelineIterator *prev = SH_llnode_getItem(SH_llnode_getPrev(iter->nodeLink));
		struct _groupinPipeline *pipeline = (struct _groupinPipeline*)iter->pipeline;
		struct SHMap *map = SH_map_init3(SH_defaultMappingFn, SH_defaultKeyCompareFn, SH_iterable_cleanup,
			iter->pipeline->keyCleanup);
		SHErrorCode status = SH_NO_ERROR;
		if(!map) return NULL;
		struct _itemWrapper *wrapper = NULL;
		uint64_t idx = 0;
		*hasNext = true;
		struct SHIterableWrapper *iterable = NULL;
		while(*hasNext) {
			wrapper = prev->pipeline->genFn(prev, hasNext)
			void *key = pipeline->base.stepFn(wrapper->item, pipeline->base.stepFnArgs, idx++);
			if(!(iterable = SH_map_getItemWithKey(map, key))) {
				iterable = SH_iterable_init(pipeline->iterableSetup, pipeline->sortingFn, pipeline->itemCleanup);
				if(!iterable) goto cleanup;
				if((status = SH_map_setKeyItem(map, key, iterable)) != SH_NO_ERROR) { goto cleanup; }
			}
			if((status = SH_iterable_addItem(iterable, wrapper->item)) != SH_NO_ERROR) { goto cleanup; }
			SH_cleanup((void**)&wrapper);
		}
		iter->storage = map;
	next:
		
	cleanup:
		SH_map_cleanup(&map);
		return NULL;
}


struct SHPipeline *SH_pipeline_useTransform(struct SHPipeline *source, void *(*fn)(void*, void*, uint64_t),
	void *fnArgs, void (*fnArgsCleanup)(void **), void (*transformCleanup)(void **))
{
	struct _transformPipeline *pipeline = _wrapPipeline2(source, _transformApply, fn, fnArgs, fnArgsCleanup,
		sizeof(struct _transformPipeline));
	pipeline->transformedItemCleanup = transformCleanup;
	return pipeline;
}


struct SHPipeline *SH_pipeline_useFilter(struct SHPipeline *source, bool (*fn)(void*, void*, uint64_t),
	void *fnArgs, void (*fnArgsCleanup)(void **))
{
	struct SHPipeline *pipeline = _wrapPipeline(source, _filterApply, (void *(*fn)(void*, void*, uint64_t))fn,
		fnArgs, fnArgsCleanup);
		
	return pipeline;
}


struct SHMap *SH_pipeline_completeAsMap(struct SHPipeline *pipeline, void* (*keyProducer)(void*),
	void* (*itemProducer)(void*), uint64_t (*mappingFn)(void*), int32_t (*keyCompareFn)(void*, void*),
	void *(*itemCleanup)(void**),void *(*keyCleanup)(void**))
{
	if(!pipeline || !keyProducer || !itemProducer) return NULL;
	struct SHMap *map = SH_map_init3(mappingFn, keyCompareFn, itemCleanup, keyCleanup);
	if(!map) return NULL;
	void *next = NULL;
	while((next = _genNext(pipeline))) {
		void *key = keyProducer(next);
		void *item = itemProducer(next);
		if((status = SH_map_setKeyItem(map, key, item)) != SH_NO_ERROR) { goto cleanup; }
	}
	return map;
	cleanup:
		SH_map_cleanup(&map);
		return NULL;
}



SHErrorCode SH_pipeline_setIterableTypeSetup(struct SHPipeline *pipeline, struct SHIterableSetup *setup) {
	if(!pipeline || !setup) return SH_ILLEGAL_INPUTS;
	pipeline->iterableSetup = *setup;
	return SH_NO_ERROR;
}


void *SH_pipelineIterator_next(struct SHPipelineIterator **iter) {
	if(!iter) return NULL;
	struct SHPipelineIterator *it = *iter;
	if(!it) return NULL;
	void *item = NULL;
	if(!(item = _genNext(it->state))) {
		
	}
	return item;
}


void SH_pipeline_cleanup(struct SHPipeline **pipelineP2) {}
