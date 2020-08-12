//
//  SHPassiveEventProcessor.h
//  SHModels
//
//  Created by Joel Pridgen on 8/5/20.
//  Copyright © 2020 Joel Gillette. All rights reserved.
//

#ifndef SHPassiveEventProcessor_h
#define SHPassiveEventProcessor_h

#include "SHDamageReport.h"
#include "SHStoryFigure.h"
#include "SHModelsQueueStore.h"
#include <SHUtils_C/SHErrorHandling.h>
#include <SHDatetime/SHDatetime.h>
#include <stdio.h>
#include <sqlite3.h>
#include <inttypes.h>

struct SHPenaltyCalcValues {
	double monsterAtkMod;
	double heroDefMod;
	int64_t hits;
	int32_t urgency;
	int32_t difficulty;
};

SHErrorCode SH_processPassiveEvents(struct SHModelsQueueStore *store, void *responder,
	SHErrorCode (*handleResults)(void*, struct SHDamageReport));


#endif /* SHPassiveEventProcessor_h */
