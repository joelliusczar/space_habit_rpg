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
#include "SHErrorHandling.h"
#include <stdio.h>
#include <inttypes.h>

struct SHSerialAccessCollection;

struct SHGeneratorFnObj {
	void *(*generator)(void *);
	void *generatorState;
	void (*stateCleanup)(void *);
};


struct SHSerialAccessCollection *SH_SACollection_init(struct SHCollection *collection);
SHErrorCode SH_SACollection__startLoop(struct SHSerialAccessCollection *saCollection);

SHErrorCode SH_SACollection_count(struct SHSerialAccessCollection *saCollection, uint64_t *count);
SHErrorCode SH_SACollection_getItemAtIdx(struct SHSerialAccessCollection *saCollection, uint64_t idx, void **item);
SHErrorCode SH_SACollection_addItem(struct SHSerialAccessCollection *saCollection, void *item);
SHErrorCode SH_SACollection_deleteItemAtIdx(struct SHSerialAccessCollection *saCollection, uint64_t idx);
SHErrorCode SH_SACollection_addItemsWithGenerator(struct SHSerialAccessCollection *saCollection,
	struct SHGeneratorFnObj *generatorFnObj);
	
void SH_generatorObj_cleanup(struct SHGeneratorFnObj **genFnObjP2);
void SH_generatorObj_cleanup2(void **args);
	
#endif /* SHSerialAccessCollection_h */
