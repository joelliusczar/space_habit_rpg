//
//  SHKeyValMap.h
//  SHUtils_C
//
//  Created by Joel Pridgen on 7/11/20.
//  Copyright © 2020 Joel Gillette. All rights reserved.
//

#ifndef SHMap_h
#define SHMap_h

#include "SHErrorHandling.h"
#include <stdio.h>
#include <inttypes.h>

struct SHMap;

struct SHKeyItemPair {
	void *key;
	void *item;
};


struct SHMapKipIterator;

struct SHMap *SH_map_init(void);
struct SHMap *SH_map_init2(void (*itemCleanup)(void**), void (*keyCleanup)(void**));
struct SHMap *SH_map_init3(uint64_t (*mappingFn)(void*), int32_t (*keyCompareFn)(void*, void*),
	void (*itemCleanup)(void**), void (*keyCleanup)(void**));
struct SHMap *SH_map_init4(uint64_t (*mappingFn)(void*), int32_t (*keyCompareFn)(void*, void*),
	void (*itemCleanup)(void**), void (*keyCleanup)(void**), double loadFactor, uint64_t initialCapacity);

SHErrorCode SH_map_setKeyItem(struct SHMap *map, void *key, void *item);
void *SH_map_getItemWithKey(struct SHMap *map, void *key);

/*
	frees the kip node, leaves item alone
*/
SHErrorCode SH_map_removeItemWithKey(struct SHMap *map, void *key);

void SH_map_cleanup(struct SHMap **mapP2);

uint64_t SH_defaultMappingFn(void *key);
int32_t SH_defaultKeyCompareFn(void *key1, void *key2);

struct SHMapKipIterator *SH_mapKipIterator_init(struct SHMap *map);
struct SHKeyItemPair *SH_mapKipIterator_next(struct SHMapKipIterator **iter);
struct SHMap *SH_mapKipIterator_getMap(struct SHMapKipIterator *iter);

void SH_mapKipIterator_cleanup(struct SHMapKipIterator **iter);

#endif /* SHMap_h */
