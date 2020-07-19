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
	SH_SOURCE_FN = 1,
	SH_FILTER_FN = 2,
	SH_TRANSFORM_FN = 3,
	SH_GROUPING_FN = 4,
	SH_SKIP_FN = 5,
} SHFuncType;


typedef enum {
	SH_PIPELINE_START = 0,
	SH_PIPELINE_NEXT = 1,
	SH_PIPELINE_DONE = 2,
} SHPipelineStage;

struct SHPipeline {
	struct SHLLNode *nodeLink;
	void *source;
	void *(*genFn)(void*, bool*);
	void *(*stepFn)(void*, void*, uint64_t);
	void *stepFnArgs;
	void (*stepFnArgsCleanup)(void**);
	void (*sourceCleanup)(void**);
	uint64_t limit;
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


static struct _itemWrapper *_sourceApply(struct SHPipelineIterator *iter, bool *hasNext);


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


static struct SHPipeline *_init(struct SHLinkedList *list, void *source, void *(*genFn)(void*, bool*),
	void (*sourceCleanup)(void**))
{
	struct SHPipeline *pipeline = malloc(sizeof(struct SHPipeline));
	if(!pipeline) return NULL;
	struct SHLLNode *node = SH_list_pushBack2(list, pipeline);
	if(!node) goto allocErr;
	*pipeline = (struct SHPipeline){
		.nodeLink = node,
		.source = source,
		.genFn = genFn,
		.sourceCleanup = sourceCleanup,
		.limit = -1
	};
	return pipeline;
	allocErr:
		SH_pipeline_cleanup(&pipeline);
		return NULL;
}


static struct SHPipeline *_wrapPipeline2(struct SHPipeline *source,
	struct _itemWrapper *(*genFn)(struct SHPipelineIterator *, bool *),
	void *(*fn)(void*, void*, uint64_t), void *fnArgs, void (*fnArgsCleanup)(void **), size_t objSize)
{
	struct SHPipeline *pipeline = malloc(objSize);
	if(!pipeline) return NULL;
	struct SHLLNode *node = SH_llnode_pushBack(source->nodeLink, pipeline);
	if(!node) goto allocErr;
	*pipeline = (struct SHPipeline){
		.source = source,
		.nodeLink = node,
		.genFn = (void* (*)(void*, bool*))genFn,
		.sourceCleanup = (void (*)(void**))SH_pipeline_cleanup,
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


static struct SHPipeline *_wrapPipeline(struct SHPipeline *source,
	struct _itemWrapper *(*genFn)(struct SHPipelineIterator *, bool*),
	void *(*fn)(void*, void*, uint64_t), void *fnArgs, void (*fnArgsCleanup)(void **))
{
	return _wrapPipeline2(source, genFn, fn, fnArgs, fnArgsCleanup, sizeof(struct SHPipeline));
}


struct SHPipeline *SH_pipeline_init(void *source, void *(*genFn)(void*, bool*), void (*sourceCleanup)(void**)) {
	if(!source || !genFn) return NULL;
	struct SHLinkedList *list = SH_list_init((void (*)(void**))_cleanup);
	struct SHPipeline *pipelineBase = NULL;
	struct SHPipeline *pipelineBootstrap = NULL;
	if(!list) return NULL;
	if(!(pipelineBase = _init(list, source, genFn, sourceCleanup))) goto cleanup;
	if(!(pipelineBootstrap = _init(list, pipelineBase, (void *(*)(void*, bool*))_sourceApply, sourceCleanup))) goto cleanup;
	return pipelineBootstrap;
	cleanup:
		SH_list_cleanup(&list);
		return NULL;
}


static struct _itemWrapper *_sourceApply(struct SHPipelineIterator *iter, bool *hasNext) {
	struct SHPipelineIterator *prevIter = SH_llnode_getItem(SH_llnode_getPrev(iter->nodeLink));
	struct _itemWrapper *wrapper = calloc(1, sizeof(struct _itemWrapper));
	if(!wrapper) {
		*hasNext = false;
		return NULL;
	}
	wrapper->item = prevIter->pipeline->genFn(prevIter->pipeline->source, hasNext);
	wrapper->itemCleanup = NULL;
	return wrapper;
}


static struct _itemWrapper *_transformApply(struct SHPipelineIterator *iter, bool *hasNext) {
	struct SHPipelineIterator *prevIter = SH_llnode_getItem(SH_llnode_getPrev(iter->nodeLink));
	struct _itemWrapper *wrapper = NULL;
	if(!(wrapper = prevIter->pipeline->genFn(prevIter, hasNext))) goto fnErr;
	struct _transformPipeline *tr_pipeline = (struct _transformPipeline*)iter->pipeline;
	void *transformed = iter->pipeline->stepFn(wrapper->item, iter->pipeline->source, iter->idx++);
	if(wrapper->itemCleanup) {
		wrapper->itemCleanup(wrapper->item);
	}
	wrapper->item = transformed;
	wrapper->itemCleanup = tr_pipeline->transformedItemCleanup; //new item, new cleanup
	
	return wrapper;
	fnErr:
		return NULL;
}


static struct _itemWrapper *_filterApply2(struct SHPipelineIterator *iter, bool *hasNext) {
	struct SHPipelineIterator *prevIter = SH_llnode_getItem(SH_llnode_getPrev(iter->nodeLink));
	bool skip = true;
	struct _itemWrapper *wrapper = NULL;
	do {
		if(!(wrapper = prevIter->pipeline->genFn(prevIter, hasNext))) goto fnErr;
		skip = !iter->pipeline->stepFn(wrapper->item, iter->pipeline->source, iter->idx++);
		if(skip) {
			if(wrapper->itemCleanup){
				wrapper->itemCleanup(&wrapper->item);
			}
			SH_cleanup((void**)&wrapper);
		}
		
	} while(skip && *hasNext);
	
	return wrapper;
	fnErr:
		return NULL;
}

/*
	we want to exhaust the list even if there are no valid elements left.
	so we potential do a search twice.
*/
static struct _itemWrapper *_filterApply(struct SHPipelineIterator *iter, bool *hasNext) {
	struct _itemWrapper *wrapper = NULL;
	if(iter->storage) {
		wrapper = iter->storage;
	}
	else {
		wrapper = _filterApply2(iter, hasNext);
	}
	
	//if we had previously exhausted list, set hasNext
	if(iter->state == SH_PIPELINE_DONE) {
		*hasNext = false;
	}
	//scan to exhaust list
	if(*hasNext) {
		
		iter->storage = _filterApply2(iter, hasNext);
		//if last item passes filter, we want to unset the hasNext flag
		// so that iteration does not end prematurely
		//we use iter->state to help with state in that situation.
		if(iter->storage && !*hasNext) {
			*hasNext = true;
			iter->state = SH_PIPELINE_DONE;
		}
	}
	return wrapper;
	
}


static struct _itemWrapper *_groupingApply(struct SHPipelineIterator *iter, bool *hasNext) {
	switch(iter->state) {
		case SH_PIPELINE_NEXT: goto next;
		default: break;
	}
	struct SHPipelineIterator *prevIter = NULL;
	struct _groupingPipeline *pipeline = NULL;
	struct SHMap *map = NULL;
	struct _itemWrapper *wrapper = NULL;
	uint64_t idx = 0;
	SHErrorCode status = SH_NO_ERROR;
	struct SHIterableWrapper *iterable = NULL;
	prevIter = SH_llnode_getItem(SH_llnode_getPrev(iter->nodeLink));
	pipeline = (struct _groupingPipeline*)iter->pipeline;
	map = SH_map_init3(SH_defaultMappingFn, SH_defaultKeyCompareFn, (void (*)(void**))SH_iterable_cleanup,
		pipeline->keyCleanup);
	
	if(!map) return NULL;
	
	*hasNext = true;
	
	while(*hasNext) {
		if(!(wrapper = prevIter->pipeline->genFn(prevIter, hasNext))) goto cleanup;
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
	iter->storageCleanup = (void (*)(void**))SH_mapKipIterator_cleanup;
	next:
		map = SH_mapKipIterator_getMap(iter->storage);
		struct SHKeyItemPair *kip = SH_mapKipIterator_next((struct SHMapKipIterator **)&iter->storage);
		if(!iter->storage) {
			SH_map_cleanup(&map);
			*hasNext = false;
		}
		wrapper = malloc(sizeof(struct _itemWrapper));
		wrapper->item = kip->item;
		wrapper->itemCleanup = (void (*)(void**))SH_iterable_cleanup;
		SH_map_removeItemWithKey(map, wrapper->item);
		return wrapper;
	cleanup:
		*hasNext = false;
		SH_map_cleanup(&map);
		return NULL;
}


static struct _itemWrapper *_skipApply(struct SHPipelineIterator *iter, bool *hasNext) {
	struct SHPipelineIterator *prevIter = SH_llnode_getItem(SH_llnode_getPrev(iter->nodeLink));
	struct _itemWrapper *wrapper = NULL;
	while(iter->idx < iter->pipeline->limit && *hasNext) {
		if(!(wrapper = prevIter->pipeline->genFn(prevIter, hasNext))) goto fnErr;
		if(wrapper->itemCleanup) {
			wrapper->itemCleanup(&wrapper->item);
		}
		iter->idx++;
	}
	if(!(wrapper = prevIter->pipeline->genFn(prevIter, hasNext))) goto fnErr;
	return wrapper;
	fnErr:
		return NULL;
}


static struct _itemWrapper *_takeApply(struct SHPipelineIterator *iter, bool *hasNext) {
	struct SHPipelineIterator *prevIter = SH_llnode_getItem(SH_llnode_getPrev(iter->nodeLink));
	struct _itemWrapper *wrapper = NULL;
	if(iter->idx >= iter->pipeline->limit || !*hasNext) return NULL;;
	if(!(wrapper = prevIter->pipeline->genFn(prevIter, hasNext))) goto fnErr;
	iter->idx++;
	if(iter->idx >= iter->pipeline->limit) {
		*hasNext = false;
	}
	return wrapper;
	fnErr:
		return NULL;
}


struct SHPipeline *SH_pipeline_useTransform(struct SHPipeline *source, void *(*fn)(void*, void*, uint64_t),
	void *fnArgs, void (*fnArgsCleanup)(void **), void (*transformCleanup)(void **))
{
	if(!source || !fn) return NULL;
	struct _transformPipeline *pipeline = (struct _transformPipeline *)_wrapPipeline2(source,
		_transformApply, fn, fnArgs, fnArgsCleanup,
		sizeof(struct _transformPipeline));
	if(!pipeline) return NULL;
	pipeline->transformedItemCleanup = transformCleanup;
	return (struct SHPipeline*)pipeline;
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
	struct _groupingPipeline *pipeline = (struct _groupingPipeline *)_wrapPipeline2(source, _groupingApply, fn, fnArgs, fnArgsCleanup,
		sizeof(struct _groupingPipeline));
	if(!pipeline) return NULL;
	pipeline->iterableSetup = *iterableSetup;
	pipeline->sortingFn = sortingFn;
	pipeline->keyCleanup = keyCleanup;
	pipeline->itemCleanup = itemCleanup;
	return (struct SHPipeline*)pipeline;
}


struct SHPipeline *SH_pipeline_useSkip(struct SHPipeline *source, uint64_t skip)
{
	if(!source) return NULL;
	struct SHPipeline *pipeline = _wrapPipeline(source, _skipApply, NULL, NULL, NULL);
	if(!pipeline) return NULL;
	pipeline->limit = skip;
	return pipeline;
}


struct SHPipeline *SH_pipeline_useTake(struct SHPipeline *source, uint64_t skip)
{
	if(!source) return NULL;
	struct SHPipeline *pipeline = _wrapPipeline(source, _takeApply, NULL, NULL, NULL);
	if(!pipeline) return NULL;
	pipeline->limit = skip;
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
	struct SHLinkedList *list = SH_list_init((void (*)(void**))_iteratorCleanup2);
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
			SH_cleanup((void**)&iterStep);
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
	struct _itemWrapper *wrapper = it->pipeline->genFn(it, &hasNext);
	if(!hasNext) {
		_iteratorCleanup(iter);
	}
	item = wrapper ? wrapper->item : NULL;
	SH_cleanup((void**)&wrapper);
	return item;
}


void SH_pipeline_cleanup(struct SHPipeline **pipelineP2) {
	if(!pipelineP2) return;
	struct SHPipeline *pipeline = *pipelineP2;
	if(!pipeline) return;
	struct SHLinkedList *list = SH_llnode_getList(pipeline->nodeLink);
	SH_list_cleanup(&list);
	*pipelineP2 = NULL;
}
