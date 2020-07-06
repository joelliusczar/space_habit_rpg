//
//  SHSqlite3Extensions.h
//  SHModels
//
//  Created by Joel Pridgen on 5/20/20.
//  Copyright © 2020 Joel Gillette. All rights reserved.
//

#ifndef SHSqlite3Extensions_h
#define SHSqlite3Extensions_h
#include "SHErrorHandling.h"
#include "SHDatetime_struct.h"
#include <inttypes.h>
#include <sqlite3.h>
#include <stdio.h>

int32_t SH_sqlite3_bind_optional_double(sqlite3_stmt *stmt, int32_t, double *);
SHErrorCode SH_sqlite3_copy_column_text(sqlite3_stmt *stmt, int32_t col, char **value);
SHErrorCode SH_sqlite3_copy_column_blobFixed(sqlite3_stmt *stmt, int32_t col, void *value, uint64_t len);
SHErrorCode SH_sqlite3_column_double_ptr(sqlite3_stmt *stmt, int32_t col, double **value);
SHErrorCode SH_sqlite3_column_SHDatetime(sqlite3_stmt *stmt, int32_t col, struct SHDatetime *dt,
	int32_t timezoneOffset);
SHErrorCode SH_sqlite3_value_double_ptr(sqlite3_value *cellValue, double **value);
SHErrorCode SH_sqlite3_value_SHDatetime(sqlite3_value *cellValue, struct SHDatetime *dt,
	int32_t timezoneOffset);
SHErrorCode SH_sqlite3_copy_value_blobFixed(sqlite3_value *cellValue, void *value, uint64_t len);

void SH_cleanupSqlite3Statement(sqlite3_stmt **stmtP2);
#endif /* SHSqlite3Extensions_h */
