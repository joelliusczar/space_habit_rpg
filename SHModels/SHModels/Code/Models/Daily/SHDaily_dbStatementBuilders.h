//
//  SHDaily_dbStatementBuilders.h
//  SHModels
//
//  Created by Joel Pridgen on 5/21/20.
//  Copyright © 2020 Joel Gillette. All rights reserved.
//

#ifndef SHDaily_dbStatementBuilders_h
#define SHDaily_dbStatementBuilders_h

#include "SHErrorHandling.h"
#include <sqlite3.h>
#include <stdio.h>
SHErrorCode SH_buildStatement_fetchSingleDaily(sqlite3_stmt *stmt, sqlite3 *db);
SHErrorCode SH_buildStatement_updateDailyStmt(sqlite3_stmt *stmt, sqlite3 *db);
SHErrorCode SH_buildStatement_insertDailyStmt(sqlite3_stmt *stmt, sqlite3 *db);

#endif /* SHDaily_dbStatementBuilders_h */
