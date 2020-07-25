//
//  SHModelsQueueStore.h
//  SHModels
//
//  Created by Joel Pridgen on 5/29/20.
//  Copyright © 2020 Joel Gillette. All rights reserved.
//

#ifndef SHModelsQueueStore_h
#define SHModelsQueueStore_h

#include "SHConfigAccessor.h"
#include <stdio.h>
#include <sqlite3.h>
#include <SHUtils_C/SHIterableWrapper.h>
#include <SHDatetime/SHDatetimeProvider.h>

struct SHModelsQueueStore {
	sqlite3 *db;
	const struct SHConfigAccessor *config;
	struct SHIterableWrapper *dailyStorage;
	const struct SHDatetimeProvider *dateProvider;
	
};

struct SHIterableWrapper *SH_modelsQueueStore_selectTableData(struct SHModelsQueueStore *store, const char *tableName);

void SH_freeQueueStoreItem(struct SHModelsQueueStore *item);

#endif /* SHModelsQueueStore_h */
