//
//  SHDynamicArray.h
//  SHUtils_C
//
//  Created by Joel Pridgen on 6/3/20.
//  Copyright © 2020 Joel Gillette. All rights reserved.
//

#ifndef SHDynamicArray_h
#define SHDynamicArray_h

#include <stdio.h>
#include <inttypes.h>

struct SHDynamicArray;

struct SHDynamicArray *SH_dynamicArray_init(uint64_t startSize, void (*cleanup)(void*));
uint64_t SH_dynamicArray_length(struct SHDynamicArray *array);
void SH_dynamicArray_push(struct SHDynamicArray *array, void *item);
void* SH_dynamicArray_get(struct SHDynamicArray *array, uint64_t idx);
void SH_dynamicArray_remove(struct SHDynamicArray *array, uint64_t idx);
void SH_dynamicArray_insert(struct SHDynamicArray *array, uint64_t idx, void *item);
void SH_dynamicArray_free(struct SHDynamicArray *array);

#endif /* SHDynamicArray_h */
