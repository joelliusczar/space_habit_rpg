//
//  SHDailyProcessor.c
//  SHModels
//
//  Created by Joel Pridgen on 8/5/20.
//  Copyright © 2020 Joel Gillette. All rights reserved.
//

#include "SHPassiveEventProcessor.h"
#include "SHSqlite3Extensions.h"

SHErrorCode _buildPenaltySumStatementstruct(SHModelsQueueStore *store, sqlite3_stmt **stmt) {
	SHErrorCode status = SH_NO_ERROR;
	char[] sql = "BEGIN;"
		"WITH [activations] AS (SELECT DISTINCT "
		"[dailyPk], "
		"max([fullActivationDateTime]) OVER [activationWin] AS [fullActivationDateTime], "
		"FROM [DailyActivations] "
		"WINDOW activationWin AS (PARTITION BY [dailyPk]) "
		"), "
		"WITH [calculated] AS (SELECT SH_selectSavedUseDateUTC( [da].[fullActivationDateTime], "
			"[da].[tzOffsetFull], "
			"[d].[activeFromDateTime], "
			"[d].[tzOffsetLastUpdateDateTime],"
			"[d].[lastUpdated], "
			"[d].[activeFromHasPriority], "
			"[d].[lastUpdateHasPriority]) AS [SavedUseDate], "
		"), "
		"FROM [Dailies] d "
		"LEFT JOIN [activations] [da] ON [da].[dailyPk] = [d].[pk]"
		") "
		"SELECT [sum]([SH_penalty]([activeDaysBlob],"
			"?1, " //current use date
			"[da].[SavedUseDate], "
			"?2, " //local timezone offset
			"[d].[urgency], "
			"[d].[difficulty], "
			"?3," //monster attack mod
			"?4 )) "//hero def mod
		"FROM [Dailies] d"
		"LEFT JOIN [calculated] [da] ON [da].[dailyPk] = [d].[pk]"
		"WHERE [d].[isEnabled] = 1 AND ?2 "
			"BETWEEN [d].[activeFromDateTime] AND [d].[activeToDateTime]; "
		"END; "
	if((status = SH_sqlite3_prepare(store->db, sql, -1, &stmt, 0)) != SH_NO_ERROR) { goto fnExit; }
	
	fnExit:
		return status;
}

SHErrorCode _calcPenaltySum(struct SHModelsQueueStore *store, uint64_t *penaltySum) {
	SHErrorCode status = SH_NO_ERROR;
	int32_t sqlStatus = SQLITE_OK;
	sqlite3_stmt *stmt = NULL;
	const char *sqlMsg = NULL;
	char errMsg[60];
	struct SHDatetime *todayLocalTime = NULL;
	const struct SHDatetimeProvider *dateProvider = store->dateProvider;
	int32_t tzOffset = dateProvider->getLocalTzOffset();
	
	if((status = _buildPenaltySumStatementstruct(store, &stmt)) != SH_NO_ERROR) { goto fnExit; }
	
	if((sqlStatus = SH_sqlite3_bind_datetime(stmt, 1, todayLocalTime) != SQLITE_OK)) { goto sqlErr; }
	if((sqlStatus = sqlite3_bind_int(stmt, 2, tzOffset) != SQLITE_OK)) { goto sqlErr; }
	
	goto fnExit;
	sqlErr:
		sqlMsg = sqlite3_errmsg(store->db);
		sprintf(errMsg,"sqlite3 Error: %d \nThere was an error pulling data from dailies",sqlStatus);
		SH_notifyOfError(SH_SQLITE3_ERROR, sqlMsg);
		status = SH_SQLITE3_ERROR;
	fnExit:
		SH_freeSHDatetime(todayLocalTime);
		return status;
}


SHErrorCode SH_processPassiveEvents(struct SHModelsQueueStore *store, void *responder,
	SHErrorCode (*handleResults)(void*, struct SHDamageReport))
{
	if(!store || !store->db || !handleResults) return SH_ILLEGAL_INPUTS;
	SHErrorCode status = SH_NO_ERROR;
	
	struct SHDamageReport damageReport = {};
	if((status = handleResults(responder, damageReport)) != SH_NO_ERROR) {}
	
	return status;
}
