//
//  SHCommonDbCalls.h
//  SHModels
//
//  Created by Joel Pridgen on 5/31/20.
//  Copyright © 2020 Joel Gillette. All rights reserved.
//

#ifndef SHCommonDbCalls_h
#define SHCommonDbCalls_h

#include <stdio.h>
#include <sqlite3.h>
#include <SHUtils_C/SHErrorHandling.h>

SHErrorCode SH_deleteRecord(sqlite3 *db, const char* tableName, int64_t pk);

#endif /* SHCommonDbCalls_h */
