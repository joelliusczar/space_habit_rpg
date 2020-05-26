//
//  SHDaily_dbFuncs.c
//  SHData
//
//  Created by Joel Pridgen on 5/20/20.
//  Copyright © 2020 Joel Gillette. All rights reserved.
//

#include "SHDaily_dbFuncs.h"
#include "SHSqlite3Extensions.h"
#include "SHDaily_dbStatementBuilders.h"
#include <stdlib.h>

SHErrorCode SH_bindAllDailyParams(sqlite3_stmt *stmt, struct SHDaily const * const daily) {
	int32_t paramNum = 1;
	int32_t sqlStatus = SQLITE_OK;
	char errMsg[70];
	if((sqlStatus = sqlite3_bind_text(stmt, 1, (char *)daily->base.name, -1, SQLITE_TRANSIENT)) != SQLITE_OK) { goto sqlErr; }
	if((sqlStatus = sqlite3_bind_double(stmt, 2, daily->base.lastUpdated) != SQLITE_OK)) { goto sqlErr; }
	if((sqlStatus = SH_sqlite3_bind_optional_double(stmt, 3, daily->activeFromDateTime) != SQLITE_OK)) { goto sqlErr; }
	if((sqlStatus = SH_sqlite3_bind_optional_double(stmt, 4, daily->activeToDateTime) != SQLITE_OK)) { goto sqlErr; }
	if((sqlStatus = SH_sqlite3_bind_optional_double(stmt, 5, daily->lastActivationDateTime) != SQLITE_OK)) { goto sqlErr; }
	if((sqlStatus = SH_sqlite3_bind_optional_double(stmt, 6, daily->lastUpdateDateTime) != SQLITE_OK)) { goto sqlErr; }
	if((sqlStatus = sqlite3_bind_int(stmt, 7, daily->activeFromHasPriority) != SQLITE_OK)) { goto sqlErr; }
	if((sqlStatus = sqlite3_bind_int(stmt, 8, daily->isEnabled) != SQLITE_OK)) { goto sqlErr; }
	if((sqlStatus = sqlite3_bind_int(stmt, 9, daily->lastUpdateHasPriority) != SQLITE_OK)) { goto sqlErr; }
	if((sqlStatus = sqlite3_bind_text(stmt, 10, (char *)daily->activeDays, -1, SQLITE_TRANSIENT) != SQLITE_OK)) { goto sqlErr; }
	if((sqlStatus = sqlite3_bind_text(stmt, 11, (char *)daily->note, -1, SQLITE_TRANSIENT) != SQLITE_OK)) { goto sqlErr; }
	if((sqlStatus = sqlite3_bind_int(stmt, 12, daily->dailyLvl) != SQLITE_OK)) { goto sqlErr; }
	if((sqlStatus = sqlite3_bind_int(stmt, 13, daily->dailyXp) != SQLITE_OK)) { goto sqlErr; }
	if((sqlStatus = sqlite3_bind_int(stmt, 14, daily->customUseOrder) != SQLITE_OK)) { goto sqlErr; }
	if((sqlStatus = sqlite3_bind_int(stmt, 15, daily->dayStartTime) != SQLITE_OK)) { goto sqlErr; }
	if((sqlStatus = sqlite3_bind_int(stmt, 16, daily->difficulty) != SQLITE_OK)) { goto sqlErr; }
	if((sqlStatus = sqlite3_bind_int(stmt, 17, daily->urgency) != SQLITE_OK)) { goto sqlErr; }
	if((sqlStatus = sqlite3_bind_int(stmt, 18, daily->intervalType) != SQLITE_OK)) { goto sqlErr; }
	if((sqlStatus = sqlite3_bind_int(stmt, 19, daily->lastUpdateTzOffset) != SQLITE_OK)) { goto sqlErr; }
	if((sqlStatus = sqlite3_bind_int(stmt, 20, daily->streakLength) != SQLITE_OK)) { goto sqlErr; }
	if((sqlStatus = sqlite3_bind_int(stmt, 21, daily->tzOffsetLastActivationDateTime) != SQLITE_OK)) { goto sqlErr; }
	if((sqlStatus = sqlite3_bind_int(stmt, 22, daily->tzOffsetLastUpdateDateTime) != SQLITE_OK)) { goto sqlErr; }
	
	return SH_NO_ERROR;
	sqlErr:
		sprintf(errMsg,"sqlite3 Error: %d \nThere was an error binding param #%d",sqlStatus, paramNum);
		SH_notifyOfError(SH_SQLITE3_ERROR, errMsg);
		return SH_SQLITE3_ERROR;
}


SHErrorCode SH_updateDaily(struct SHDaily const * daily, sqlite3 *db) {
	int32_t sqlStatus = SQLITE_OK;
	SHErrorCode status = SH_NO_ERROR;
	sqlite3_stmt *stmt = NULL;
	char errMsg[60];
	if((sqlStatus = SH_buildStatement_updateDailyStmt(stmt, db)) != SQLITE_OK) { goto sqlErr; }
	if((sqlStatus = SH_bindAllDailyParams(stmt, daily)) != SQLITE_OK) { goto sqlErr; }
	if((sqlStatus = sqlite3_bind_int(stmt, 23, daily->pk)) != SQLITE_OK) {}
	if((sqlStatus = sqlite3_step(stmt)) != SQLITE_OK) { goto sqlErr; }
	
	goto fnExit;
	sqlErr:
		sprintf(errMsg,"sqlite3 Error: %d \nThere was an error inserting daily",sqlStatus);
		SH_notifyOfError(SH_SQLITE3_ERROR, errMsg);
		status = SH_SQLITE3_ERROR;
	fnExit:
		sqlite3_finalize(stmt);
		return status;
}


SHErrorCode SH_insertDaily(struct SHDaily const * daily, sqlite3 *db, int64_t *insertedPk) {
	int32_t sqlStatus = SQLITE_OK;
	SHErrorCode status = SH_NO_ERROR;
	sqlite3_stmt *stmt = NULL;
	char errMsg[60];
	if((sqlStatus = SH_buildStatement_insertDailyStmt(stmt, db)) != SQLITE_OK) { goto sqlErr; }
	if((sqlStatus = SH_bindAllDailyParams(stmt, daily)) != SQLITE_OK) { goto sqlErr; }
	if((sqlStatus = sqlite3_step(stmt)) != SQLITE_OK) { goto sqlErr; }
	*insertedPk = (int64_t)sqlite3_last_insert_rowid(db);
	
	goto fnExit;
	sqlErr:
		sprintf(errMsg,"sqlite3 Error: %d \nThere was an error inserting daily",sqlStatus);
		SH_notifyOfError(SH_SQLITE3_ERROR, errMsg);
		status = SH_SQLITE3_ERROR;
	fnExit:
		sqlite3_finalize(stmt);
		return status;
}


static SHErrorCode _setDailyValues(sqlite3_stmt *stmt, struct SHDaily *daily) {
	
	daily->pk = sqlite3_column_int(stmt, 0);
	SHErrorCode status = SH_NO_ERROR;
	if((status = SH_sqlite3_copy_column_text(stmt, 1, &daily->base.name)) != SH_NO_ERROR) { return status; }
	daily->base.lastUpdated = sqlite3_column_double(stmt, 2);
	if((status = SH_sqlite3_column_double_ptr(stmt,3, &daily->activeFromDateTime)) != SH_NO_ERROR) {
		goto cleanupName;
	}
	if((status = SH_sqlite3_column_double_ptr(stmt,4, &daily->activeToDateTime)) != SH_NO_ERROR) {
		goto cleanupActiveFromDateTime;
	}
	if((status = SH_sqlite3_column_double_ptr(stmt,5, &daily->lastActivationDateTime)) != SH_NO_ERROR) {
		goto cleanupActiveToDateTime;
	}
	if((status = SH_sqlite3_column_double_ptr(stmt,6, &daily->lastUpdateDateTime)) != SH_NO_ERROR) {
		goto cleanupLastActivationDateTime;
	}
	daily->activeFromHasPriority = sqlite3_column_int(stmt, 7);
	daily->isEnabled = sqlite3_column_int(stmt, 8);
	daily->lastUpdateHasPriority = sqlite3_column_int(stmt, 9);
	if((status = SH_sqlite3_copy_column_text(stmt, 10, &daily->activeDays)) != SH_NO_ERROR) {
		goto cleanupLastUpdateDateTime;
	}
	if((status = SH_sqlite3_copy_column_text(stmt, 11, &daily->note)) != SH_NO_ERROR) {
		goto cleanupActiveDays;
	}
	daily->dailyLvl = sqlite3_column_int(stmt, 12);
	daily->dailyXp = sqlite3_column_int(stmt, 13);
	daily->customUseOrder = sqlite3_column_int(stmt, 14);
	daily->dayStartTime = sqlite3_column_int(stmt, 15);
	daily->difficulty = sqlite3_column_int(stmt, 16);
	daily->urgency = sqlite3_column_int(stmt, 17);
	daily->intervalType = sqlite3_column_int(stmt, 18);
	daily->lastUpdateTzOffset = sqlite3_column_int(stmt, 19);
	daily->streakLength = sqlite3_column_int(stmt, 20);
	daily->tzOffsetLastActivationDateTime = sqlite3_column_int(stmt, 21);
	daily->tzOffsetLastUpdateDateTime = sqlite3_column_int(stmt, 22);
	return SH_NO_ERROR;
	cleanupActiveDays:
		free(daily->activeDays);
	cleanupLastUpdateDateTime:
		free(daily->lastUpdateDateTime);
	cleanupLastActivationDateTime:
		free(daily->lastActivationDateTime);
	cleanupActiveToDateTime:
		free(daily->activeToDateTime);
	cleanupActiveFromDateTime:
		free(daily->activeFromDateTime);
	cleanupName:
		free(daily->base.name);
		SH_notifyOfError(SH_ALLOC, "Could not allocate additional memory for daily");
		return SH_ALLOC;
}


SHErrorCode SH_fetchSingleDaily(sqlite3 *db, int32_t pk, struct SHDaily *daily) {
	int32_t sqlStatus = SQLITE_OK;
	SHErrorCode status = SH_NO_ERROR;
	sqlite3_stmt *stmt = NULL;
	char errMsg[60];
	if((sqlStatus = SH_buildStatement_fetchSingleDaily(stmt, db)) != SQLITE_OK) { goto sqlErr; }
	if((sqlStatus = sqlite3_bind_int(stmt, 0, pk)) != SQLITE_OK) { goto sqlErr; }
	if((sqlStatus = sqlite3_step(stmt)) != SQLITE_DONE) { goto sqlErr; }
	if((status = _setDailyValues(stmt, daily)) != SH_NO_ERROR) { goto fnExit; }
	sqlErr:
		sprintf(errMsg,"sqlite3 Error: %d \nThere was an error fetching daily",sqlStatus);
		SH_notifyOfError(SH_SQLITE3_ERROR, errMsg);
		status = SH_SQLITE3_ERROR;
	fnExit:
		sqlite3_finalize(stmt);
		return status;
}


void SH_freeDailyProps(struct SHDaily *daily) {
	free(daily->base.name);
	free(daily->activeFromDateTime);
	free(daily->activeToDateTime);
	free(daily->activeToDateTime);
	free(daily->lastActivationDateTime);
	free(daily->lastUpdateDateTime);
	free(daily->activeDays);
	free(daily->note);
}


void SH_freeDaily(struct SHDaily *daily) {
	SH_freeDailyProps(daily);
	free(daily);
}
