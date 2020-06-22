//
//  SHTreeCollectionWrapperFuncs.h
//  SHUtils_C
//
//  Created by Joel Pridgen on 6/20/20.
//  Copyright © 2020 Joel Gillette. All rights reserved.
//

#ifndef SHTreeCollectionWrapperFuncs_h
#define SHTreeCollectionWrapperFuncs_h

#include "SHCollection.h"
#include <stdio.h>
#include <inttypes.h>

uint64_t SH_treeCollection_count(struct SHCollection *collection);
void SH_treeCollection_addItem(struct SHCollection *collection, void *item);
void *SH_treeCollection_getItemAtIdx(struct SHCollection *collection, uint64_t idx);
void SH_treeCollection_deleteItemAtIdx(struct SHCollection *collection, uint64_t idx);
struct SHCollectionIterator *SH_treeCollectionIterator_init(struct SHCollection *collection);
void *SH_treeCollectionIterator_next(struct SHCollectionIterator **iter);

#endif /* SHTreeCollectionWrapperFuncs_h */
