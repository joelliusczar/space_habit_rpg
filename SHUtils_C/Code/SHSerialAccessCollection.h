//
//  SHSerialAccessCollection.h
//  SHUtils_C
//
//  Created by Joel Pridgen on 6/20/20.
//  Copyright © 2020 Joel Gillette. All rights reserved.
//

#ifndef SHSerialAccessCollection_h
#define SHSerialAccessCollection_h

#include "SHIterableWrapper.h"
#include "SHErrorHandling.h"
#include <stdio.h>
#include <inttypes.h>

struct SHSerialAccessCollection;

struct SHGeneratorFnObj {
	void *(*generator)(void *);
	void *generatorState;
	void (*stateCleanup)(void **);
};


struct SHSerialAccessCollection *SH_SACollection_init(struct SHIterableWrapper *iterable);
SHErrorCode SH_SACollection_startLoop(struct SHSerialAccessCollection *saCollection);

SHErrorCode SH_SACollection_count(struct SHSerialAccessCollection *saCollection, uint64_t *count);
SHErrorCode SH_SACollection_getItemAtIdx(struct SHSerialAccessCollection *saCollection, uint64_t idx, void **item);
SHErrorCode SH_SACollection_addItem(struct SHSerialAccessCollection *saCollection, void *item);
SHErrorCode SH_SACollection_deleteItemAtIdx(struct SHSerialAccessCollection *saCollection, uint64_t idx);
SHErrorCode SH_SACollection_addItemsWithGenerator(struct SHSerialAccessCollection *saCollection,
	struct SHGeneratorFnObj *generatorFnObj);
SHErrorCode SH_SACollection_closeLoop(struct SHSerialAccessCollection *saCollection);
SHErrorCode SH_SACollection_waitToFinishOps(struct SHSerialAccessCollection *saCollection);
	
void SH_generatorObj_cleanup(struct SHGeneratorFnObj **genFnObjP2);
	
#endif /* SHSerialAccessCollection_h */
