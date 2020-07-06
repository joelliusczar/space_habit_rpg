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
	char *sql = "INSERT INTO Dailies ("
	"name, "
	"lastUpdated, "
	"activeFromDateTime, "
	"activeToDateTime,"
	"lastActivationDateTime, "
	"maxStreak,"
	"activeFromHasPriority, "
	"isEnabled,"
	"lastUpdateHasPriority, "
	"note, "
	"dailyLvl, "
	"dailyXp, "
	"customUseOrder, "
	"dayStartTime, "
	"difficulty, "
	"urgency, "
	"intervalType, "
	"streakLength, "
	"tzOffsetLastActivationDateTime, "
	"tzOffsetLastUpdateDateTime, "
	"activeDaysBlob "
	") VALUES(?1,?2,?3,?4,?5,?6,?7,?8,?9,?10,?11,?12,?13,"
	"?14,?15,?16,?17,?18,?19,?20,?21) ";
	
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
	"lastActivationDateTime = ?5, "
	"maxStreak = ?6, "
	"activeFromHasPriority = ?7, "
	"isEnabled = ?8, "
	"lastUpdateHasPriority = ?9, "
	"note = ?10, "
	"dailyLvl = ?11, "
	"dailyXp = ?12, "
	"customUseOrder = ?13, "
	"dayStartTime = ?14, "
	"difficulty = ?15, "
	"urgency = ?16, "
	"streakLength = ?17, "
	"tzOffsetLastActivationDateTime = ?18, "
	"tzOffsetLastUpdateDateTime = ?19, "
	"activeDaysBlob = ?20"
	"WHERE pk = ?21";
	
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
	"pk, "
	"name, "
	"lastUpdated, "
	"activeFromDateTime, "
	"activeToDateTime, "
	"lastActivationDateTime, "
	"maxStreak, "
	"activeFromHasPriority, "
	"isEnabled, "
	"lastUpdateHasPriority, "
	"note, "
	"dailyLvl, "
	"dailyXp, "
	"customUseOrder, "
	"dayStartTime, "
	"difficulty, "
	"urgency, "
	"intervalType, "
	"streakLength, "
	"tzOffsetLastActivationDateTime, "
	"tzOffsetLastUpdateDateTime, "
	"activeDaysBlob "
	"FROM Dailies "
	"WHERE pk = ?1 ";
	
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
	char *sql = "SELECT "
		"pk, "
		"name, "
		"streakLength, "
		"maxStreak, "
		"dailyLvl, "
		"dailyXp, "
		"SH_selectSavedUseDateUTC(lastActivationDateTime, "
			"tzOffsetLastActivationDateTime, "
			"activeFromDateTime, "
			"tzOffsetLastUpdateDateTime,"
			"lastUpdated, "
			"activeFromHasPriority, "
			"lastUpdateHasPriority) AS SavedUseDate, "
		"SH_nextDueDate(activeDaysBlob, "
			"strftime('%s','now'), "
			"SavedUseDate, "
			"?1 "
			") AS nextDueDate, "
		"SH_getDueStatus(activeDaysBlob, "
			"strftime('%s','now'), "
			"SavedUseDate, "
			"?1"
			") AS dueStatus"
		"FROM Dailies "
		"WHERE isEnabled = 1 AND strftime('%s','now', 'localtime') "
			"BETWEEN activeFromDateTime AND activeToDateTime"
		"ORDER BY dueStatus";
	sqlStatus = sqlite3_prepare_v2(db, sql, -1, stmt, 0);
	if(sqlStatus != SQLITE_OK) {
		char errMsg[60];
		sprintf(errMsg,"sqlite3 Error: %d \nThere was an error preparing select statement",sqlStatus);
		SH_notifyOfError(SH_SQLITE3_ERROR, errMsg);
		return SH_SQLITE3_ERROR;
	}
	return SH_NO_ERROR;
}

