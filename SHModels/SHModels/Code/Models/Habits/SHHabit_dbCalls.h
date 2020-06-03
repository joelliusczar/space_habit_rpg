//
//  SHHabit_dbCalls.h
//  SHModels
//
//  Created by Joel Pridgen on 5/30/20.
//  Copyright © 2020 Joel Gillette. All rights reserved.
//

#ifndef SHHabit_dbCalls_h
#define SHHabit_dbCalls_h

#include <SHUtils_C/SHErrorHandling.h>
#include "SHHabitBase.h"
#include <stdio.h>
#include <sqlite3.h>

SHErrorCode SH_insertHabit(sqlite3 *db, struct SHHabitBase const * habit, const char* tableName, int64_t *insertedPk);

#endif /* SHHabit_dbCalls_h */
