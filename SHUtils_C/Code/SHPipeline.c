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
	SH_PIPELINE_NEXT = 0,
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


struct _groupingPipeline {
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
	struct SHLLNode *nodeLink;
	SHPipelineStage state;
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


static void _cleanup(struct SHPipeline **pipelineP2) {
	if(!pipelineP2) return;
	struct SHPipeline *pipeline = *pipelineP2;
	if(!pipeline) return;
	if(pipeline->sourceCleanup) {
		pipeline->sourceCleanup(pipeline->source);
	}
	if(pipeline->stepFnArgsCleanup) {
		pipeline->stepFnArgsCleanup(pipeline->stepFnArgs);
	}
	free(pipeline);
	*pipelineP2 = NULL;
}


struct SHPipeline *SH_pipeline_init(void *source, void *(*genFn)(void*), void (*sourceCleanup)(void**)) {
	if(!source || !genFn) return NULL;
	struct SHPipeline *pipeline = malloc(sizeof(struct SHPipeline));
	if(!pipeline) return NULL;
	struct SHLinkedList *list = SH_list_init(NULL);
	if(!list) goto allocErr;
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
//	*pipeline = (struct SHPipeline){
//		.source = source,
//		.nodeLink = node,
//		.genFn = (void* (*)(void*))applyFn,
//		.sourceCleanup = SH_pipeline_cleanup;
//		.stepFn = fn,
//		.stepFnArgs = fnArgs,
//		.stepFnArgsCleanup = fnArgsCleanup
//	};
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
	if(!wrapper) {
		*hasNext = false;
		return NULL;
	}
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
		if(!(wrapper = prev->pipeline->genFn(prev, hasNext))) goto fnErr;
		skip = !iter->pipeline->stepFn(wrapper->item, iter->pipeline->source, iter->idx++);
		if(skip && wrapper->itemCleanup) {
			wrapper->itemCleanup(wrapper->item);
		}
		SH_cleanup((void**)&wrapper);
	} while(skip && *hasNext);
	
	
	return wrapper;
	fnErr:
		return NULL;
}


static struct SHIterableWrapper *_groupingApply(struct SHPipelineIterator *iter, bool *hasNext) {
	switch(iter->state) {
		case SH_PIPELINE_NEXT: goto next;
	}
	struct SHPipelineIterator *prev = NULL;
	struct _groupingPipeline *pipeline = NULL;
	struct SHMap *map = NULL;
	struct _itemWrapper *wrapper = NULL;
	uint64_t idx = 0;
	SHErrorCode status = SH_NO_ERROR;
	struct SHIterableWrapper *iterable = NULL;
	init:
		prev = SH_llnode_getItem(SH_llnode_getPrev(iter->nodeLink));
		pipeline = (struct _groupingPipeline*)iter->pipeline;
		map = SH_map_init3(SH_defaultMappingFn, SH_defaultKeyCompareFn, SH_iterable_cleanup,
			pipeline->keyCleanup);
		
		if(!map) return NULL;
		
		*hasNext = true;
		
		while(*hasNext) {
			if(!(wrapper = prev->pipeline->genFn(prev, hasNext))) goto cleanup;
			void *key = pipeline->base.stepFn(wrapper->item, pipeline->base.stepFnArgs, idx++);
			if(!(iterable = SH_map_getItemWithKey(map, key))) {
				iterable = SH_iterable_init(&pipeline->iterableSetup, pipeline->sortingFn, pipeline->itemCleanup);
				if(!iterable) goto cleanup;
				if((status = SH_map_setKeyItem(map, key, iterable)) != SH_NO_ERROR) { goto cleanup; }
			}
			if((status = SH_iterable_addItem(iterable, wrapper->item)) != SH_NO_ERROR) { goto cleanup; }
			SH_cleanup((void**)&wrapper);
		}
		iter->storage = SH_mapKipIterator_init(map);
		iter->state = SH_PIPELINE_NEXT;
		iter->storageCleanup = SH_mapKipIterator_cleanup;
	next:
		map = SH_mapKipIterator_getMap(iter->storage);
		struct SHKeyItemPair *kip = SH_mapKipIterator_next(&iter->storage);
		if(!iter->storage) {
			SH_map_cleanup(&map);
			*hasNext = false;
		}
		wrapper = malloc(sizeof(struct _itemWrapper));
		wrapper->item = kip->item;
		wrapper->itemCleanup = (void (*)(void**))SH_iterable_cleanup;
		return wrapper;
	cleanup:
		*hasNext = false;
		SH_map_cleanup(&map);
		return NULL;
}


struct SHPipeline *SH_pipeline_useTransform(struct SHPipeline *source, void *(*fn)(void*, void*, uint64_t),
	void *fnArgs, void (*fnArgsCleanup)(void **), void (*transformCleanup)(void **))
{
	if(!source || !fn) return NULL;
	struct _transformPipeline *pipeline = _wrapPipeline2(source, _transformApply, fn, fnArgs, fnArgsCleanup,
		sizeof(struct _transformPipeline));
	if(!pipeline) return NULL;
	pipeline->transformedItemCleanup = transformCleanup;
	return pipeline;
}


struct SHPipeline *SH_pipeline_useFilter(struct SHPipeline *source, bool (*fn)(void*, void*, uint64_t),
	void *fnArgs, void (*fnArgsCleanup)(void **))
{
	if(!source || !fn) return NULL;
	struct SHPipeline *pipeline = _wrapPipeline(source, _filterApply, (void *(*)(void*, void*, uint64_t))fn,
		fnArgs, fnArgsCleanup);
	if(!pipeline) return NULL;
	return pipeline;
}


struct SHPipeline *SH_pipeline_useGrouping(struct SHPipeline *source, void *(*fn)(void*, void*, uint64_t),
	void *fnArgs, void (*fnArgsCleanup)(void **), struct SHIterableSetup *iterableSetup,
	int32_t (*sortingFn)(void*, void*), void (*keyCleanup)(void**), void (*itemCleanup)(void**))
{
	if(!source || !fn) return NULL;
	struct _groupingPipeline *pipeline = _wrapPipeline2(source, _transformApply, fn, fnArgs, fnArgsCleanup,
		sizeof(struct _groupingPipeline));
	if(!pipeline) return NULL;
	pipeline->iterableSetup = *iterableSetup;
	pipeline->sortingFn = sortingFn;
	pipeline->keyCleanup = keyCleanup;
	pipeline->itemCleanup = itemCleanup;
	return pipeline;
}


//struct SHMap *SH_pipeline_completeAsMap(struct SHPipeline *pipeline, void* (*keyProducer)(void*),
//	void* (*itemProducer)(void*), uint64_t (*mappingFn)(void*), int32_t (*keyCompareFn)(void*, void*),
//	void *(*itemCleanup)(void**),void *(*keyCleanup)(void**))
//{
//	if(!pipeline || !keyProducer || !itemProducer) return NULL;
//	struct SHMap *map = SH_map_init3(mappingFn, keyCompareFn, itemCleanup, keyCleanup);
//	if(!map) return NULL;
//	void *next = NULL;
//	while((next = _genNext(pipeline))) {
//		void *key = keyProducer(next);
//		void *item = itemProducer(next);
//		if((status = SH_map_setKeyItem(map, key, item)) != SH_NO_ERROR) { goto cleanup; }
//	}
//	return map;
//	cleanup:
//		SH_map_cleanup(&map);
//		return NULL;
//}


static void _iteratorCleanup2(struct SHPipelineIterator **iterP2) {
	if(!iterP2) return;
	struct SHPipelineIterator *iter = *iterP2;
	if(!iter) return;
	if(iter->storageCleanup) {
		iter->storageCleanup(iter->storage);
	}
	
}


static void _iteratorCleanup(struct SHPipelineIterator **iterP2) {
	if(!iterP2) return;
	struct SHPipelineIterator *iter = *iterP2;
	if(!iter) return;
	struct SHLinkedList *list = SH_llnode_getList(iter->nodeLink);
	SH_list_cleanup(&list);
	*iterP2 = NULL;
}


struct SHPipelineIterator *SH_pipelineIterator_init(struct SHPipeline *pipeline) {
	if(!pipeline) return NULL;
	struct SHLinkedList *list = SH_list_init(_iteratorCleanup2);
	if(!list) return NULL;
	struct SHLinkedListIterator *listIter = SH_listIterator_init(SH_llnode_getList(pipeline->nodeLink));
	struct SHPipeline *pipelineStep = NULL;
	struct SHPipelineIterator *iterStep = NULL;
	struct SHLLNode *node = NULL;
	if(!listIter) goto cleanup;
	while(listIter) {
		pipelineStep = (struct SHPipeline *)SH_listIterator_next(&listIter);
		iterStep = malloc(sizeof(struct SHPipelineIterator));
		if(!iterStep) goto cleanup;
		node = SH_list_pushBack2(list, iterStep);
		if(!node) {
			SH_cleanup(&iterStep);
			goto cleanup;
		}
		iterStep->pipeline = pipelineStep;
		iterStep->nodeLink = node;
		iterStep->state = SH_PIPELINE_START;
		iterStep->storage = NULL;
		iterStep->storageCleanup = NULL;
	}
	return iterStep;
	cleanup:
		SH_list_cleanup(&list);
		return NULL;
}


void *SH_pipelineIterator_next(struct SHPipelineIterator **iter) {
	if(!iter) return NULL;
	struct SHPipelineIterator *it = *iter;
	if(!it) return NULL;
	void *item = NULL;
	bool hasNext = true;
	struct SHPipelineIterator *prev = SH_llnode_getItem(SH_llnode_getPrev(it->nodeLink));
	struct _itemWrapper *wrapper = prev->pipeline->genFn(prev, &hasNext);
	if(!hasNext) {
		_iteratorCleanup(iter);
	}
	
	return wrapper->item;
}


void SH_pipeline_cleanup(struct SHPipeline **pipelineP2) {
	if(!pipelineP2) return;
	struct SHPipeline *pipeline = *pipelineP2;
	if(!pipeline) return;
	struct SHLinkedList *list = SH_llnode_getList(pipeline->nodeLink);
	SH_list_cleanup(&list);
	*pipelineP2 = NULL;
}
