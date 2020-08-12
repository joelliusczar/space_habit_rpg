//
//  SHCreateTableStatementBuilders.c
//  SHModels
//
//  Created by Joel Pridgen on 7/25/20.
//  Copyright © 2020 Joel Gillette. All rights reserved.
//

#include "SHCreateTableStatementBuilders.h"


SHErrorCode SH_buildCreateDailyTableStmt(sqlite3_stmt **stmt, sqlite3 *db) {
	int32_t sqlStatus = SQLITE_OK;
	char *sql = "CREATE TABLE IF NOT EXISTS [Dailies] "
		"([pk] INTEGER PRIMARY KEY ASC, " //I would prefer this to be DESC, but that trips on a sqlite3 bug
		"[name] TEXT, "
		"[lastUpdated] REAL NOT NULL, "
		"[activeFromDateTime] REAL, "
		"[activeToDateTime] REAL, "
		"[activeFromHasPriority] INTEGER, "
		"[isEnabled] INTEGER, "
		"[lastUpdateHasPriority] INTEGER, "
		"[note] TEXT, "
		"[customUseOrder] INTEGER, "
		"[dayStartTime] INTEGER, "
		"[difficulty] INTEGER, "
		"[urgency] INTEGER, "
		"[tzOffsetLastUpdateDateTime] INTEGER, "
		"[activeDaysBlob] BLOB, "
		"[stepCountMax] INTEGER "
		"); ";
	sqlStatus = sqlite3_prepare_v2(db, sql, -1, stmt, 0);
	if(sqlStatus != SQLITE_OK) {
		char errMsg[80];
		sprintf(errMsg,"sqlite3 Error: %d \nThere was an error preparing create table statement\n",sqlStatus);
		SH_notifyOfError(SH_SQLITE3_ERROR, errMsg);
		return SH_SQLITE3_ERROR;
	}
	return SH_NO_ERROR;
}


SHErrorCode SH_buildCreateDailyActivationTableStmt(sqlite3_stmt **stmt, sqlite3 *db) {
	int32_t sqlStatus = SQLITE_OK;
	char *sql = "CREATE TABLE IF NOT EXISTS [DailyActivations] "
		"([pk] INTEGER PRIMARY KEY ASC, "
		"[stepActivationDateTime] REAL NOT NULL, "
		"[tzOffsetStep] INTEGER, "
		"[fullActivationDateTime] REAL NOT NULL, "
		"[tzOffsetFull] INTGER, "
		"[streakLength] INTEGER, "
		"[stepCount] INTEGER, "
		"[dailyXp] INTEGER, " //daily lvl will just be xp/100
		"[attackCharge] INTEGER, "
		"[dailyPk] INTEGER "
		"FOREIGN KEY([dailyPk]) REFERENCES [Dailies]([pk]) ON DELETE CASCADE"
		"); ";
	sqlStatus = sqlite3_prepare_v2(db, sql, -1, stmt, 0);
	if(sqlStatus != SQLITE_OK) {
		char errMsg[80];
		sprintf(errMsg,"sqlite3 Error: %d \nThere was an error preparing create table statement\n",sqlStatus);
		SH_notifyOfError(SH_SQLITE3_ERROR, errMsg);
		return SH_SQLITE3_ERROR;
	}
	return SH_NO_ERROR;
}
