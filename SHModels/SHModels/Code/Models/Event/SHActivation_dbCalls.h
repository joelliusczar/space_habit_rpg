//
//  SHActivation_dbCalls.h
//  SHModels
//
//  Created by Joel Pridgen on 7/25/20.
//  Copyright © 2020 Joel Gillette. All rights reserved.
//

#ifndef SHActivation_dbCalls_h
#define SHActivation_dbCalls_h

#include "SHDaily_struct.h"
#include "SHStoryFigure.h"
#include "SHModelsQueueStore.h"
#include <SHUtils_C/SHFileOps.h>
#include <SHUtils_C/SHErrorHandling.h>
#include <SHDatetime/SHDatetime.h>
#include <stdio.h>
#include <sqlite3.h>


SHErrorCode SH_daily_addActivationRecords(struct SHModelsQueueStore *store, struct SHTableDaily *tableDaily);
SHErrorCode SH_daily_removeActivationRecords(struct SHModelsQueueStore *store, struct SHTableDaily *tableDaily);

#endif /* SHActivation_dbCalls_h */
