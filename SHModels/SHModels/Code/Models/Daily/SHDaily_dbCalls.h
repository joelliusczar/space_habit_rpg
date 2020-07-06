//
//  SHDaily_dbFuncs.h
//  SHData
//
//  Created by Joel Pridgen on 5/20/20.
//  Copyright © 2020 Joel Gillette. All rights reserved.
//

#ifndef SHDaily_dbCalls_h
#define SHDaily_dbCalls_h

#include "SHDaily_struct.h"
#include <SHUtils_C/SHErrorHandling.h>
#include <SHUtils_C/SHSerialAccessCollection.h>
#include <SHDatetime/SHDatetimeProvider.h>
#include <stdio.h>
#include <sqlite3.h>
#include <inttypes.h>


SHErrorCode SH_insertDaily( sqlite3 *db, struct SHDaily const * daily, int64_t *insertedPk);
SHErrorCode SH_updateDaily(sqlite3 *db, struct SHDaily const * const daily);
SHErrorCode SH_fetchSingleDaily(sqlite3 *db, int64_t pk, struct SHDaily *daily);
SHErrorCode SH_bindAllDailyParams(sqlite3_stmt *stmt, struct SHDaily const * const daily);
SHErrorCode SH_fetchTableDailies(sqlite3 *db, struct SHSerialAccessCollection *saCollection,
	struct SHDatetimeProvider *dateProvider);

#endif /* SHDaily_dbCalls_h */
