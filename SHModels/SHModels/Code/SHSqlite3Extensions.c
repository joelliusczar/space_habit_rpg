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
	if(!value) {
		if((sqlStatus = sqlite3_bind_double(stmt, paramNum, *value)) != SQLITE_OK) { goto fnExit; }
	}
	else {
		if((sqlStatus = sqlite3_bind_null(stmt, paramNum)) != SQLITE_OK) { goto fnExit; }
	}
	fnExit:
		return sqlStatus;
}


int32_t SH_sqlite3_bind_datetime(sqlite3_stmt *stmt, int32_t paramNum, struct SHDatetime *value) {
	int32_t sqlStatus = SQLITE_OK;
	SHErrorCode status = SH_NO_ERROR;
	double timestamp = 0;
	if((status = SH_dtToTimestamp(value, &timestamp)) != SH_NO_ERROR) { goto fnErr; }
	if(!value) {
		if((sqlStatus = sqlite3_bind_double(stmt, paramNum, timestamp)) != SQLITE_OK) { goto fnExit; }
	}
	else {
		if((sqlStatus = sqlite3_bind_null(stmt, paramNum)) != SQLITE_OK) { goto fnExit; }
	}
	goto fnExit;
	fnErr:
		sqlStatus = SQLITE_ERROR;
	fnExit:
		return sqlStatus;
}


SHErrorCode SH_sqlite3_copy_column_text(sqlite3_stmt *stmt, int32_t col, char **value) {
	if(!stmt || !value) return SH_ILLEGAL_INPUTS;
	SHErrorCode status = SH_NO_ERROR;
	const char *tmp = (char *)sqlite3_column_text(stmt, col);
	int32_t len = sqlite3_column_bytes(stmt, col);
	if(!tmp) {
		*value = SH_constStrCopy("");
		if(!*value) goto allocErr;
		goto fnExit;
	}
	*value = malloc(sizeof(char) * (len + SH_NULL_CHAR_OFFSET));
	if(!*value && len > 0) goto allocErr;
	strcpy(*value, tmp);
	goto fnExit;
	allocErr:
		status |= SH_ALLOC_NO_MEM;
	fnExit:
		return status;
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
	if(!stmt || !value) return SH_ILLEGAL_INPUTS;
	SHErrorCode status = SH_NO_ERROR;
	if(sqlite3_column_type(stmt, col) == SQLITE_FLOAT) {
		*value = malloc(sizeof(double));
		if(!*value) goto allocErr;
		**value = sqlite3_column_double(stmt, col);
	}
	else {
		*value = NULL;
	}
	goto fnExit;
	allocErr:
		status |= SH_ALLOC_NO_MEM;
	fnExit:
		return status;
}


SHErrorCode SH_sqlite3_column_SHDatetime(sqlite3_stmt* stmt, int32_t col, struct SHDatetime *dt,
	int32_t timezoneOffset)
{
if(!stmt || !dt) return SH_ILLEGAL_INPUTS;
	double timestamp = sqlite3_column_double(stmt, col);;
	SHErrorCode status = SH_NO_ERROR;
	status = SH_timestampToDt(timestamp, timezoneOffset, dt);
	return status;;
}


SHErrorCode SH_sqlite3_value_double_ptr(sqlite3_value *cellValue, double **value) {
	SHErrorCode status = SH_NO_ERROR;
	if(sqlite3_value_type(cellValue) == SQLITE_FLOAT) {
		*value = malloc(sizeof(double));
		if(!*value) goto allocErr;
		**value = sqlite3_value_double(cellValue);
	}
	else {
		*value = NULL;
	}
	goto fnExit;
	allocErr:
		status |= SH_ALLOC_NO_MEM;
	fnExit:
		return status;
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


