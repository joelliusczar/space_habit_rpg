//
//  SHDbSetup.c
//  SHModels
//
//  Created by Joel Pridgen on 5/21/20.
//  Copyright © 2020 Joel Gillette. All rights reserved.
//

#include "SHDbSetup.h"
#include "SHSqlite3Extensions.h"
#include "SHDaily_dbFuncs.h"
#include "SHTableNames.h"
#include <stdlib.h>


static SHErrorCode _buildCreateDailyTableStmt(sqlite3_stmt **stmt, sqlite3 *db) {
	int32_t sqlStatus = SQLITE_OK;
	char *sql = "CREATE TABLE IF NOT EXISTS Dailies "
		"(pk INTEGER PRIMARY KEY ASC, "
		"name TEXT, "
		"lastUpdated REAL NOT NULL, "
		"activeFromDateTime REAL, "
		"activeToDateTime REAL, "
		"lastActivationDateTime REAL, "
		"maxStreak INTEGER, "
		"activeFromHasPriority INTEGER, "
		"isEnabled INTEGER, "
		"lastUpdateHasPriority INTEGER, "
		"weekIntervalHash INTEGER, "
		"note TEXT, "
		"dailyLvl INTEGER, "
		"dailyXp INTEGER, "
		"customUseOrder INTEGER, "
		"dayStartTime INTEGER, "
		"difficulty INTEGER, "
		"urgency INTEGER, "
		"intervalType INTEGER, "
		"dayIntevalSize INTEGER, "
		"streakLength INTEGER, "
		"tzOffsetLastActivationDateTime INTEGER, "
		"tzOffsetLastUpdateDateTime INTEGER, "
		"weekIntervalSize INTEGER, "
		"monthIntervalHash INTEGER, "
		"monthIntervalSize INTEGER, "
		"yearIntervalHash TEXT, "
		"yearIntervalSize INTEGER, "
		"daySkipIntevalSize INTEGER, "
		"weekSkipIntervalHash INTEGER, "
		"weekSkipIntervalSize INTEGER, "
		"monthSkipIntervalHash INTEGER, "
		"monthSkipIntervalSize INTEGER, "
		"yearSkipIntervalHash TEXT, "
		"yearSkipIntervalSize INTEGER "
		")";
	sqlStatus = sqlite3_prepare_v2(db, sql, -1, stmt, 0);
	if(sqlStatus != SQLITE_OK) {
		char errMsg[80];
		sprintf(errMsg,"sqlite3 Error: %d \nThere was an error preparing create table statement\n",sqlStatus);
		SH_notifyOfError(SH_SQLITE3_ERROR, errMsg);
		return SH_SQLITE3_ERROR;
	}
	return SH_NO_ERROR;
}


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
	
	if((status = _buildCreateDailyTableStmt(&stmt, db)) != SH_NO_ERROR) { goto sqlErr; }
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


SHErrorCode SH_addDbFunctions(sqlite3 *db) {
	int32_t sqlStatus = SQLITE_OK;
	if((sqlStatus = sqlite3_create_function(db, "SH_selectSavedUseDateUTC", 7,
		SQLITE_UTF8 | SQLITE_DETERMINISTIC, NULL, SHDB_selectSavedUseDate, NULL, NULL))
		!= SQLITE_OK) {}

	return SH_NO_ERROR;
}
