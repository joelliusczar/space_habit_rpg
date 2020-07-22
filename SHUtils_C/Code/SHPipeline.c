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
	void (*stepFnArgsCleanup)(void*);
	void (*sourceCleanup)(void*);
	void (*unusedItemCleanup)(void*);
	uint64_t limit;
};


struct _groupingPipeline {
	struct SHPipeline base;
	struct SHIterableSetup iterableSetup;
	int32_t (*sortingFn)(void*, void*);
	void (*keyCleanup)(void*);
};


struct SHPipelineIterator {
	struct SHPipeline *pipeline;
	struct SHLLNode *nodeLink;
	SHPipelineStage state;
	uint64_t idx;
	void *storage;
	void (*storageCleanup)(void*);
	void (*unusedItemCleanup)(void*);
};


static void *_sourceApply(struct SHPipelineIterator *iter, bool *hasNext);


static void _cleanup(struct SHPipeline *pipeline) {
	if(!pipeline) return;
	if(pipeline->sourceCleanup) {
		pipeline->sourceCleanup(pipeline->source);
	}
	if(pipeline->stepFnArgsCleanup) {
		pipeline->stepFnArgsCleanup(pipeline->stepFnArgs);
	}
	free(pipeline);
}


static struct SHPipeline *_init(struct SHLinkedList *list, void *source, void *(*genFn)(void*, bool*),
	void (*sourceCleanup)(void*))
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
		SH_pipeline_cleanup(pipeline);
		return NULL;
}


static struct SHPipeline *_wrapPipeline2(struct SHPipeline *source,
	void *(*genFn)(struct SHPipelineIterator *, bool *),
	void *(*fn)(void*, void*, uint64_t), void *fnArgs, void (*fnArgsCleanup)(void *), size_t objSize)
{
	struct SHPipeline *pipeline = malloc(objSize);
	if(!pipeline) return NULL;
	struct SHLLNode *node = SH_llnode_pushBack(source->nodeLink, pipeline);
	if(!node) goto allocErr;
	*pipeline = (struct SHPipeline){
		.source = source,
		.nodeLink = node,
		.genFn = (void* (*)(void*, bool*))genFn,
		.sourceCleanup = NULL,
		.stepFn = fn,
		.stepFnArgs = fnArgs,
		.stepFnArgsCleanup = fnArgsCleanup,
	};
	return pipeline;
	allocErr:
		free(node);
		SH_pipeline_cleanup(pipeline);
		return NULL;
}


static struct SHPipeline *_wrapPipeline(struct SHPipeline *source,
	void *(*genFn)(struct SHPipelineIterator *, bool*),
	void *(*fn)(void*, void*, uint64_t), void *fnArgs, void (*fnArgsCleanup)(void *))
{
	return _wrapPipeline2(source, genFn, fn, fnArgs, fnArgsCleanup, sizeof(struct SHPipeline));
}


struct SHPipeline *SH_pipeline_init(void *source, void *(*genFn)(void*, bool*), void (*sourceCleanup)(void*),
	void (*unusedItemCleanup)(void*))
{
	if(!source || !genFn) return NULL;
	struct SHLinkedList *list = SH_list_init((void (*)(void*))_cleanup);
	struct SHPipeline *pipelineBase = NULL;
	struct SHPipeline *pipelineBootstrap = NULL;
	if(!list) return NULL;
	if(!(pipelineBase = _init(list, source, genFn, sourceCleanup))) goto cleanup;
	pipelineBase->unusedItemCleanup = unusedItemCleanup;
	if(!(pipelineBootstrap = _init(list, pipelineBase, (void *(*)(void*, bool*))_sourceApply, sourceCleanup)))
	{
		goto cleanup;
	}
	return pipelineBootstrap;
	cleanup:
		SH_list_cleanup(list);
		return NULL;
}


static void *_sourceApply(struct SHPipelineIterator *iter, bool *hasNext) {
	struct SHPipelineIterator *prevIter = SH_llnode_getItem(SH_llnode_getPrev(iter->nodeLink));
	iter->unusedItemCleanup = prevIter->unusedItemCleanup;
	void *item = NULL;
	if(iter->storage) {
		item = iter->storage;
	}
	else {
		item = prevIter->pipeline->genFn(prevIter->pipeline->source, hasNext);
	}
	//if we had previously exhausted list, set hasNext
	if(iter->state == SH_PIPELINE_DONE) {
		*hasNext = false;
	}
	//scan to exhaust list
	if(*hasNext) {
		
		iter->storage = prevIter->pipeline->genFn(prevIter->pipeline->source, hasNext);
		//if last item passes filter, we want to unset the hasNext flag
		// so that iteration does not end prematurely
		//we use iter->state to help with state in that situation.
		if(iter->storage && !*hasNext) {
			*hasNext = true;
			iter->state = SH_PIPELINE_DONE;
		}
	}
	return item;
}


static void *_transformApply(struct SHPipelineIterator *iter, bool *hasNext) {
	struct SHPipelineIterator *prevIter = SH_llnode_getItem(SH_llnode_getPrev(iter->nodeLink));
	iter->unusedItemCleanup = iter->pipeline->unusedItemCleanup;
	void *item = NULL;
	if(!(item = prevIter->pipeline->genFn(prevIter, hasNext))) goto fnErr;
	void *transformed = iter->pipeline->stepFn(item, iter->pipeline->source, iter->idx++);
	if(prevIter->unusedItemCleanup) {
		prevIter->unusedItemCleanup(item);
	}
	item = transformed;

	return item;
	fnErr:
		return NULL;
}


static void *_filterApply2(struct SHPipelineIterator *iter, bool *hasNext) {
	struct SHPipelineIterator *prevIter = SH_llnode_getItem(SH_llnode_getPrev(iter->nodeLink));
	iter->unusedItemCleanup = prevIter->unusedItemCleanup;
	bool skip = true;
	void *item = NULL;
	do {
		if(!(item = prevIter->pipeline->genFn(prevIter, hasNext))) goto fnErr;
		skip = !iter->pipeline->stepFn(item, iter->pipeline->source, iter->idx++);
		if(skip) {
			if(prevIter->unusedItemCleanup){
				prevIter->unusedItemCleanup(item);
			}
			item = NULL;
		}
		
	} while(skip && *hasNext);
	
	return item;
	fnErr:
		return NULL;
}

/*
	we want to exhaust the list even if there are no valid elements left.
	so we potential do a search twice.
*/
static void *_filterApply(struct SHPipelineIterator *iter, bool *hasNext) {
	void *item = NULL;
	if(iter->storage) {
		item = iter->storage;
	}
	else {
		item = _filterApply2(iter, hasNext);
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
	return item;
	
}


static void *_groupingApply(struct SHPipelineIterator *iter, bool *hasNext) {
	struct SHPipelineIterator *prevIter = NULL;
	struct _groupingPipeline *pipeline = NULL;
	struct SHMap *map = NULL;
	uint64_t idx = 0;
	SHErrorCode status = SH_NO_ERROR;
	void *item = NULL;
	struct SHIterableWrapper *iterable = NULL;
	iter->unusedItemCleanup = (void (*)(void*))SH_iterable_cleanup;
	switch(iter->state) {
		case SH_PIPELINE_NEXT: goto next;
		default: break;
	}
	prevIter = SH_llnode_getItem(SH_llnode_getPrev(iter->nodeLink));
	pipeline = (struct _groupingPipeline*)iter->pipeline;
	map = SH_map_init3(SH_defaultMappingFn, SH_defaultKeyCompareFn, (void (*)(void*))SH_iterable_cleanup,
		pipeline->keyCleanup);
	
	if(!map) return NULL;
	
	*hasNext = true;
	
	while(*hasNext) {
		if(!(item = prevIter->pipeline->genFn(prevIter, hasNext))) goto cleanup;
		void *key = pipeline->base.stepFn(item, pipeline->base.stepFnArgs, idx++);
		if(!(iterable = SH_map_getItemWithKey(map, key))) {
			iterable = SH_iterable_init(&pipeline->iterableSetup, pipeline->sortingFn, pipeline->base.unusedItemCleanup);
			if(!iterable) goto cleanup;
			if((status = SH_map_setKeyItem(map, key, iterable)) != SH_NO_ERROR) { goto cleanup; }
		}
		if((status = SH_iterable_addItem(iterable, item)) != SH_NO_ERROR) { goto cleanup; }
	}
	iter->storage = map;
	iter->state = SH_PIPELINE_NEXT;
	iter->storageCleanup = (void (*)(void*))SH_map_cleanup;
	if(SH_map_count(map)) {
		*hasNext = true;
	}
	next:
		map = iter->storage;
		struct SHMapKipIterator *mapIter = SH_mapKipIterator_init(map);
		struct SHKeyItemPair *kip = SH_mapKipIterator_next(&mapIter);
		if(!mapIter) {
			goto cleanup;
		}
		free(mapIter);
		item = kip->item;
		SH_map_removeItemWithKey(map, kip->key);
		if(SH_map_count(map) < 1) {
			*hasNext = false;
		}
		return item;
	cleanup:
		SH_notifyOfError(status, "error while adding item to collection");
		*hasNext = false;
		return NULL;
}


static void *_skipApply(struct SHPipelineIterator *iter, bool *hasNext) {
	struct SHPipelineIterator *prevIter = SH_llnode_getItem(SH_llnode_getPrev(iter->nodeLink));
	iter->unusedItemCleanup = prevIter->unusedItemCleanup;
	void *item = NULL;
	while(iter->idx < iter->pipeline->limit && *hasNext) {
		if(!(item = prevIter->pipeline->genFn(prevIter, hasNext))) goto fnErr;
		if(prevIter->unusedItemCleanup) {
			prevIter->unusedItemCleanup(item);
		}
		iter->idx++;
	}
	if(!(item = prevIter->pipeline->genFn(prevIter, hasNext))) goto fnErr;
	return item;
	fnErr:
		return NULL;
}


static void *_takeApply(struct SHPipelineIterator *iter, bool *hasNext) {
	struct SHPipelineIterator *prevIter = SH_llnode_getItem(SH_llnode_getPrev(iter->nodeLink));
	iter->unusedItemCleanup = prevIter->unusedItemCleanup;
	void *item = NULL;
	if(iter->idx >= iter->pipeline->limit || !*hasNext) return NULL;;
	if(!(item = prevIter->pipeline->genFn(prevIter, hasNext))) goto fnErr;
	iter->idx++;
	if(iter->idx >= iter->pipeline->limit) {
		*hasNext = false;
	}
	return item;
	fnErr:
		return NULL;
}


struct SHPipeline *SH_pipeline_useTransform(struct SHPipeline *source, void *(*fn)(void*, void*, uint64_t),
	void *fnArgs, void (*fnArgsCleanup)(void *), void (*unusedItemCleanup)(void *))
{
	if(!source || !fn) return NULL;
	struct SHPipeline *pipeline = _wrapPipeline(source,
		_transformApply, fn, fnArgs, fnArgsCleanup);
	if(!pipeline) return NULL;
	pipeline->unusedItemCleanup = unusedItemCleanup;
	return (struct SHPipeline*)pipeline;
}


struct SHPipeline *SH_pipeline_useFilter(struct SHPipeline *source, bool (*fn)(void*, void*, uint64_t),
	void *fnArgs, void (*fnArgsCleanup)(void *))
{
	if(!source || !fn) return NULL;
	struct SHPipeline *pipeline = _wrapPipeline(source, _filterApply, (void *(*)(void*, void*, uint64_t))fn,
		fnArgs, fnArgsCleanup);
	if(!pipeline) return NULL;
	return pipeline;
}


struct SHPipeline *SH_pipeline_useGrouping(struct SHPipeline *source, void *(*fn)(void*, void*, uint64_t),
	void *fnArgs, void (*fnArgsCleanup)(void *), struct SHIterableSetup const * const iterableSetup,
	int32_t (*sortingFn)(void*, void*), void (*keyCleanup)(void*))
{
	if(!source || !fn) return NULL;
	struct _groupingPipeline *pipeline = (struct _groupingPipeline *)_wrapPipeline2(source, _groupingApply, fn,
		fnArgs, fnArgsCleanup, sizeof(struct _groupingPipeline));
	if(!pipeline) return NULL;
	pipeline->iterableSetup = *iterableSetup;
	pipeline->sortingFn = sortingFn;
	pipeline->keyCleanup = keyCleanup;
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


static void _iteratorCleanup2(struct SHPipelineIterator *iter) {
	if(!iter) return;
	if(iter->storageCleanup) {
		iter->storageCleanup(iter->storage);
	}
	
}


static void _iteratorCleanup(struct SHPipelineIterator *iter) {
	if(!iter) return;
	struct SHLinkedList *list = SH_llnode_getList(iter->nodeLink);
	SH_list_cleanup(list);
}


struct SHPipelineIterator *SH_pipelineIterator_init(struct SHPipeline *pipeline) {
	if(!pipeline) return NULL;
	struct SHLinkedList *list = SH_list_init((void (*)(void*))_iteratorCleanup2);
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
			free(iterStep);
			goto cleanup;
		}
		*iterStep = (struct SHPipelineIterator){
			.pipeline = pipelineStep,
			.nodeLink = node,
			.state = SH_PIPELINE_START,
			.unusedItemCleanup = pipelineStep->unusedItemCleanup,
		};
	}
	return iterStep;
	cleanup:
		SH_list_cleanup(list);
		return NULL;
}


void *SH_pipelineIterator_next(struct SHPipelineIterator **iter) {
	if(!iter) return NULL;
	struct SHPipelineIterator *it = *iter;
	if(!it) return NULL;
	bool hasNext = true;
	void *item = it->pipeline->genFn(it, &hasNext);
	if(!hasNext) {
		_iteratorCleanup(*iter);
		*iter = NULL;
	}
	return item;

}


void SH_pipeline_cleanup(struct SHPipeline *pipeline) {
	if(!pipeline) return;
	struct SHLinkedList *list = SH_llnode_getList(pipeline->nodeLink);
	SH_list_cleanup(list);
}


struct SHIterableWrapper *SH_pipeline_completeAsIteratble(struct SHPipeline *pipeline,
	struct SHIterableSetup const * const iterableSetup, int32_t (*sortingFn)(void*, void*))
{
	if(!pipeline || !iterableSetup) return NULL;
	struct SHPipelineIterator *iter = SH_pipelineIterator_init(pipeline);
	if(!iter) return NULL;
	struct SHIterableWrapper *result = SH_iterable_init(iterableSetup, sortingFn, pipeline->unusedItemCleanup);
	if(!result) goto cleanup;
	while(iter) {
		void *item = SH_pipelineIterator_next(&iter);
		if(SH_iterable_addItem(result, item) != SH_NO_ERROR) {
			goto cleanup;
		}
	}
	return result;
	cleanup:
		_iteratorCleanup(iter);
		SH_iterable_cleanupIgnoreItems(result);
		return NULL;
}
