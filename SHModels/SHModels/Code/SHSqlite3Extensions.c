//
//  SHSqlite3Extensions.c
//  SHModels
//
//  Created by Joel Pridgen on 5/20/20.
//  Copyright © 2020 Joel Gillette. All rights reserved.
//

#include "SHSqlite3Extensions.h"
#include "SHDatetimeFuncs.h"
#include <SHUtils_C/SHGenAlgos.h>
#include <SHUtils_C/SHUtilConstants.h>
#include <stdlib.h>
#include <string.h>
#include <math.h>


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


SHErrorCode SH_sqlite3_copy_column_text(sqlite3_stmt *stmt, int32_t col, char **value) {
	const char *tmp = (char *)sqlite3_column_text(stmt, col);
	int32_t len = sqlite3_column_bytes(stmt, col);
	if(NULL == tmp) {
		*value = SH_constStrCopy("");
		return SH_NO_ERROR;
	}
	*value = malloc(sizeof(char) * (len + SH_NULL_CHAR_OFFSET));
	strcpy(*value, tmp);
	if(NULL == *value && len > 0) {
		return SH_ALLOC;
	}
	return SH_NO_ERROR;
}


SHErrorCode SH_sqlite3_copy_column_blobFixed(sqlite3_stmt *stmt, int32_t col, void *value, uint64_t len) {
	if(!value || len < 1) return SH_ILLEGAL_INPUTS;
	const void *tmp = sqlite3_column_blob(stmt, col);
	uint64_t useLen = fmin(len, sqlite3_column_bytes(stmt, col));
	if(!tmp) {
		return SH_NO_ERROR;
	}
	memcpy(value, tmp, useLen);
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


SHErrorCode SH_sqlite3_column_SHDatetime(sqlite3_stmt* stmt, int32_t col, struct SHDatetime *dt,
	int32_t timezoneOffset)
{
	double timestamp = sqlite3_column_double(stmt, col);;
	SHErrorCode status = SH_NO_ERROR;
	status = SH_timestampToDt(timestamp, timezoneOffset, dt);
	return status;;
}


SHErrorCode SH_sqlite3_value_double_ptr(sqlite3_value *cellValue, double **value) {
	if(sqlite3_value_type(cellValue) == SQLITE_FLOAT) {
		*value = malloc(sizeof(double));
		if(NULL == *value) {
			return SH_ALLOC;
		}
		**value = sqlite3_value_double(cellValue);
	}
	else {
		*value = NULL;
	}
	return SH_NO_ERROR;
}


SHErrorCode SH_sqlite3_value_SHDatetime(sqlite3_value *cellValue, struct SHDatetime *dt,
	int32_t timezoneOffset)
{
	double timestamp = sqlite3_value_double(cellValue);
	SHErrorCode status = SH_NO_ERROR;
	status = SH_timestampToDt(timestamp, timezoneOffset, dt);
	return status;;
}


SHErrorCode SH_sqlite3_copy_value_blobFixed(sqlite3_value *cellValue, void *value, uint64_t len) {
	if(!value || len < 1) return SH_ILLEGAL_INPUTS;
	const void *tmp = sqlite3_value_blob(cellValue);
	uint64_t useLen = fmin(len, sqlite3_value_bytes(cellValue));
	if(!tmp) {
		return SH_NO_ERROR;
	}
	memcpy(value, tmp, useLen);
	return SH_NO_ERROR;
}


void SH_cleanupSqlite3Statement(sqlite3_stmt **stmtP2) {
	if(!stmtP2) return;
	sqlite3_stmt *stmt = *stmtP2;
	if(!stmt) return;
	sqlite3_finalize(stmt);
	*stmtP2 = NULL;
}
