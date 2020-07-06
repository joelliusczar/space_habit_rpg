//
//  SHDbSetup.h
//  SHModels
//
//  Created by Joel Pridgen on 5/21/20.
//  Copyright © 2020 Joel Gillette. All rights reserved.
//

#ifndef SHDbSetup_h
#define SHDbSetup_h

#include "SHConfigAccessor.h"
#include <SHUtils_C/SHErrorHandling.h>
#include <stdio.h>
#include <sqlite3.h>

SHErrorCode SH_openDb(sqlite3 **db, const char * dbFilePath);
SHErrorCode SH_createTables(sqlite3 *db);
SHErrorCode SH_setupDb(sqlite3 *db);
SHErrorCode SH_addDbFunctions(sqlite3 *db, struct SHConfigAccessor *config);

#endif /* SHDbSetup_h */
