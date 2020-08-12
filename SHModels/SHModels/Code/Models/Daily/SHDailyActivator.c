//
//  SHDailyActivator.c
//  SHModels
//
//  Created by Joel Pridgen on 7/25/20.
//  Copyright © 2020 Joel Gillette. All rights reserved.
//

#include "SHDailyActivator.h"
#include "SHActivation_dbCalls.h"
#include "SHModelsQueueStore.h"
#include "SHTableDailiesFuncs.h"
#include <SHUtils_C/SHIterableWrapper.h>
#include <stdlib.h>

struct _activateArgs {
	const struct SHTableChangeActions *tableChangeActions;
	struct SHTableDaily *tableDaily;
};


static SHErrorCode _activate(struct _activateArgs *activateArgs, struct SHQueueStore *store) {
	struct SHModelsQueueStore *item = (struct SHModelsQueueStore *)SH_serialQueue_getUserItem(store);
	SHErrorCode status = SH_NO_ERROR;
	activateArgs->tableChangeActions->beginUpdate(activateArgs->tableChangeActions->owner);
	uint32_t fromGroupIdx = SH_tableDailiesGrouper(activateArgs->tableDaily, NULL, 0);
	struct SHIterableWrapper *fromGroup = SH_iterable_getItemAtIdx(item->dailyStorage, fromGroupIdx);
	
	if((status = SH_daily_addActivationRecords(item, activateArgs->tableDaily) )
		!= SH_NO_ERROR)
	{
		goto fnExit;
	}
	
	uint32_t toGroupIdx = SH_tableDailiesGrouper(activateArgs->tableDaily, NULL, 0);
	if(toGroupIdx != fromGroupIdx) {
		struct SHIterableWrapper *toGroup = SH_iterable_getItemAtIdx(item->dailyStorage, toGroupIdx);
		if((status = SH_iterable_removeMatchingItem(fromGroup, activateArgs->tableDaily, true)) != SH_NO_ERROR) {
			goto fnExit;
		
		}
		if((status = SH_iterable_addItem(toGroup, activateArgs->tableDaily)) != SH_NO_ERROR) {
			goto fnExit;
		}
	}
	fnExit:
		activateArgs->tableChangeActions->endUpdate(activateArgs->tableChangeActions->owner);
		return status;
}

SHErrorCode SH_daily_activate(struct SHSerialQueue *dbQueue, struct SHTableDaily *tableDaily,
	const struct SHTableChangeActions *tableChangeActions)
{
	SHErrorCode status = SH_NO_ERROR;
	struct _activateArgs *args = malloc(sizeof(struct _activateArgs));
	if(!args) return SH_ALLOC_NO_MEM;
	*args = (struct _activateArgs){
		.tableChangeActions = tableChangeActions,
		.tableDaily = tableDaily,
	};
	if((status = SH_serialQueue_addOp(dbQueue, (SHErrorCode (*)(void*, struct SHQueueStore *))_activate,
		args, free)) != SH_NO_ERROR) {}
	return status;
}
