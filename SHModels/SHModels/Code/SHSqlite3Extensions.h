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
#include <inttypes.h>
#include <sqlite3.h>
#include "SHDatetime_struct.h"

#include <stdio.h>
int32_t SH_sqlite3_bind_optional_double(sqlite3_stmt*, int32_t, double *);
SHErrorCode SH_sqlite3_copy_column_text(sqlite3_stmt*, int32_t col, char **value);
SHErrorCode SH_sqlite3_column_double_ptr(sqlite3_stmt*, int32_t col, double **value);
SHErrorCode SH_sqlite3_value_double_ptr(sqlite3_value *cellValue, double **value);
SHErrorCode SH_sqlite3_value_SHDatetime(sqlite3_value *cellValue, struct SHDatetime *dt,
	int32_t timezoneOffset);
#endif /* SHSqlite3Extensions_h */
