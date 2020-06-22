//
//  SHSerialAccessCollection.c
//  SHUtils_C
//
//  Created by Joel Pridgen on 6/20/20.
//  Copyright © 2020 Joel Gillette. All rights reserved.
//

#include "SHSerialAccessCollection.h"
#include "SHSerialQueue.h"
#include <stdlib.h>


struct SHSerialAccessCollection {
	struct SHSerialQueue *queue;
};


struct SHSerialAccessCollection *SH_SACollection_init(struct SHCollection *collection) {
	struct SHSerialAccessCollection *saCollection = malloc(sizeof(struct SHSerialAccessCollection));
	saCollection->queue = SH_serialQueue_init(collection, SH_collection_cleanup2);
	return saCollection;
}
//uint64_t SH_SACollection_count(struct SHSerialAccessCollection *collection);
//void *SH_SACollection_getItemAtIdx(struct SHSerialAccessCollection *collection, uint64_t idx);
//void SH_SACollection_addItem(struct SHSerialAccessCollection *collection, void *item);
//void SH_SACollection_deleteItemAtIdx(struct SHSerialAccessCollection *collection, uint64_t idx);
//void *SH_SACollection_getItemAtIdx(struct SHSerialAccessCollection *collection, uint64_t idx);
//void SH_SACollection_addItemsWithGenerator(struct SHSerialAccessCollection *collection,
//	void *(*generator)(void*));
