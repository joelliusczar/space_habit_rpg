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

#include <stdio.h>
int32_t SH_sqlite3_bind_optional_double(sqlite3_stmt*, int32_t, double *);
SHErrorCode SH_sqlite3_copy_column_text(sqlite3_stmt*, int32_t col, unsigned char **value);
SHErrorCode SH_sqlite3_column_double_ptr(sqlite3_stmt*, int32_t col, double **value);
#endif /* SHSqlite3Extensions_h */
