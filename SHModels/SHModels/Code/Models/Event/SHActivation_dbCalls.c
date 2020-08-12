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
		"[tzOffsetFull], "
		"[streakLength], "
		"[stepCount], "
		"[dailyXp], "
		"[attackCharge] "
		") "
		"SELECT "
		"?2, " //[stepActivationDateTime]
		"?3 " //[tzOffsetStep]
		"?2, " //[fullActivationDateTime]
		"?3, " //[tzOffsetFull]
		"[streakLength] + 1, "
		"[stepCount] + 1, "
		"[dailyXp] + 1, "
		"?4 " //[attackCharge]
		"FROM DailyActivations "
		"WHERE [dailyPk] = ?1 "
		"ORDER BY [stepActivationDateTime] DESC "
		"LIMIT 1 "
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
	char sqlFormat[] = "BEGIN; "
		"INSERT INTO DailyActivations ( "
		"[dailyPk], "
		"[stepActivationDateTime], "
		"[tzOffsetStep], "
		"[fullActivationDateTime], "
		"[tzOffsetFull], "
		"[streakLength], "
		"[dailyLvl], " //reminder: this is not global lvl, this is per daily
		"[stepCount], "
		"[dailyXp], " //reminder: this is not the global xp, this is per daily
		"[attackCharge], "
		") "
		"SELECT "
		"[dailyPk], "
		"?2, " //[stepActivationDateTime]
		"?3 " //[tzOffsetStep]
		"[fullActivationDateTime], "
		"[tzOffsetFull], "
		"[streakLength], "
		"[dailyLvl], "
		"[stepCount] + 1, "
		"[dailyXp] + 1, "
		"?4 " //[attackCharge]
		"FROM DailyActivations "
		"WHERE [dailyPk] = ?1 "
		"ORDER BY [stepActivationDateTime] DESC "
		"LIMIT 1 "
		"END; ";
	if((status = SH_sqlite3_prepare(db, sqlFormat, -1, stmt, 0)) != SH_NO_ERROR) { goto fnExit; }

	fnExit:
		return status;
}


static SHErrorCode _buildStatementForDailyDeactivate(sqlite3 *db, sqlite3_stmt **stmt) {
	SHErrorCode status = SH_NO_ERROR;
	char sqlFormat[] = "BEGIN; "
		"DELETE FROM [DailyActivations]"
		"WHERE [dailyPk] = ?1 AND [stepActivationDateTime] > ?2; "
		"END; ";
	if((status = SH_sqlite3_prepare(db, sqlFormat, -1, stmt, 0)) != SH_NO_ERROR) { goto fnExit; }
	fnExit:
		return status;
}


static SHErrorCode _bindActivationParams(struct SHModelsQueueStore *store, struct SHTableDaily *tableDaily,
	uint64_t attackCharge, sqlite3_stmt *stmt)
{
	int32_t sqlStatus = SQLITE_OK;
	SHErrorCode status = SH_NO_ERROR;
	const char *sqlMsg = NULL;
	char errMsg[60];
	struct SHDatetime *todayLocalTime = NULL;
	const struct SHDatetimeProvider *dateProvider = store->dateProvider;
	todayLocalTime = dateProvider->getDate();
	int32_t tzOffset = dateProvider->getLocalTzOffset();
	
	if((sqlStatus = sqlite3_bind_int64(stmt, 1, tableDaily->pk) != SQLITE_OK)) { goto sqlErr; }
	if((sqlStatus = SH_sqlite3_bind_datetime(stmt, 2, todayLocalTime) != SQLITE_OK)) { goto sqlErr; } //gets saved as utc
	if((sqlStatus = sqlite3_bind_int(stmt, 3, tzOffset) != SQLITE_OK)) { goto sqlErr; }
	
	
	
	if((sqlStatus = sqlite3_bind_int64(stmt, 4, attackCharge) != SQLITE_OK)) { goto sqlErr; }
	goto fnExit;
	sqlErr:
		sqlMsg = sqlite3_errmsg(store->db);
		sprintf(errMsg,"sqlite3 Error: %d \nThere was an error activating daily",sqlStatus);
		SH_notifyOfError(SH_SQLITE3_ERROR, sqlMsg);
		status = SH_SQLITE3_ERROR;
	fnExit:
		free(todayLocalTime);
		return status;
}


static SHErrorCode _selectActivationStatementType(struct SHModelsQueueStore *store, struct SHTableDaily *tableDaily,
	sqlite3_stmt **stmt)
{
	SHErrorCode status = SH_NO_ERROR;
	tableDaily->stepCount++;
	if(tableDaily->stepCount == tableDaily->stepCountMax) {
		if((status = _buildStatementForDailyFullActivate(store->db, &store->addDailyActivation)) != SH_NO_ERROR)
		{
			goto fnExit;
		}
		*stmt = store->addDailyActivation;
		tableDaily->dueStatus = SH_IS_COMPLETED;
	}
	else {
		if((status = _buildStatementForDailyPartialActivate(store->db, &store->addDailyPartialActivation)) != SH_NO_ERROR)
		{
			goto fnExit;
		}
		*stmt = store->addDailyPartialActivation;
	}
	fnExit:
		return status;
}


static SHErrorCode _prepareForFirstHit(struct SHModelsQueueStore *store, struct SHTableDaily *tableDaily) {
	SHErrorCode status = SH_NO_ERROR;
	struct SHDatetime *todayStart = NULL;
	const struct SHDatetimeProvider *dateProvider = store->dateProvider;
	todayStart = dateProvider->getUserTodayStart();
	bool isMultiStepStarted = false;
	if((status = SH_isDateXBeforeDateY(todayStart, tableDaily->stepLastActivationDateTime, &isMultiStepStarted))
		!= SH_NO_ERROR)
	{
		goto fnExit;
	}
	if(!isMultiStepStarted) {
		tableDaily->stepCount = 0;
	}
	fnExit:
		free(todayStart);
		return status;
}


static SHErrorCode _getAttackCharge(struct SHModelsQueueStore *store, struct SHTableDaily *tableDaily,
	int64_t *attackCharge)
{
	SHErrorCode status = SH_NO_ERROR;
	int32_t sqlStatus = SQLITE_OK;
	const char *sqlMsg = NULL;
	char errMsg[60];
	*attackCharge = 0;
	struct SHHeroAttackChargeComponents components;

	char sql[] = "SELECT [urgency], [difficulty] FROM [Dailies WHERE [pk] = ?1";
	if((status = SH_sqlite3_prepare(store->db, sql, -1, &store->fetchDailyAttackValues, 0)) != SH_NO_ERROR) {
		goto sqlErr;
	}
	if((sqlStatus = sqlite3_bind_int64(store->fetchDailyAttackValues, 1, tableDaily->pk) != SQLITE_OK)) { goto sqlErr; }
	components = (struct SHHeroAttackChargeComponents){
		.urgency = sqlite3_column_int(store->fetchDailyAttackValues, 1),
		.difficulty = sqlite3_column_int(store->fetchDailyAttackValues, 2),
		.heroLvl = store->heroData->lvl
	};
	components.urgency = components.urgency > 0 ? components.urgency : 3;
	components.difficulty = components.difficulty > 0 ? components.difficulty : 3;
	components.streakLength = tableDaily->streakLength;
	*attackCharge = SH_calcHeroAttackCharge(&components);
	goto fnExit;
	sqlErr:
		sqlMsg = sqlite3_errmsg(store->db);
		sprintf(errMsg,"sqlite3 Error: %d \nThere was an error pulling data from dailies",sqlStatus);
		SH_notifyOfError(SH_SQLITE3_ERROR, sqlMsg);
		status = SH_SQLITE3_ERROR;
	fnExit:
		return status;
}


static SHErrorCode _updateHeroWithAttachCharge(struct SHModelsQueueStore *store, int64_t attackCharge) {
	SHErrorCode status = SH_NO_ERROR;
	store->heroData->attackCharge += attackCharge;
	if((status = store->resourceProvider->saveObjectToFile(store->heroData,
		sizeof(struct SHHeroData), store->heroDataPath))
	!= SH_NO_ERROR)
	{
		goto fnExit;
	}
	fnExit:
		return status;
}


static SHErrorCode _addActivationRecords(struct SHModelsQueueStore *store, struct SHTableDaily *tableDaily)
{
	int32_t sqlStatus = SQLITE_OK;
	SHErrorCode status = SH_NO_ERROR;
	char errMsg[60];
	const char *sqlMsg = NULL;
	sqlite3_stmt *stmt = NULL;
	int64_t attackCharge = 0;
	
	if((status = _prepareForFirstHit(store, tableDaily)) != SH_NO_ERROR) { goto fnExit; }
	
	if((status = _selectActivationStatementType(store, tableDaily, &stmt)) != SH_NO_ERROR) {
		goto fnExit;
	}
	if((status = _getAttackCharge(store, tableDaily, &attackCharge)) != SH_NO_ERROR) { goto fnExit; }
	if((status = _bindActivationParams(store, tableDaily, attackCharge, stmt)) != SH_NO_ERROR) { goto fnExit; }
	if((sqlStatus = sqlite3_step(stmt)) != SQLITE_DONE) { goto sqlErr; }
	if((status = _updateHeroWithAttachCharge(store, attackCharge)) != SH_NO_ERROR) { goto fnExit; }
	
	tableDaily->dueStatus = SH_IS_COMPLETED;
	goto fnExit;
	sqlErr:
		sqlMsg = sqlite3_errmsg(store->db);
		sprintf(errMsg,"sqlite3 Error: %d \nThere was an error activating daily",sqlStatus);
		SH_notifyOfError(SH_SQLITE3_ERROR, sqlMsg);
		status = SH_SQLITE3_ERROR;
	fnExit:
		return status;
}


static SHErrorCode _getSubtractedAttackCharge(struct SHModelsQueueStore *store, struct SHTableDaily *tableDaily,
	int64_t *attackCharge)
{
	int32_t sqlStatus = SQLITE_OK;
	SHErrorCode status = SH_NO_ERROR;
	char errMsg[60];
	const char *sqlMsg = NULL;
	struct SHDatetime *todayStart = NULL;
	const struct SHDatetimeProvider *dateProvider = store->dateProvider;
	todayStart = dateProvider->getUserTodayStart(); //local time
	char sql[] = "SELECT sum([attackCharge]) FROM [DailyActivations] WHERE "
		"WHERE [dailyPk] = ?1 AND [stepActivationDateTime] > ?2;";
	if((status = SH_sqlite3_prepare(store->db, sql, -1, &store->getAttackChargeSumForToday, 0)) != SH_NO_ERROR) {
		goto sqlErr;
	}
	if((sqlStatus = sqlite3_bind_int64(store->getAttackChargeSumForToday, 1, tableDaily->pk) != SQLITE_OK)) { goto sqlErr; }
	if((sqlStatus = SH_sqlite3_bind_datetime(store->getAttackChargeSumForToday, 2, todayStart) != SQLITE_OK)) { //utc time
		goto sqlErr;
	}
	if((sqlStatus = sqlite3_step(store->getAttackChargeSumForToday)) != SQLITE_DONE) { goto sqlErr; }
	*attackCharge = sqlite3_column_int64(store->getAttackChargeSumForToday, 0);
	
	goto fnExit;
	sqlErr:
		sqlMsg = sqlite3_errmsg(store->db);
		sprintf(errMsg,"sqlite3 Error: %d \nThere was an error activating daily",sqlStatus);
		SH_notifyOfError(SH_SQLITE3_ERROR, sqlMsg);
		status = SH_SQLITE3_ERROR;
	fnExit:
		return status;
}


static SHErrorCode _removeActivationRecords(struct SHModelsQueueStore *store, struct SHTableDaily *tableDaily)
{
	int32_t sqlStatus = SQLITE_OK;
	SHErrorCode status = SH_NO_ERROR;
	char errMsg[60];
	const char *sqlMsg = NULL;
	struct SHDatetime *todayStart = NULL;
	int64_t attackCharge = 0;
	const struct SHDatetimeProvider *dateProvider = store->dateProvider;
	todayStart = dateProvider->getUserTodayStart(); //local time
	if((status = _buildStatementForDailyDeactivate(store->db, &store->removeDailyActivation)) != SH_NO_ERROR) {
		goto sqlErr;
	}
	
	if((sqlStatus = sqlite3_bind_int64(store->removeDailyActivation, 1, tableDaily->pk) != SQLITE_OK)) { goto sqlErr; }
	if((sqlStatus = SH_sqlite3_bind_datetime(store->removeDailyActivation, 2, todayStart) != SQLITE_OK)) { //utc time
		goto sqlErr;
	}
	
	if((sqlStatus = sqlite3_step(store->removeDailyActivation)) != SQLITE_DONE) { goto sqlErr; }
	if((status = _getSubtractedAttackCharge(store, tableDaily, &attackCharge)) != SH_NO_ERROR) { goto fnExit; }
	if((status = _updateHeroWithAttachCharge(store, attackCharge)) != SH_NO_ERROR) { goto fnExit; }
	tableDaily->dueStatus = SH_IS_DUE;
	tableDaily->stepCount = 0; //setting to 0 is okay, because we don't have partial deactivates, only full
	
	goto fnExit;
	sqlErr:
		sqlMsg = sqlite3_errmsg(store->db);
		sprintf(errMsg,"sqlite3 Error: %d \nThere was an error error deactivating daily",sqlStatus);
		SH_notifyOfError(SH_SQLITE3_ERROR, sqlMsg);
		status = SH_SQLITE3_ERROR;
	fnExit:
		free(todayStart);
		return status;
}


SHErrorCode SH_daily_addActivationRecords(struct SHModelsQueueStore *store, struct SHTableDaily *tableDaily)
{
	if(!store || !store->db || !tableDaily || !store->dateProvider || !store->resourceProvider || !store->heroData) {
		return SH_ILLEGAL_INPUTS;
	}
	if(!store->dateProvider->getDate || !store->dateProvider->getLocalTzOffset
		|| !store->dateProvider->getUserTodayStart)
	{
		return SH_ILLEGAL_INPUTS;
	}
	if(!store->resourceProvider->saveObjectToFile || !store->heroDataPath) return SH_ILLEGAL_INPUTS;
	SHErrorCode status = SH_NO_ERROR;
	if(tableDaily->dueStatus == SH_IS_NOT_DUE) goto fnExit;
	else if(tableDaily->dueStatus == SH_IS_DUE) {
		return _addActivationRecords(store, tableDaily);
	}
	else if(tableDaily->dueStatus == SH_IS_COMPLETED) {
		return _removeActivationRecords(store, tableDaily);
	}
	else {
		status = SH_INVALID_STATE;
	}
	
	
	fnExit:
		return status;
}


SHErrorCode SH_daily_removeActivationRecords(struct SHModelsQueueStore *store, struct SHTableDaily *tableDaily)
{
	if(!store || !tableDaily || !store->dateProvider || !store->resourceProvider) return SH_ILLEGAL_INPUTS;
	if(!store->dateProvider->getDate || !store->dateProvider->getLocalTzOffset
		|| !store->dateProvider->getUserTodayStart)
	{
		return SH_ILLEGAL_INPUTS;
	}
	if(!store->resourceProvider->saveObjectToFile || !store->heroDataPath) return SH_ILLEGAL_INPUTS;
	SHErrorCode status = SH_NO_ERROR;
	
	if((status = _removeActivationRecords(store, tableDaily)) != SH_NO_ERROR) {
		goto fnExit;
	
	}

	fnExit:
		return status;
}

