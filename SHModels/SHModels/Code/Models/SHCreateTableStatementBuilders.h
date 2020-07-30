//
//  SHCreateTableStatementBuilders.h
//  SHModels
//
//  Created by Joel Pridgen on 7/25/20.
//  Copyright © 2020 Joel Gillette. All rights reserved.
//

#ifndef SHCreateTableStatementBuilders_h
#define SHCreateTableStatementBuilders_h

#include <SHUtils_C/SHErrorHandling.h>
#include <stdio.h>
#include <sqlite3.h>

SHErrorCode SH_buildCreateDailyTableStmt(sqlite3_stmt **stmt, sqlite3 *db);
SHErrorCode SH_buildCreateDailyActivationTableStmt(sqlite3_stmt **stmt, sqlite3 *db);

#endif /* SHCreateTableStatementBuilders_h */
