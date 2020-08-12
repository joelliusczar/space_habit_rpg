//
//  SHModelsQueueStore.c
//  SHModels
//
//  Created by Joel Pridgen on 5/29/20.
//  Copyright © 2020 Joel Gillette. All rights reserved.
//

#include "SHModelsQueueStore.h"
#include "SHTableNames.h"
#include <stdlib.h>
#include <string.h>


struct SHIterableWrapper *SH_modelsQueueStore_selectTableData(struct SHModelsQueueStore *store, const char *tableName) {
	if(!strncmp(SH_TABLE_NAME_DAILIES, tableName, sizeof(SH_TABLE_NAME_DAILIES))) {
		return store->dailyStorage;
	}
	return NULL;
}

void SH_freeQueueStoreItem(struct SHModelsQueueStore *item) {
	if(!item) return;
	sqlite3_finalize(item->fetchDailyAttackValues);
	sqlite3_finalize(item->fetchDailyForEdit);
	sqlite3_finalize(item->addDailyActivation);
	sqlite3_finalize(item->addDailyPartialActivation);
	sqlite3_finalize(item->getAttackChargeSumForToday);
	sqlite3_finalize(item->removeDailyActivation);
	sqlite3_close(item->db);
	SH_iterable_cleanup(item->dailyStorage);
	free(item->heroData);
	free(item->monsterData);
	free(item);
}
