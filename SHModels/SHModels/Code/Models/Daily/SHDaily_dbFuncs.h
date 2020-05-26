//
//  SHDaily_dbFuncs.h
//  SHData
//
//  Created by Joel Pridgen on 5/20/20.
//  Copyright © 2020 Joel Gillette. All rights reserved.
//

#ifndef SHDaily_dbFuncs_h
#define SHDaily_dbFuncs_h

#include "SHErrorHandling.h"
#include "SHDaily_struct.h"
#include <stdio.h>
#include <sqlite3.h>
#include <inttypes.h>

SHErrorCode SH_insertDaily(struct SHDaily const * daily, sqlite3 *db, int64_t *insertedPk);
SHErrorCode SH_updateDaily(struct SHDaily const * const daily, sqlite3 *db);
SHErrorCode SH_fetchDailies(struct SHDaily *dailies, int32_t len, sqlite3 *db);
SHErrorCode SH_fetchSingleDaily(sqlite3 *db, int32_t pk, struct SHDaily *daily);
SHErrorCode SH_bindAllDailyParams(sqlite3_stmt *stmt, struct SHDaily const * const daily);
void SH_freeDaily(struct SHDaily *daily);
void SH_freeDailyProps(struct SHDaily *daily);

#endif /* SHDaily_dbFuncs_h */
