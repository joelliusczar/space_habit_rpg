//
//  SHSerialAccessCollection.h
//  SHUtils_C
//
//  Created by Joel Pridgen on 6/20/20.
//  Copyright © 2020 Joel Gillette. All rights reserved.
//

#ifndef SHSerialAccessCollection_h
#define SHSerialAccessCollection_h

#include "SHCollection.h"
#include <stdio.h>
#include <inttypes.h>

struct SHSerialAccessCollection;


struct SHSerialAccessCollection *SH_SACollection_init(struct SHCollection *collection);
void SH_SACollection_count(struct SHSerialAccessCollection *collection);
void *SH_SACollection_getItemAtIdx(struct SHSerialAccessCollection *collection, uint64_t idx);
void SH_SACollection_addItem(struct SHSerialAccessCollection *collection, void *item);
void SH_SACollection_deleteItemAtIdx(struct SHSerialAccessCollection *collection, uint64_t idx);
void SH_SACollection_addItemsWithGenerator(struct SHSerialAccessCollection *collection,
	void *(*generator)(void*));
#endif /* SHSerialAccessCollection_h */
