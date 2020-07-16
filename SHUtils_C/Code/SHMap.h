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


struct SHMap *SH_map_init();
struct SHMap *SH_map_init2(void (*itemCleanup)(void**), void (*keyCleanup)(void**));
struct SHMap *SH_map_init3(uint64_t (*mappingFn)(void*), int32_t (*keyCompareFn)(void*, void*),
	void (*itemCleanup)(void**), void (*keyCleanup)(void**));
struct SHMap *SH_map_init4(uint64_t (*mappingFn)(void*), int32_t (*keyCompareFn)(void*, void*),
	void (*itemCleanup)(void**), void (*keyCleanup)(void**), double loadFactor, uint64_t initialCapacity);

SHErrorCode SH_map_setKeyItem(struct SHMap *map, void *key, void *item);
void *SH_map_getItemWithKey(struct SHMap *map, void *key);
SHErrorCode SH_map_removeItemWithKey(struct SHMap *map, void *key);

void SH_map_cleanup(struct SHMap **mapP2);

uint64_t SH_defaultMappingFn(void *key);
int32_t SH_defaultKeyCompareFn(void *key1, void *key2);

#endif /* SHMap_h */
