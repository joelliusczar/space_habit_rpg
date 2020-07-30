//
//  SHActivation_dbCalls.c
//  SHModels
//
//  Created by Joel Pridgen on 7/25/20.
//  Copyright © 2020 Joel Gillette. All rights reserved.
//

#include "SHActivation_dbCalls.h"
#include "SHSqlite3Extensions.h"
#include <stdlib.h>
#include <stdbool.h>


static SHErrorCode _buildStatementForDailyFullActivate(sqlite3 *db, sqlite3_stmt **stmt) {
	SHErrorCode status = SH_NO_ERROR;
	int32_t sqlStatus = SQLITE_OK;
	const char *sqlMsg = NULL;
	char errMsg[60];
	char sqlFormat[] = "BEGIN; "
		"INSERT INTO DailyActivations ( "
		"[dailyPk], "
		"[stepActivationDateTime], "
		"[tzOffsetStep], "
		"[fullActivationDateTime], "
		"[tzOffsetFull] "
		") VALUES(?1, ?2, ?3, ?2, ?3); "
		"UPDATE Dailies "
		"SET lastActivationDateTime] = ?2, "
		"[tzOffsetLastActivationDateTime] = ?3, "
		"[stepLastActivationDateTime] = ?2, "
		"[tzOffsetStepLastActivation] = ?3, "
		"[lastUpdated] = ?2, "
		"[tzOffsetLastUpdateDateTime] = ?3, "
		"[stepCount = stepCountMax] "
		"WHERE [pk] = $1; "
		"END; ";
	if((sqlStatus = sqlite3_prepare_v2(db, sqlFormat, -1, stmt, 0)) != SQLITE_OK) { goto sqlErr; }
	goto fnExit;
	sqlErr:
		sqlMsg = sqlite3_errmsg(db);
		sprintf(errMsg,"sqlite3 Error: %d \nThere was an error activating daily",sqlStatus);
		SH_notifyOfError(SH_SQLITE3_ERROR, sqlMsg);
		status = SH_SQLITE3_ERROR;
	fnExit:
		return status;
}


static SHErrorCode _buildStatementForDailyPartialActivate(sqlite3 *db, sqlite3_stmt **stmt) {
	SHErrorCode status = SH_NO_ERROR;
	int32_t sqlStatus = SQLITE_OK;
	const char *sqlMsg = NULL;
	char errMsg[60];
	char sqlFormat[] = "BEGIN; "
		"WITH d AS (SELECT lastActivationDateTime, tzOffsetLastActivationDateTime FROM Dailies WHERE pk = ?1)"
		"INSERT INTO DailyActivations ( "
		"[dailyPk], "
		"[stepActivationDateTime], "
		"[tzOffsetStep], "
		"[fullActivationDateTime], "
		"[tzOffsetFull] "
		") VALUES(?1, ?2, ?3, d.lastActivationDateTime, d.tzOffsetLastActivationDateTime); "
		"UPDATE Dailies "
		"SET "
		"[stepLastActivationDateTime] = ?2, "
		"[tzOffsetStepLastActivation] = ?3, "
		"[lastUpdated] = ?2, "
		"[tzOffsetLastUpdateDateTime] = ?3, "
		"[stepCount] = ?4 "
		"WHERE [pk] = $1; "
		"END; ";
	if((sqlStatus = sqlite3_prepare_v2(db, sqlFormat, -1, stmt, 0)) != SQLITE_OK) { goto sqlErr; }
	goto fnExit;
	sqlErr:
		sqlMsg = sqlite3_errmsg(db);
		sprintf(errMsg,"sqlite3 Error: %d \nThere was an error partially activating daily",sqlStatus);
		SH_notifyOfError(SH_SQLITE3_ERROR, sqlMsg);
		status = SH_SQLITE3_ERROR;
	fnExit:
		return status;
}


static SHErrorCode _buildStatementForDailyDeactivate(sqlite3 *db, sqlite3_stmt **stmt) {
	SHErrorCode status = SH_NO_ERROR;
	int32_t sqlStatus = SQLITE_OK;
	const char *sqlMsg = NULL;
	char errMsg[60];
	char sqlFormat[] = "BEGIN; "
		
		"WITH [rollback] AS (SELECT * FROM [DailyActivations] ORDER BY [pk] DESC LIMIT 1, 1) "
		"UPDATE [Dailies[ "
		"SET "
		"[lastActivationDateTime] = rollback.fullActivationDateTime, "
		"[tzOffsetLastActivationDateTime] = rollback.tzOffsetFull, "
		"[stepLastActivationDateTime] = rollback.stepActivationDateTime, "
		"[tzOffsetStepLastActivation] = rollback.tzOffsetStep, "
		"[lastUpdated] = ?2, "
		"[tzOffsetLastUpdateDateTime] = ?3, "
		"[stepCount] = 0"
		"WHERE [pk] = $1; "
		"WITH top AS (SELECT [pk] FROM [DailyActivations] ORDER BY [pk] WHERE "
		"[dailyPk] = ?1 AND [stepActivationDateTime] > ?4)"
		"DELETE FROM [DailyActivations] da"
		"WHERE da.[pk] = top.[pk]; "
		"END; ";
	if((sqlStatus = sqlite3_prepare_v2(db, sqlFormat, -1, stmt, 0)) != SQLITE_OK) { goto sqlErr; }
	goto fnExit;
	sqlErr:
		sqlMsg = sqlite3_errmsg(db);
		sprintf(errMsg,"sqlite3 Error: %d \nThere was an error deactivating daily",sqlStatus);
		SH_notifyOfError(SH_SQLITE3_ERROR, sqlMsg);
		status = SH_SQLITE3_ERROR;
	fnExit:
		return status;
}


static SHErrorCode _activate(sqlite3 *db, struct SHTableDaily *tableDaily,
	const struct SHDatetimeProvider *dateProvider)
{
	int32_t sqlStatus = SQLITE_OK;
	SHErrorCode status = SH_NO_ERROR;
	sqlite3_stmt *stmt = NULL;
	char errMsg[60];
	const char *sqlMsg = NULL;
	struct SHDatetime *today = NULL;
	struct SHDatetime *todayStart = NULL;
	int32_t tzOffset = dateProvider->getLocalTzOffset();
	today = dateProvider->getDate(); //local time
	todayStart = dateProvider->getUserTodayStart();
	bool isMultiStepStarted = false;
	if((status = SH_isDateXBeforeDateY(todayStart, tableDaily->stepLastActivationDateTime, &isMultiStepStarted))
		!= SH_NO_ERROR) { goto fnExit; }
	if(!isMultiStepStarted) {
		tableDaily->stepCount = 0;
	}
	tableDaily->stepCount++;
	if(tableDaily->stepCount == tableDaily->stepCountMax) {
		if((status = _buildStatementForDailyFullActivate(db, &stmt)) != SH_NO_ERROR) { goto sqlErr; }
		tableDaily->dueStatus = SH_IS_COMPLETED;
	}
	else {
		if((status = _buildStatementForDailyPartialActivate(db, &stmt)) != SH_NO_ERROR) { goto sqlErr; }
		if((sqlStatus = sqlite3_bind_int(stmt, 4, tableDaily->stepCount) != SQLITE_OK)) { goto sqlErr; }
	}
	
	if((sqlStatus = sqlite3_bind_int64(stmt, 1, tableDaily->pk) != SQLITE_OK)) { goto sqlErr; }
	if((sqlStatus = SH_sqlite3_bind_datetime(stmt, 2, today) != SQLITE_OK)) { goto sqlErr; } //gets saved as utc
	if((sqlStatus = sqlite3_bind_int(stmt, 3, tzOffset) != SQLITE_OK)) { goto sqlErr; }
	
	if((sqlStatus = sqlite3_step(stmt)) != SQLITE_DONE) { goto sqlErr; }
	tableDaily->dueStatus = SH_IS_COMPLETED;
	
	goto fnExit;
	sqlErr:
		sqlMsg = sqlite3_errmsg(db);
		sprintf(errMsg,"sqlite3 Error: %d \nThere was an error activating daily",sqlStatus);
		SH_notifyOfError(SH_SQLITE3_ERROR, sqlMsg);
		status = SH_SQLITE3_ERROR;
	fnExit:
		free(today);
		free(todayStart);
		sqlite3_finalize(stmt);
		return status;
}


static SHErrorCode _deactivate(sqlite3 *db, struct SHTableDaily *tableDaily,
	const struct SHDatetimeProvider *dateProvider)
{
	int32_t sqlStatus = SQLITE_OK;
	SHErrorCode status = SH_NO_ERROR;
	sqlite3_stmt *stmt = NULL;
	char errMsg[60];
	const char *sqlMsg = NULL;
	struct SHDatetime *today = NULL;
	struct SHDatetime *todayStart = NULL;
	int32_t tzOffset = dateProvider->getLocalTzOffset();
	today = dateProvider->getDate(); //local time
	todayStart = dateProvider->getUserTodayStart(); //local time
	if((status = _buildStatementForDailyDeactivate(db, &stmt)) != SH_NO_ERROR) { goto sqlErr; }
	
	if((sqlStatus = sqlite3_bind_int64(stmt, 1, tableDaily->pk) != SQLITE_OK)) { goto sqlErr; }
	if((sqlStatus = SH_sqlite3_bind_datetime(stmt, 2, today) != SQLITE_OK)) { goto sqlErr; } //utc time
	if((sqlStatus = sqlite3_bind_int(stmt, 3, tzOffset) != SQLITE_OK)) { goto sqlErr; }
	if((sqlStatus = SH_sqlite3_bind_datetime(stmt, 4, todayStart) != SQLITE_OK)) { goto sqlErr; } //utc time
	
	if((sqlStatus = sqlite3_step(stmt)) != SQLITE_DONE) { goto sqlErr; }
	tableDaily->dueStatus = SH_IS_DUE;
	tableDaily->stepCount = 0; //setting to 0 is okay, because we don't have partial deactivates, only full
	
	goto fnExit;
	sqlErr:
		sqlMsg = sqlite3_errmsg(db);
		sprintf(errMsg,"sqlite3 Error: %d \nThere was an error error deactivating daily",sqlStatus);
		SH_notifyOfError(SH_SQLITE3_ERROR, sqlMsg);
		status = SH_SQLITE3_ERROR;
	fnExit:
		free(today);
		free(todayStart);
		sqlite3_finalize(stmt);
		return status;
}

SHErrorCode SH_activateDaily(sqlite3 *db, struct SHTableDaily *tableDaily,
	const struct SHDatetimeProvider *dateProvider)
{
	if(!db || !tableDaily || !dateProvider) return SH_ILLEGAL_INPUTS;
	if(!dateProvider->getDate || !dateProvider->getUserTodayStart) return SH_ILLEGAL_INPUTS;
	SHErrorCode status = SH_NO_ERROR;
	if(tableDaily->dueStatus == SH_IS_NOT_DUE) goto fnExit;
	else if(tableDaily->dueStatus == SH_IS_DUE) {
		return _activate(db, tableDaily, dateProvider);
	}
	else if(tableDaily->dueStatus == SH_IS_COMPLETED) {
		return _deactivate(db, tableDaily, dateProvider);
	}
	else {
		status = SH_INVALID_STATE;
	}
	
	
	fnExit:
		return status;
}


SHErrorCode SH_deactivateDaily(sqlite3 *db, struct SHTableDaily *tableDaily,
	const struct SHDatetimeProvider *dateProvider)
{
	if(!db || !tableDaily) return SH_ILLEGAL_INPUTS;
	SHErrorCode status = SH_NO_ERROR;
	if((status = _deactivate(db, tableDaily, dateProvider)) != SH_NO_ERROR) { goto fnExit; }

	fnExit:
		return status;
}

