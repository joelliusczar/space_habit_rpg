//
//  SHDaily_dbFuncs.h
//  SHModels
//
//  Created by Joel Pridgen on 5/28/20.
//  Copyright © 2020 Joel Gillette. All rights reserved.
//

#ifndef SHDaily_dbFuncs_h
#define SHDaily_dbFuncs_h

#include <stdio.h>
#include <sqlite3.h>
void SHDB_selectSavedUseDate(sqlite3_context* context,int argc,sqlite3_value** values);
void SHDB_nextDueDate(sqlite3_context* context, int argc, sqlite3_value** values);
void SHDB_isDateActive(sqlite3_context* context, int argc, sqlite3_value** values);
void SHDB_missedDays(sqlite3_context* context, int argc, sqlite3_value** values);
void SHDB_penalty(sqlite3_context* context,int argc, sqlite3_value** values);
void SHDB_getDueStatus(sqlite3_context* context, int argc, sqlite3_value** values);
#endif /* SHDaily_dbFuncs_h */
