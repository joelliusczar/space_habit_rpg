//
//  SHDbSetup.c
//  SHModels
//
//  Created by Joel Pridgen on 5/21/20.
//  Copyright © 2020 Joel Gillette. All rights reserved.
//

#include "SHCreateTableStatementBuilders.h"
#include "SHDbSetup.h"
#include "SHSqlite3Extensions.h"
#include "SHDaily_dbFuncs.h"
#include "SHTableNames.h"
#include <stdlib.h>



SHErrorCode SH_openDb(sqlite3 **db, const char * dbFilePath) {
	int32_t sqlStatus = SQLITE_OK;
	SHErrorCode status = SH_NO_ERROR;
	
	if((sqlStatus = sqlite3_open_v2(dbFilePath, db,
		SQLITE_OPEN_READWRITE | SQLITE_OPEN_CREATE, NULL))
		!= SQLITE_OK)
		{ goto sqlErr; }
	goto fnExit;
	sqlErr:
		sqlite3_close(*db);
		char errMsg[60];
		sprintf(errMsg,"sqlite3 Error: %d \nCould not open or create database\n",sqlStatus);
		SH_notifyOfError(SH_SQLITE3_ERROR, errMsg);
		status = SH_SQLITE3_ERROR;
	fnExit:
		return status;
}


SHErrorCode SH_createTables(sqlite3 *db) {
	int32_t sqlStatus = SQLITE_OK;
	SHErrorCode status = SH_NO_ERROR;
	sqlite3_stmt *stmt = NULL;
	
	if((status = SH_buildCreateDailyTableStmt(&stmt, db)) != SH_NO_ERROR) { goto sqlErr; }
	if((sqlStatus = sqlite3_step(stmt)) != SQLITE_DONE) {
		goto sqlErr;
	}
	if((sqlStatus = sqlite3_reset(stmt)) != SQLITE_OK) { goto sqlErr; }
	if((status = SH_buildCreateDailyActivationTableStmt(&stmt, db)) != SH_NO_ERROR) { goto sqlErr; }
	if((sqlStatus = sqlite3_step(stmt)) != SQLITE_DONE) {
		goto sqlErr;
	}
	goto fnExit;
	sqlErr:
		sqlite3_close(db);
		char errMsg[60];
		sprintf(errMsg,"sqlite3 Error: %d \nCould not create tables\n",sqlStatus);
		SH_notifyOfError(SH_SQLITE3_ERROR, errMsg);
		status = SH_SQLITE3_ERROR;
	fnExit:
		sqlite3_finalize(stmt);
		return status;
}


SHErrorCode SH_setupDb(sqlite3 *db) {
	int32_t sqlStatus = SQLITE_OK;
	SHErrorCode status = SH_NO_ERROR;
	
	if((status = SH_createTables(db)) != SH_NO_ERROR) {
		goto sqlErr;
	}

	goto fnExit;
	sqlErr:
		sqlite3_close(db);
		char errMsg[60];
		sprintf(errMsg,"sqlite3 Error: %d \nCould not create tables\n",sqlStatus);
		SH_notifyOfError(SH_SQLITE3_ERROR, errMsg);
		status = SH_SQLITE3_ERROR;
	fnExit:
		return status;
}


SHErrorCode SH_addDbFunctions(sqlite3 *db, const struct SHConfigAccessor *config) {
	SHErrorCode status = SH_NO_ERROR;
	int32_t sqlStatus = SQLITE_OK;
	if((sqlStatus = sqlite3_create_function(db, "SH_selectSavedUseDateUTC", 7,
		SQLITE_UTF8 | SQLITE_DETERMINISTIC, NULL, SH_db_selectSavedUseDate, NULL, NULL))
		!= SQLITE_OK)
	{
		SH_notifyOfError(SH_SQLITE3_ERROR, "While adding SH_db_selectSavedUseDate");
		goto fnExit;
		
	}
	if((sqlStatus = sqlite3_create_function(db, "SH_nextDueDate", 4,
		SQLITE_UTF8 | SQLITE_DETERMINISTIC, (void*)config, SH_db_nextDueDate, NULL, NULL))
		!= SQLITE_OK)
	{
		SH_notifyOfError(SH_SQLITE3_ERROR, "While adding SH_db_nextDueDate");
		goto fnExit;
	}
	if((sqlStatus = sqlite3_create_function(db, "SH_isDateActive", 4,
		SQLITE_UTF8 | SQLITE_DETERMINISTIC, (void*)config, SH_db_isDateActive, NULL, NULL))
		!= SQLITE_OK)
	{
		SH_notifyOfError(SH_SQLITE3_ERROR, "While adding SH_db_isDateActive");
		goto fnExit;
	}
	if((sqlStatus = sqlite3_create_function(db, "SH_missedDays", 4,
		SQLITE_UTF8 | SQLITE_DETERMINISTIC, (void*)config, SH_db_missedDays, NULL, NULL))
		!= SQLITE_OK)
	{
		SH_notifyOfError(SH_SQLITE3_ERROR, "While adding SH_db_missedDays");
		goto fnExit;
	}
	if((sqlStatus = sqlite3_create_function(db, "SH_penalty", 8,
		SQLITE_UTF8 | SQLITE_DETERMINISTIC, (void*)config, SH_db_penalty, NULL, NULL))
		!= SQLITE_OK)
	{
		SH_notifyOfError(SH_SQLITE3_ERROR, "While adding SH_db_penalty");
		goto fnExit;
	}
	if((sqlStatus = sqlite3_create_function(db, "SH_getDueStatus", 4,
		SQLITE_UTF8 | SQLITE_DETERMINISTIC, (void*)config, SH_db_getDueStatus, NULL, NULL))
		!= SQLITE_OK)
	{
		SH_notifyOfError(SH_SQLITE3_ERROR, "While adding SH_db_getDueStatus");
		goto fnExit;
	}
	return SH_NO_ERROR;
	fnExit:
		status |= SH_SQLITE3_ERROR;
		SH_notifyOfError(status, "Failed to add sql function");
		return status;
}
