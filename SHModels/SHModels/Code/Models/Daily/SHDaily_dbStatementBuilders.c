//
//  SHDaily_dbStatementBuilders.c
//  SHModels
//
//  Created by Joel Pridgen on 5/21/20.
//  Copyright © 2020 Joel Gillette. All rights reserved.
//

#include "SHDaily_dbStatementBuilders.h"


SHErrorCode SH_buildStatement_insertDailyStmt(sqlite3_stmt **stmt, sqlite3 *db) {
	int32_t sqlStatus = SQLITE_OK;
	char *sql = "INSERT INTO [Dailies] ("
	"[name], "
	"[lastUpdated], "
	"[activeFromDateTime], "
	"[activeToDateTime],"
	"[activeFromHasPriority], "
	"[isEnabled],"
	"[lastUpdateHasPriority], "
	"[note], "
	"[customUseOrder], "
	"[dayStartTime], "
	"[difficulty], "
	"[urgency], "
	"[intervalType], "
	"[tzOffsetLastUpdateDateTime], "
	"[activeDaysBlob], "
	"[stepCountMax] "
	") VALUES(?1, ?2, ?3, ?4, ?5, ?6, ?7, ?8, ?9, ?10, ?11, ?12, ?13, "
	"?14, ?15); ";
	
	sqlStatus = sqlite3_prepare_v2(db, sql, -1, stmt, 0);
	if(sqlStatus != SQLITE_OK) {
		char errMsg[60];
		sprintf(errMsg,"sqlite3 Error: %d \nThere was an error preparing insert statement",sqlStatus);
		SH_notifyOfError(SH_SQLITE3_ERROR, errMsg);
		return SH_SQLITE3_ERROR;
	}
	return SH_NO_ERROR;
}


SHErrorCode SH_buildStatement_updateDailyStmt(sqlite3_stmt **stmt, sqlite3 *db) {
	int32_t sqlStatus = SQLITE_OK;
	char *sql = "UPDATE Dailies "
	"SET name = ?1, "
	"lastUpdated = ?2, "
	"activeFromDateTime = ?3, "
	"activeToDateTime = ?4, "
	"activeFromHasPriority = ?5, "
	"isEnabled = ?6, "
	"lastUpdateHasPriority = ?7, "
	"note = ?8, "
	"customUseOrder = ?9, "
	"dayStartTime = ?10, "
	"difficulty = ?11, "
	"urgency = ?12, "
	"tzOffsetLastUpdateDateTime = ?13, "
	"activeDaysBlob = ?14, "
	"stepCountMax = ?15"
	"WHERE pk = ?16; ";
	
	sqlStatus = sqlite3_prepare_v2(db, sql, -1, stmt, 0);
	if(sqlStatus != SQLITE_OK) {
		char errMsg[80];
		sprintf(errMsg,"sqlite3 Error: %d \nThere was an error preparing update statement",sqlStatus);
		SH_notifyOfError(SH_SQLITE3_ERROR, errMsg);
		return SH_SQLITE3_ERROR;
	}
	return SH_NO_ERROR;
}


SHErrorCode SH_buildStatement_fetchSingleDaily(sqlite3_stmt **stmt, sqlite3 *db) {
	int32_t sqlStatus = SQLITE_OK;
	char *sql = "SELECT "
	"[pk], "
	"[name], "
	"[lastUpdated], "
	"[activeFromDateTime], "
	"[activeToDateTime], "
	"[activeFromHasPriority], "
	"[isEnabled], "
	"[lastUpdateHasPriority], "
	"[note], "
	"[customUseOrder], "
	"[dayStartTime], "
	"[difficulty], "
	"[urgency], "
	"[tzOffsetLastUpdateDateTime], "
	"[activeDaysBlob], "
	"[stepCountMax] "
	"FROM [Dailies] "
	"WHERE [pk] = ?1; ";
	
	sqlStatus = sqlite3_prepare_v2(db, sql, -1, stmt, 0);
	if(sqlStatus != SQLITE_OK) {
		char errMsg[60];
		sprintf(errMsg,"sqlite3 Error: %d \nThere was an error preparing select statement",sqlStatus);
		SH_notifyOfError(SH_SQLITE3_ERROR, errMsg);
		return SH_SQLITE3_ERROR;
	}
	return SH_NO_ERROR;
}


SHErrorCode SH_buildStatement_fetchAllTableDailies(sqlite3_stmt **stmt, sqlite3 *db) {
	int32_t sqlStatus = SQLITE_OK;
	char *sql = "BEGIN;"
		"WITH [activations] AS (SELECT "
		"DISTINCT "
		"[dailyPk], "
		"last_value([streakLength]) OVER [activationWin] AS [CurrentStreak], "
		"max([streakLength]) OVER [activationWin] AS [maxStreak], "
		"max([dailyLvl]) OVER [activationWin] AS [dailyLvl], "
		"sum([dailyXp]) OVER [activationWin] AS [dailyXp], "
		"max([stepActivationDateTime]) OVER [activationWin] AS [stepActivationDateTime], "
		"last_value([tzOffsetStep]) OVER [activationWin] AS [tzOffsetStep], "
		"max([fullActivationDateTime]) OVER [activationWin] AS [fullActivationDateTime], "
		"last_value([tzOffsetFull]) OVER [activationWin] AS [tzOffsetFull] "
		"max([stepCount]) OVER [activationWin] AS [stepCount], "
		"FROM [DailyActivations] "
		"WINDOW activationWin AS (PARTITION BY [dailyPk]) "
		"), "
		"WITH [calculated] AS (SELECT [da].*, "
		"SH_selectSavedUseDateUTC([da].[fullActivationDateTime], " //reminder: we don't care what timezone saved date is in
			"[da].[tzOffsetFull], "
			"[d].[activeFromDateTime], "
			"[d].[tzOffsetLastUpdateDateTime],"
			"[d].[lastUpdated], "
			"[d].[activeFromHasPriority], "
			"[d].[lastUpdateHasPriority]) AS [SavedUseDate], "
		"), "
		"(CAST([da].[dailyXp] / 100) AS INT) AS [dailyLvl] "
		"FROM [Dailies] d "
		"LEFT JOIN [activations] [da] ON [da].[dailyPk] = [d].[pk]"
		") "
		"SELECT "
		"[da].*, "
		"[d].[name], "
		"SH_nextDueDate([d].[activeDaysBlob], "
			"?2, " //utc timestamp
			"[da].[SavedUseDate], "
			"?1 "
			") AS [nextDueDate], "
		"SH_getDueStatus([d].[activeDaysBlob], "
			"?2, "
			"[da].[SavedUseDate], "
			"?1 "
			") AS [dueStatus] "
		"[d].[stepCountMax], "
		"FROM [Dailies] d"
		"LEFT JOIN [calculated] [da] ON [da].[dailyPk] = [d].[pk]"
		"WHERE [d].[isEnabled] = 1 AND ?2 "
			"BETWEEN [d].[activeFromDateTime] AND [d].[activeToDateTime] "
		"ORDER BY [dueStatus]; ";
	sqlStatus = sqlite3_prepare_v2(db, sql, -1, stmt, 0);
	if(sqlStatus != SQLITE_OK) {
		char errMsg[60];
		sprintf(errMsg,"sqlite3 Error: %d \nThere was an error preparing select statement",sqlStatus);
		SH_notifyOfError(SH_SQLITE3_ERROR, errMsg);
		return SH_SQLITE3_ERROR;
	}
	return SH_NO_ERROR;
}

