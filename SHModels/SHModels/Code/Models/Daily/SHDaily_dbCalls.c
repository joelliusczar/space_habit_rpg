//
//  SHDaily_dbFuncs.c
//  SHData
//
//  Created by Joel Pridgen on 5/20/20.
//  Copyright © 2020 Joel Gillette. All rights reserved.
//

#include "SHDaily_dbCalls.h"
#include "SHSqlite3Extensions.h"
#include "SHDaily_dbStatementBuilders.h"
#include <SHUtils_C/SHGenAlgos.h>
#include <stdlib.h>

SHErrorCode SH_bindAllDailyParams(sqlite3_stmt *stmt, struct SHDaily const * const daily) {
	int32_t sqlStatus = SQLITE_OK;
	char errMsg[70];
	if((sqlStatus = sqlite3_bind_text(stmt, 1, (char *)daily->base.name, -1, SQLITE_TRANSIENT)) != SQLITE_OK) { goto sqlErr; }
	if((sqlStatus = sqlite3_bind_double(stmt, 2, daily->base.lastUpdated) != SQLITE_OK)) { goto sqlErr; }
	if((sqlStatus = SH_sqlite3_bind_optional_double(stmt, 3, daily->activeFromDateTime) != SQLITE_OK)) { goto sqlErr; }
	if((sqlStatus = SH_sqlite3_bind_optional_double(stmt, 4, daily->activeToDateTime) != SQLITE_OK)) { goto sqlErr; }
	if((sqlStatus = SH_sqlite3_bind_optional_double(stmt, 5, daily->lastActivationDateTime) != SQLITE_OK)) { goto sqlErr; }
	if((sqlStatus = sqlite3_bind_int(stmt, 6, daily->maxStreak) != SQLITE_OK)) { goto sqlErr; }
	if((sqlStatus = sqlite3_bind_int(stmt, 7, daily->activeFromHasPriority) != SQLITE_OK)) { goto sqlErr; }
	if((sqlStatus = sqlite3_bind_int(stmt, 8, daily->isEnabled) != SQLITE_OK)) { goto sqlErr; }
	if((sqlStatus = sqlite3_bind_int(stmt, 9, daily->lastUpdateHasPriority) != SQLITE_OK)) { goto sqlErr; }
	if((sqlStatus = sqlite3_bind_int(stmt, 10, daily->weekIntervalHash) != SQLITE_OK)) { goto sqlErr; }
	if((sqlStatus = sqlite3_bind_text(stmt, 11, (char *)daily->note, -1, SQLITE_TRANSIENT) != SQLITE_OK)) { goto sqlErr; }
	if((sqlStatus = sqlite3_bind_int(stmt, 12, daily->dailyLvl) != SQLITE_OK)) { goto sqlErr; }
	if((sqlStatus = sqlite3_bind_int(stmt, 13, daily->dailyXp) != SQLITE_OK)) { goto sqlErr; }
	if((sqlStatus = sqlite3_bind_int(stmt, 14, daily->customUseOrder) != SQLITE_OK)) { goto sqlErr; }
	if((sqlStatus = sqlite3_bind_int(stmt, 15, daily->dayStartTime) != SQLITE_OK)) { goto sqlErr; }
	if((sqlStatus = sqlite3_bind_int(stmt, 16, daily->difficulty) != SQLITE_OK)) { goto sqlErr; }
	if((sqlStatus = sqlite3_bind_int(stmt, 17, daily->urgency) != SQLITE_OK)) { goto sqlErr; }
	if((sqlStatus = sqlite3_bind_int(stmt, 18, daily->activeDays.intervalType) != SQLITE_OK)) { goto sqlErr; }
	if((sqlStatus = sqlite3_bind_int(stmt, 19, daily->activeDays.dayIntevalSize) != SQLITE_OK)) { goto sqlErr; }
	if((sqlStatus = sqlite3_bind_int(stmt, 20, daily->streakLength) != SQLITE_OK)) { goto sqlErr; }
	if((sqlStatus = sqlite3_bind_int(stmt, 21, daily->tzOffsetLastActivationDateTime) != SQLITE_OK)) { goto sqlErr; }
	if((sqlStatus = sqlite3_bind_int(stmt, 22, daily->base.tzOffsetLastUpdateDateTime) != SQLITE_OK)) { goto sqlErr; }
	if((sqlStatus = sqlite3_bind_int(stmt, 23, daily->activeDays.weekIntervalSize) != SQLITE_OK)) { goto sqlErr; }
	if((sqlStatus = sqlite3_bind_int64(stmt, 24, daily->activeDays.monthIntervalHash) != SQLITE_OK)) { goto sqlErr; }
	if((sqlStatus = sqlite3_bind_int(stmt, 25, daily->activeDays.monthIntervalSize) != SQLITE_OK)) { goto sqlErr; }
	if((sqlStatus = sqlite3_bind_text(stmt, 26, (char *)daily->activeDays.yearIntervalHash, -1, SQLITE_TRANSIENT) != SQLITE_OK)) { goto sqlErr; }
	if((sqlStatus = sqlite3_bind_int(stmt, 27, daily->activeDays.yearIntervalSize) != SQLITE_OK)) { goto sqlErr; }
	if((sqlStatus = sqlite3_bind_int(stmt, 28, daily->activeDays.daySkipIntevalSize) != SQLITE_OK)) { goto sqlErr; }
	if((sqlStatus = sqlite3_bind_int(stmt, 29, daily->activeDays.weekSkipIntervalHash) != SQLITE_OK)) { goto sqlErr; }
	if((sqlStatus = sqlite3_bind_int(stmt, 30, daily->activeDays.weekSkipIntervalSize) != SQLITE_OK)) { goto sqlErr; }
	if((sqlStatus = sqlite3_bind_int64(stmt, 31, daily->activeDays.monthSkipIntervalHash) != SQLITE_OK)) { goto sqlErr; }
	if((sqlStatus = sqlite3_bind_int(stmt, 32, daily->activeDays.monthSkipIntervalSize) != SQLITE_OK)) { goto sqlErr; }
	if((sqlStatus = sqlite3_bind_text(stmt, 33, (char *)daily->activeDays.yearSkipIntervalHash, -1, SQLITE_TRANSIENT) != SQLITE_OK)) { goto sqlErr; }
	if((sqlStatus = sqlite3_bind_int(stmt, 34, daily->activeDays.yearSkipIntervalSize) != SQLITE_OK)) { goto sqlErr; }
	if((sqlStatus = sqlite3_bind_int64(stmt, 35, daily->base.pk) != SQLITE_OK)) { goto sqlErr; }
	
	return SH_NO_ERROR;
	sqlErr:
		sprintf(errMsg,"sqlite3 Error: %d \nThere was an error binding a param",sqlStatus);
		SH_notifyOfError(SH_SQLITE3_ERROR, errMsg);
		return SH_SQLITE3_ERROR;
}


SHErrorCode SH_updateDaily(sqlite3 *db, struct SHDaily const * daily) {
	int32_t sqlStatus = SQLITE_OK;
	SHErrorCode status = SH_NO_ERROR;
	sqlite3_stmt *stmt = NULL;
	char errMsg[60];
	if((status = SH_buildStatement_updateDailyStmt(&stmt, db)) != SQLITE_OK) { goto sqlErr; }
	if((status = SH_bindAllDailyParams(stmt, daily)) != SH_NO_ERROR) { goto sqlErr; }
	if((sqlStatus = sqlite3_bind_int64(stmt, 23, daily->base.pk)) != SQLITE_OK) { goto sqlErr; }
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


SHErrorCode SH_insertDaily(sqlite3 *db, struct SHDaily const * daily, int64_t *insertedPk) {
	int32_t sqlStatus = SQLITE_OK;
	SHErrorCode status = SH_NO_ERROR;
	sqlite3_stmt *stmt = NULL;
	char errMsg[60];
	if((status = SH_buildStatement_insertDailyStmt(&stmt, db)) != SH_NO_ERROR) { goto sqlErr; }
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
	
	daily->base.pk = sqlite3_column_int(stmt, 0);
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
	daily->maxStreak = sqlite3_column_int(stmt, 6);
	daily->activeFromHasPriority = sqlite3_column_int(stmt, 7);
	daily->isEnabled = sqlite3_column_int(stmt, 8);
	daily->lastUpdateHasPriority = sqlite3_column_int(stmt, 9);
	daily->weekIntervalHash = sqlite3_column_int(stmt, 10);
	if((status = SH_sqlite3_copy_column_text(stmt, 11, &daily->note)) != SH_NO_ERROR) {
		goto cleanupLastActivationDateTime;
	}
	daily->dailyLvl = sqlite3_column_int(stmt, 12);
	daily->dailyXp = sqlite3_column_int(stmt, 13);
	daily->customUseOrder = sqlite3_column_int(stmt, 14);
	daily->dayStartTime = sqlite3_column_int(stmt, 15);
	daily->difficulty = sqlite3_column_int(stmt, 16);
	daily->urgency = sqlite3_column_int(stmt, 17);
	daily->activeDays.intervalType = sqlite3_column_int(stmt, 18);
	daily->activeDays.dayIntevalSize = sqlite3_column_int(stmt, 19);
	daily->streakLength = sqlite3_column_int(stmt, 20);
	daily->tzOffsetLastActivationDateTime = sqlite3_column_int(stmt, 21);
	daily->base.tzOffsetLastUpdateDateTime = sqlite3_column_int(stmt, 22);
	daily->activeDays.weekIntervalSize = sqlite3_column_int(stmt, 23);
	daily->activeDays.monthIntervalHash = sqlite3_column_int(stmt, 24);
	daily->activeDays.monthIntervalSize = sqlite3_column_int(stmt, 25);
	if((status = SH_sqlite3_copy_column_text(stmt, 26, &daily->activeDays.yearIntervalHash)) != SH_NO_ERROR) {
		goto cleanupNote;
	}
	daily->activeDays.yearIntervalSize = sqlite3_column_int(stmt, 27);
	daily->activeDays.daySkipIntevalSize = sqlite3_column_int(stmt, 28);
	daily->activeDays.weekSkipIntervalHash = sqlite3_column_int(stmt, 29);
	daily->activeDays.weekSkipIntervalSize = sqlite3_column_int(stmt, 30);
	daily->activeDays.monthSkipIntervalHash = sqlite3_column_int(stmt, 31);
	daily->activeDays.monthSkipIntervalSize = sqlite3_column_int(stmt, 32);
	if((status = SH_sqlite3_copy_column_text(stmt, 33, &daily->activeDays.yearSkipIntervalHash)) != SH_NO_ERROR) {
		goto cleanupYearIntervalHash;
	}
	daily->activeDays.yearSkipIntervalSize = sqlite3_column_int(stmt, 34);
	return SH_NO_ERROR;
	cleanupYearIntervalHash:
		free(daily->activeDays.yearIntervalHash);
	cleanupNote:
		free(daily->note);
	cleanupLastActivationDateTime:
		free(daily->lastActivationDateTime);
	cleanupActiveToDateTime:
		free(daily->activeToDateTime);
	cleanupActiveFromDateTime:
		free(daily->activeFromDateTime);
	cleanupName:
		free(daily->base.name);
		SH_notifyOfError(status, "Issue while loading fetched values into daily");
		return status;
}


static void _setMissingValues(struct SHDaily *daily) {
	SHIntervalType intervalType = daily->activeDays.intervalType;
	if(intervalType == SH_UNDETERMINED_INTERVAL) {
		daily->activeDays.intervalType = SH_WEEKLY_INTERVAL;
		daily->activeDays.weekIntervalHash = SH_FULL_WEEK_HASH;
		daily->activeDays.monthIntervalHash = SH_FULL_MONTH_HASH;
		if(daily->activeDays.yearIntervalHash) free(daily->activeDays.yearIntervalHash);
		daily->activeDays.yearIntervalHash = SH_constStrCopy(SH_FULL_YEAR_HASH);
		daily->activeDays.weekSkipIntervalHash = SH_FULL_WEEK_HASH;
		daily->activeDays.monthSkipIntervalHash = SH_FULL_MONTH_HASH;
		if(daily->activeDays.yearSkipIntervalHash) free(daily->activeDays.yearSkipIntervalHash);
		daily->activeDays.yearSkipIntervalHash = SH_constStrCopy(SH_FULL_YEAR_HASH);
	}
	daily->activeDays.dayIntevalSize = daily->activeDays.dayIntevalSize > 0 ?
		daily->activeDays.dayIntevalSize : 1;
	daily->activeDays.daySkipIntevalSize = daily->activeDays.daySkipIntevalSize > 0 ?
		daily->activeDays.daySkipIntevalSize : 1;
	daily->activeDays.weekIntervalSize = daily->activeDays.weekIntervalSize > 0 ?
		daily->activeDays.weekIntervalSize : 1;
	daily->activeDays.weekSkipIntervalSize = daily->activeDays.weekSkipIntervalSize > 0 ?
		daily->activeDays.weekSkipIntervalSize : 1;
	daily->activeDays.monthIntervalSize = daily->activeDays.monthIntervalSize > 0 ?
		daily->activeDays.monthIntervalSize : 1;
	daily->activeDays.monthSkipIntervalSize = daily->activeDays.monthSkipIntervalSize > 0 ?
		daily->activeDays.monthSkipIntervalSize : 1;
	daily->activeDays.yearIntervalSize = daily->activeDays.yearIntervalSize > 0 ?
		daily->activeDays.yearIntervalSize : 1;
	daily->activeDays.yearSkipIntervalSize = daily->activeDays.yearSkipIntervalSize > 0 ?
		daily->activeDays.yearSkipIntervalSize : 1;
	daily->difficulty = daily->difficulty > 0 ? daily->difficulty : 3;
	daily->urgency = daily->urgency > 0 ? daily->urgency : 3;
}


SHErrorCode SH_fetchSingleDaily(sqlite3 *db, int64_t pk, struct SHDaily *daily) {
	int32_t sqlStatus = SQLITE_OK;
	SHErrorCode status = SH_NO_ERROR;
	sqlite3_stmt *stmt = NULL;
	char errMsg[60];
	if((status = SH_buildStatement_fetchSingleDaily(&stmt, db)) != SH_NO_ERROR) { goto shErr; }
	if((sqlStatus = sqlite3_bind_int64(stmt, 1, pk)) != SQLITE_OK) { goto sqlErr; }
	sqlStatus = sqlite3_step(stmt);
	if(sqlStatus != SQLITE_ROW && sqlStatus != SQLITE_DONE) { goto sqlErr; }
	if((status = _setDailyValues(stmt, daily)) != SH_NO_ERROR) { goto shErr; }
	_setMissingValues(daily);
	goto fnExit;
	sqlErr:
		sprintf(errMsg,"sqlite3 Error: %d \nThere was an error fetching daily",sqlStatus);
		SH_notifyOfError(SH_SQLITE3_ERROR, errMsg);
		status = SH_SQLITE3_ERROR;
		goto fnExit;
	shErr:
		SH_notifyOfError(SH_SQLITE3_ERROR, "Something happened while binding");
	fnExit:
		sqlite3_finalize(stmt);
		return status;
}


