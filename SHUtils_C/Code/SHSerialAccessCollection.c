//
//  SHSerialAccessCollection.c
//  SHUtils_C
//
//  Created by Joel Pridgen on 6/20/20.
//  Copyright © 2020 Joel Gillette. All rights reserved.
//

#include "SHSerialAccessCollection.h"
#include "SHGenAlgos.h"
#include "SHSerialQueue.h"
#include <stdlib.h>


struct SHSerialAccessCollection {
	struct SHSerialQueue *queue;
};


struct SHSerialAccessCollection *SH_SACollection_init(struct SHIterableWrapper *iterable) {
	if(!iterable) return NULL;
	struct SHSerialAccessCollection *saCollection = malloc(sizeof(struct SHSerialAccessCollection));
	saCollection->queue = SH_serialQueue_init(iterable, (void (*)(void**))SH_iterable_cleanup);
	return saCollection;
}


SHErrorCode SH_SACollection_startLoop(struct SHSerialAccessCollection *saCollection) {
	if(!saCollection) return SH_ILLEGAL_INPUTS;
	return SH_serialQueue_startLoop(saCollection->queue);
}


struct _iterableFuncs {
	int32_t (*sortingFn)(void *, void *);
	void (*itemCleanup)(void**);
};


static SHErrorCode _createSubIterable(void *fnArgs, struct SHQueueStore *store) {
	struct _iterableFuncs *iterableFuncs = (struct _iterableFuncs*)fnArgs;
	struct SHIterableWrapper * iterable = (struct SHIterableWrapper *)SH_serialQueue_getUserItem(store);
	SH_iterable_createSubIterable(iterable, iterableFuncs->sortingFn, iterableFuncs->itemCleanup);
	
	return SH_NO_ERROR;
}


SHErrorCode SH_SACollection_createSubIterable(struct SHSerialAccessCollection *saCollection,
	int32_t (*sortingFn)(void *, void *),
	void (*itemCleanup)(void**))
{
	struct _iterableFuncs *iterableFuncs = malloc(sizeof(struct _iterableFuncs));
	if(!iterableFuncs) return SH_ALLOC;
	*iterableFuncs = (struct _iterableFuncs){ .sortingFn = sortingFn, .itemCleanup = itemCleanup };
	SHErrorCode status = SH_NO_ERROR;
	if((status = SH_serialQueue_addOp(saCollection->queue, _createSubIterable, iterableFuncs, SH_cleanup))
		!= SH_NO_ERROR) {}
	return status;
}


struct _groupingFnObj {
	uint64_t (*groupingFn)(void*);
};


static SHErrorCode _setGroupingFn(void *fnArgs, struct SHQueueStore *store) {
	struct _groupingFnObj *groupingFnObj = (struct _groupingFnObj *)fnArgs;
	struct SHIterableWrapper * iterable = (struct SHIterableWrapper *)SH_serialQueue_getUserItem(store);
	SH_iterable_setGroupingFn(iterable, groupingFnObj->groupingFn);
	return SH_NO_ERROR;
}


SHErrorCode SH_SACollection_setGroupingFn(struct SHSerialAccessCollection *saCollection, uint64_t (*groupingFn)(void*)) {
	if(!saCollection) return SH_ILLEGAL_INPUTS;
	struct _groupingFnObj *groupingFnObj = malloc(sizeof(struct _groupingFnObj));
	groupingFnObj->groupingFn = groupingFn;
	SHErrorCode status = SH_NO_ERROR;
	if((status = SH_serialQueue_addOp(saCollection->queue, _setGroupingFn, groupingFnObj, SH_cleanup))
		!= SH_NO_ERROR) {}
	
	return status;
}


static SHErrorCode _getCount(void *fnArgs, struct SHQueueStore *store, void **resultP2) {
	(void)fnArgs;
	if(!resultP2) return SH_ILLEGAL_INPUTS;
	struct SHIterableWrapper * iterable = (struct SHIterableWrapper *)SH_serialQueue_getUserItem(store);
	uint64_t count = SH_iterable_count(iterable);
	*resultP2 = malloc(sizeof(void *));
	uint64_t *result = (uint64_t *)*resultP2;
	*result = count;
	return SH_NO_ERROR;
}


SHErrorCode SH_SACollection_count(struct SHSerialAccessCollection *saCollection, uint64_t *count) {
	if(!saCollection) return SH_ILLEGAL_INPUTS;
	if(!SH_serialQueue_isLoopRunning(saCollection->queue)) return SH_PRECONDITIONS_NOT_FULFILLED;
	SHErrorCode status = SH_NO_ERROR;
	void *temp = NULL;
	if((status = SH_addOpAndWaitForResult(saCollection->queue, _getCount, NULL, NULL, &temp))
		!= SH_NO_ERROR) {}
	*count = *((uint64_t*)temp);
	free(temp);
	temp = NULL;
	return status;
}


static SHErrorCode _getItemAtIdx(void *fnArgs, struct SHQueueStore *store, void **resultP2) {
	if(!resultP2 || !fnArgs) return SH_ILLEGAL_INPUTS;
	struct SHIterableWrapper * iterable = (struct SHIterableWrapper *)SH_serialQueue_getUserItem(store);
	uint64_t idx = *((uint64_t*)fnArgs);
	*resultP2 = SH_iterable_getItemAtIdx(iterable, idx);
	return SH_NO_ERROR;
}


SHErrorCode SH_SACollection_getItemAtIdx(struct SHSerialAccessCollection *saCollection, uint64_t idx, void **itemP2) {
	if(!saCollection) return SH_ILLEGAL_INPUTS;
	if(!SH_serialQueue_isLoopRunning(saCollection->queue)) return SH_PRECONDITIONS_NOT_FULFILLED;
	SHErrorCode status = SH_NO_ERROR;
	if((status = SH_addOpAndWaitForResult(saCollection->queue, _getItemAtIdx, &idx, NULL, itemP2)) != SH_NO_ERROR) {
		SH_notifyOfError(status, "Something happened while waiting for a result");
	}
	return status;
}


static SHErrorCode _addItem(void *fnArgs, struct SHQueueStore *store) {
	if(!fnArgs) return SH_ILLEGAL_INPUTS;
	struct SHIterableWrapper * iterable = (struct SHIterableWrapper *)SH_serialQueue_getUserItem(store);
	SH_iterable_addItem(iterable, fnArgs);
	
	return SH_NO_ERROR;
}


SHErrorCode SH_SACollection_addItem(struct SHSerialAccessCollection *saCollection, void *item) {
	SHErrorCode status = SH_NO_ERROR;
	if((status = SH_serialQueue_addOp(saCollection->queue, _addItem, item, NULL)) != SH_NO_ERROR) {}
	
	return SH_NO_ERROR;
}


static SHErrorCode _deleteItemAtIdx(void *fnArgs, struct SHQueueStore *store) {
	if(!fnArgs) return SH_ILLEGAL_INPUTS;
	struct SHIterableWrapper * iterable = (struct SHIterableWrapper *)SH_serialQueue_getUserItem(store);
	uint64_t idx = *((uint64_t*)fnArgs);
	SH_iterable_deleteItemAtIdx(iterable, idx);
	
	return SH_NO_ERROR;
}


SHErrorCode SH_SACollection_deleteItemAtIdx(struct SHSerialAccessCollection *saCollection, uint64_t idx) {
	SHErrorCode status = SH_NO_ERROR;
	uint64_t *idxAlloc = malloc(sizeof(uint64_t));
	*idxAlloc = idx;
	if((status = SH_serialQueue_addOp(saCollection->queue, _deleteItemAtIdx, idxAlloc, SH_cleanup)) != SH_NO_ERROR) {}
	
	return SH_NO_ERROR;
}


void SH_generatorObj_cleanup(struct SHGeneratorFnObj **genFnObjP2) {
	if(!genFnObjP2) return;
	struct SHGeneratorFnObj *genFnObj = *genFnObjP2;
	if(genFnObj->stateCleanup) {
		genFnObj->stateCleanup(&genFnObj->generatorState);
	}
	free(genFnObj);
	genFnObjP2 = NULL;
}


static SHErrorCode _addItemsWithGenerator(void *fnArgs, struct SHQueueStore *store) {
	struct SHGeneratorFnObj *genFnObj = (struct SHGeneratorFnObj *)fnArgs;
	if(!genFnObj || !genFnObj->generator) return SH_ILLEGAL_INPUTS;
	struct SHIterableWrapper * iterable = (struct SHIterableWrapper *)SH_serialQueue_getUserItem(store);
	void *next = NULL;
	while((next = genFnObj->generator(genFnObj->generatorState))) {
		SH_iterable_addItem(iterable, next);
	}
	return SH_NO_ERROR;
}


SHErrorCode SH_SACollection_addItemsWithGenerator(struct SHSerialAccessCollection *saCollection,
	struct SHGeneratorFnObj *generatorFnObj)
{
	SHErrorCode status = SH_NO_ERROR;
	if((status = SH_serialQueue_addOp(saCollection->queue, _addItemsWithGenerator, generatorFnObj,
		(void (*)(void**))SH_generatorObj_cleanup)) != SH_NO_ERROR)
	{
		SH_notifyOfError(status, "An error occured while adding op to generate numbers");
		return status;
	}
	
	return SH_NO_ERROR;
}


SHErrorCode SH_SACollection_closeLoop(struct SHSerialAccessCollection *saCollection) {
	if(!saCollection) return SH_ILLEGAL_INPUTS;
	return SH_serialQueue_closeLoop(saCollection->queue);
}


SHErrorCode SH_SACollection_waitToFinishOps(struct SHSerialAccessCollection *saCollection) {
	if(!saCollection) return SH_ILLEGAL_INPUTS;
	return SH_serialQueue_waitToFinishOps(saCollection->queue);
}

