//
//  SHSqlite3Extensions.c
//  SHModels
//
//  Created by Joel Pridgen on 5/20/20.
//  Copyright © 2020 Joel Gillette. All rights reserved.
//

#include "SHSqlite3Extensions.h"
#include <stdlib.h>

int32_t SH_sqlite3_bind_optional_double(sqlite3_stmt* stmt, int32_t paramNum, double *value) {
	int32_t sqlStatus = SQLITE_OK;
	if(NULL != value) {
		if((sqlStatus = sqlite3_bind_double(stmt, paramNum, *value)) != SQLITE_OK) { goto fnExit; }
	}
	else {
		if((sqlStatus = sqlite3_bind_null(stmt, paramNum)) != SQLITE_OK) { goto fnExit; }
	}
	fnExit:
		return sqlStatus;
}


SHErrorCode SH_sqlite3_copy_column_text(sqlite3_stmt *stmt, int32_t col, unsigned char **value) {
	const unsigned char *tmp = sqlite3_column_text(stmt, col);
	int32_t len = sqlite3_column_bytes(stmt, col);
	*value = malloc(sizeof(unsigned char) * len);
	**value = *tmp;
	if(NULL == *value && len > 0) {
		return SH_ALLOC;
	}
	return SH_NO_ERROR;
}


SHErrorCode SH_sqlite3_column_double_ptr(sqlite3_stmt *stmt, int32_t col, double **value) {
	if(sqlite3_column_type(stmt, col) == SQLITE_FLOAT) {
		*value = malloc(sizeof(double));
		if(NULL == *value) {
			return SH_ALLOC;
		}
		**value = sqlite3_column_double(stmt, col);
	}
	else {
		*value = NULL;
	}
	return SH_NO_ERROR;
}
