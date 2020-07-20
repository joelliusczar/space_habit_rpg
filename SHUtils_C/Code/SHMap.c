//
//  SHKeyValMap.c
//  SHUtils_C
//
//  Created by Joel Pridgen on 7/11/20.
//  Copyright © 2020 Joel Gillette. All rights reserved.
//

#include "SHMap.h"
#include "SHLinkedList.h"
#include "SHGenAlgos.h"
#include "SHUtilConstants.h"
#include <stdlib.h>
#include <stdbool.h>


struct SHMap {
	struct SHLinkedList **backend;
	uint64_t count;
	uint64_t capacity;
	void (*itemCleanup)(void*);
	void (*keyCleanup)(void*);
	uint64_t (*mappingFn)(void*);
	int32_t (*keyCompareFn)(void*, void*);
	double loadFactor;
};

struct SHMapKipIterator {
	struct SHMap *backend;
	struct SHKeyItemPair *current;
	struct SHLLNode *bookmarkNode;
	uint64_t idx;
};

struct SHMap *SH_map_init() {
	return SH_map_init2(SH_cleanup, SH_cleanup);
}


struct SHMap *SH_map_init2(void (*itemCleanup)(void*), void (*keyCleanup)(void*)) {
	return SH_map_init3(SH_defaultMappingFn, SH_defaultKeyCompareFn, itemCleanup, keyCleanup);
}


struct SHMap *SH_map_init3(uint64_t (*mappingFn)(void*), int32_t (*keyCompareFn)(void*, void*),
	void (*itemCleanup)(void*), void (*keyCleanup)(void*))
{
	return SH_map_init4(mappingFn, keyCompareFn, itemCleanup, keyCleanup, .75, 16);
}


struct SHMap *SH_map_init4(uint64_t (*mappingFn)(void*), int32_t (*keyCompareFn)(void*, void*),
	void (*itemCleanup)(void*), void (*keyCleanup)(void*), double loadFactor, uint64_t initialCapacity)
{
	if(!mappingFn || !keyCompareFn || initialCapacity < 1 || loadFactor < 0 || loadFactor > 1) return NULL;
	struct SHLinkedList **backend = calloc(initialCapacity, sizeof(struct SHLinkedList *));
	if(!backend) return NULL;
	struct SHMap *map = malloc(sizeof(struct SHMap));
	if(!map) return NULL;
	map->backend = backend;
	map->count = 0;
	map->capacity = initialCapacity;
	map->itemCleanup = itemCleanup;
	map->keyCleanup = keyCleanup;
	map->mappingFn = mappingFn;
	map->keyCompareFn = keyCompareFn;
	map->loadFactor = loadFactor;
	return map;
}


SHErrorCode _replace(struct SHMap *map, uint64_t idx, void *key, void *item) {
	struct SHLinkedListIterator *iter = NULL;
	SHErrorCode status = SH_NO_ERROR;
	struct SHLinkedList *list = NULL;
	struct SHKeyItemPair *kip = NULL;
	if((list = map->backend[idx])) {
		iter = SH_listIterator_init(list);
		if(!iter) goto allocErr;
		while((kip = SH_listIterator_next(&iter))) {
			if(!map->keyCompareFn(kip->key, key)) {
				if(map->itemCleanup) {
					map->itemCleanup(kip->item);
					kip->item = NULL;
				}
				kip->item = item;
				status |= SH_CONTINUE_NON_ERR;
				goto fnExit;
			}
		}
	}
	goto fnExit;
	allocErr:
		return SH_ALLOC_NO_MEM;
	fnExit:
		return status;
}


static SHErrorCode _setKip(struct SHLinkedList **backend, uint64_t idx, struct SHKeyItemPair *kip) {
	SHErrorCode status = SH_NO_ERROR;
	struct SHLinkedList *list = NULL;
	if(!(list = backend[idx])) {
		if(!(list = SH_list_init(free))) goto allocErr;
		backend[idx] = list;
	}
	if((status = SH_list_pushBack(list, kip)) != SH_NO_ERROR) { }
	goto fnExit;
	allocErr:
		status |= SH_ALLOC_NO_MEM;
	fnExit:
		return status;
}


static SHErrorCode _expandMap(struct SHMap *map) {
	SHErrorCode status = SH_NO_ERROR;
	uint64_t newSize = map->capacity * 2;
	struct SHLinkedList **backend = calloc(newSize, sizeof(struct SHLinkedList *));
	if(!backend) goto allocErr;
	for(uint64_t idx = 0; idx < map->capacity; idx++) {
		struct SHLinkedList *list = map->backend[idx];
		struct SHKeyItemPair *kip = NULL;
		while((kip = SH_list_popFront(list))) {
			uint64_t newIdx = map->mappingFn(kip->key) % newSize;
			if((status = _setKip(backend, newIdx, kip)) != SH_NO_ERROR) { goto fnExit;}
		}
		SH_list_cleanup(list);
		map->backend[idx] = NULL;
	}
	free(map->backend);
	map->backend = backend;
	map->capacity = newSize;
	allocErr:
		return SH_ALLOC_NO_MEM;
	fnExit:
		return status;
}


SHErrorCode SH_map_setKeyItem(struct SHMap *map, void *key, void *item) {
	if(!map) return SH_ILLEGAL_INPUTS;
	struct SHKeyItemPair *kip = NULL;
	uint64_t idx = map->mappingFn(key) % map->capacity;
	SHErrorCode status = SH_NO_ERROR;

	if((status = _replace(map, idx, key, item)) != SH_NO_ERROR) {
		if(status & SH_CONTINUE_NON_ERR) status ^= SH_CONTINUE_NON_ERR;
		goto fnExit;
	}
	map->count++;
	double currentLoadFactor = ((double)map->count) / ((double)map->capacity);
	if(currentLoadFactor > map->loadFactor) {
		if((status = _expandMap(map)) != SH_NO_ERROR) { goto fnExit; }
	}
	if(!(kip = malloc(sizeof(struct SHKeyItemPair)))) { goto allocErr; }
	kip->key = key;
	kip->item = item;
	if((status = _setKip(map->backend, idx, kip)) != SH_NO_ERROR) { goto cleanupkip; }
	
	goto fnExit;
	allocErr:
		return SH_ALLOC_NO_MEM;
	cleanupkip:
		free(kip);
	fnExit:
		return status;
	
}


void *SH_map_getItemWithKey(struct SHMap *map, void *key) {
	if(!map) return NULL;
	uint64_t idx = map->mappingFn(key) % map->capacity;
	struct SHLinkedList *list = NULL;
	struct SHKeyItemPair *kip = NULL;
	struct SHLinkedListIterator *iter = NULL;
	void *result = NULL;
	if((list = map->backend[idx])) {
		iter = SH_listIterator_init(list);
		if(!iter) goto allocErr;
		while((kip = SH_listIterator_next(&iter))) {
			if(!map->keyCompareFn(kip->key, key)) {
				result = kip->item;
				goto fnExit;
			}
		}
	}
	return NULL;
	allocErr:
		return NULL;
	fnExit:
		free(iter);
		return result;
}


SHErrorCode SH_map_removeItemWithKey(struct SHMap *map, void *key) {
	if(!map) return SH_ILLEGAL_INPUTS;
	SHErrorCode status = SH_NO_ERROR;
	struct SHKeyItemPair *kip = NULL;
	struct SHLinkedListIterator *iter = NULL;
	uint64_t idx = map->mappingFn(key) % map->capacity;
	struct SHLinkedList *list = NULL;
	if((list = map->backend[idx])) {
		iter = SH_listIterator_init(list);
		if(!iter) goto allocErr;
		while((kip = SH_listIterator_next(&iter))) {
			if(!map->keyCompareFn(kip->key, key)) {
				if((status = SH_list_removeMatchingItem(list, kip, false)) != SH_NO_ERROR) { goto fnExit; }
				map->count--;
				break;
			}
		}
		if(SH_list_count(list) < 1) {
			SH_list_cleanup(list);
			map->backend[idx] = NULL;
			list = NULL;
		}
	}
	goto fnExit;
	allocErr:
		return SH_ALLOC_NO_MEM;
	fnExit:
		SH_cleanup((void**)iter);
		return status;
}


uint64_t SH_map_count(struct SHMap *map) {
	if(!map) return SH_NOT_FOUND;
	
	return map->count;
}


uint64_t SH_defaultMappingFn(void *key) {
	return (uint64_t)key;
}


int32_t SH_defaultKeyCompareFn(void *key1, void *key2) {
	int64_t key1Int = (int64_t)key1;
	int64_t key2Int = (int64_t)key2;
	
	int64_t ptrDiff = key1Int - key2Int;
	if(ptrDiff == 0) return 0;
	return ptrDiff > 0? 1 : -1;
	
}


void SH_map_cleanup(struct SHMap *map) {
	if(!map) return;
	for(uint64_t idx = 0; idx < map->capacity; idx++) {
		struct SHLinkedList *list = map->backend[idx];
		struct SHKeyItemPair *kip = NULL;
		while((kip = SH_list_popFront(list))) {
			if(map->keyCleanup) {
				map->keyCleanup(kip->key);
				kip->key = NULL;
			}
			if(map->itemCleanup) {
				map->itemCleanup(kip->item);
				kip->item = NULL;
			}
			
		}
		SH_list_cleanup(list);
		map->backend[idx] = NULL;
	}
	free(map->backend);
	free(map);
}


struct SHMapKipIterator *SH_mapKipIterator_init(struct SHMap *map) {
	if(!map) return NULL;
	struct SHMapKipIterator *iter = malloc(sizeof(struct SHMapKipIterator));
	if(!iter) goto allocErr;
	
	iter->idx = 0;
	struct SHLinkedList *list = NULL;
	while(!(list = map->backend[iter->idx]) && iter->idx < map->capacity) {
		iter->idx++;
	}
	iter->bookmarkNode = SH_list_getFront2(list);
	iter->current = SH_llnode_getItem(iter->bookmarkNode);
	iter->backend = map;
	return iter;
	allocErr:
		return NULL;
}


struct SHKeyItemPair *SH_mapKipIterator_next(struct SHMapKipIterator **iter) {
	if(!iter) return NULL;
	struct SHMapKipIterator *it = *iter;
	if(!it) return NULL;
	it->bookmarkNode = SH_llnode_getNext(it->bookmarkNode);
	if(!it->bookmarkNode) {
		struct SHLinkedList *list = NULL;
		while(!(list = it->backend->backend[it->idx]) && it->idx < it->backend->capacity) {
			it->idx++;
		}
		it->bookmarkNode = SH_list_getFront2(list);
	}
	it->current = SH_llnode_getItem(it->bookmarkNode);
	if(!it->current) {
		free(it);
		*iter = NULL;
		return NULL;
	}
	return it->current;
	
}


struct SHMap *SH_mapKipIterator_getMap(struct SHMapKipIterator *iter) {
	if(!iter) return NULL;
	return iter->backend;
}


void SH_mapKipIterator_cleanup(struct SHMapKipIterator *iter) {
	if(!iter) return;
	struct SHMap *map = SH_mapKipIterator_getMap(iter);
	SH_map_cleanup(map);
	SH_cleanup((void*)iter);
	
}
