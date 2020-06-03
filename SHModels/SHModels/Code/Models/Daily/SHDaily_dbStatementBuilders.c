//
//  SHDaily_dbStatementBuilders.c
//  SHModels
//
//  Created by Joel Pridgen on 5/21/20.
//  Copyright © 2020 Joel Gillette. All rights reserved.
//

#include "SHDaily_dbStatementBuilders.h"


SHErrorCode SH_buildStatement_insertDailyStmt(sqlite3_stmt *stmt, sqlite3 *db) {
	int32_t sqlStatus = SQLITE_OK;
	char *sql = "INSERT INTO Dailies VALUES("
	"name,"
	"lastUpdated,"
	"activeFromDateTime,"
	"activeToDateTime,"
	"lastActivationDateTime,"
	"maxStreak,"
	"activeFromHasPriority,"
	"isEnabled,"
	"lastUpdateHasPriority,"
	"weekIntervalHash,"
	"note,"
	"dailyLvl,"
	"dailyXp,"
	"customUseOrder,"
	"dayStartTime,"
	"difficulty,"
	"urgency,"
	"intervalType,"
	"dayIntevalSize,"
	"streakLength,"
	"tzOffsetLastActivationDateTime,"
	"tzOffsetLastUpdateDateTime,"
	"weekIntervalSize,"
	"monthIntervalHash,"
	"monthIntervalSize,"
	"yearIntervalHash,"
	"yearIntervalSize,"
	"daySkipIntevalSize,"
	"weekSkipIntervalHash,"
	"weekSkipIntervalSize,"
	"monthSkipIntervalHash,"
	"monthSkipIntervalSize,"
	"yearSkipIntervalHash,"
	"yearSkipIntervalSize"
	") VALUES(?1,?2,?3,?4,?5,?6,?7,?8,?9,?10,?11,?12,?13,"
	"?14,?15,?16,?17,?18,?19,?20,?21,?22, ?23, ?24, ?25, ?26, "
	"?27, ?28, ?29, ?30, ?31, ?32, ?33, ?34)";
	
	sqlStatus = sqlite3_prepare_v2(db, sql, -1, &stmt, 0);
	if(sqlStatus != SQLITE_OK) {
		char errMsg[60];
		sprintf(errMsg,"sqlite3 Error: %d \nThere was an error preparing insert statement",sqlStatus);
		SH_notifyOfError(SH_SQLITE3_ERROR, errMsg);
		return SH_SQLITE3_ERROR;
	}
	return SH_NO_ERROR;
}


SHErrorCode SH_buildStatement_updateDailyStmt(sqlite3_stmt *stmt, sqlite3 *db) {
	int32_t sqlStatus = SQLITE_OK;
	char *sql = "UPDATE Dailies "
	"SET name  = ?1"
	"lastUpdated = ?2,"
	"activeFromDateTime = ?3,"
	"activeToDateTime = ?4,"
	"lastActivationDateTime = ?5,"
	"maxStreak = ?6,"
	"activeFromHasPriority = ?7,"
	"isEnabled = ?8,"
	"lastUpdateHasPriority = ?9,"
	"weekIntervalHash = ?10,"
	"note = ?11,"
	"dailyLvl = ?12,"
	"dailyXp = ?13,"
	"customUseOrder = ?14,"
	"dayStartTime = ?15,"
	"difficulty = ?16,"
	"urgency = ?17,"
	"intervalType = ?18,"
	"dayIntevalSize = ?19,"
	"streakLength = ?20,"
	"tzOffsetLastActivationDateTime = ?21,"
	"tzOffsetLastUpdateDateTime = ?22,"
	"weekIntervalSize = ?23,"
	"monthIntervalHash = ?24,"
	"monthIntervalSize = ?25,"
	"yearIntervalHash = ?26,"
	"yearIntervalSize = ?27"
	"daySkipIntevalSize = ?28,"
	"weekSkipIntervalHash = ?29,"
	"weekSkipIntervalSize = ?30,"
	"monthSkipIntervalHash = ?31,"
	"monthSkipIntervalSize = ?32,"
	"yearSkipIntervalHash = ?33,"
	"yearSkipIntervalSize = ?34"
	"WHERE pk = ?35";
	
	sqlStatus = sqlite3_prepare_v2(db, sql, -1, &stmt, 0);
	if(sqlStatus != SQLITE_OK) {
		char errMsg[60];
		sprintf(errMsg,"sqlite3 Error: %d \nThere was an error preparing insert statement",sqlStatus);
		SH_notifyOfError(SH_SQLITE3_ERROR, errMsg);
		return SH_SQLITE3_ERROR;
	}
	return SH_NO_ERROR;
}


SHErrorCode SH_buildStatement_fetchSingleDaily(sqlite3_stmt *stmt, sqlite3 *db) {
	int32_t sqlStatus = SQLITE_OK;
	char *sql = "SELECT "
	"name,"
	"lastUpdated,"
	"activeFromDateTime,"
	"activeToDateTime,"
	"lastActivationDateTime,"
	"maxStreak,"
	"activeFromHasPriority,"
	"isEnabled,"
	"lastUpdateHasPriority,"
	"weekIntervalHash,"
	"note,"
	"dailyLvl,"
	"dailyXp,"
	"customUseOrder,"
	"dayStartTime,"
	"difficulty,"
	"urgency,"
	"intervalType,"
	"dayIntevalSize,"
	"streakLength,"
	"tzOffsetLastActivationDateTime,"
	"tzOffsetLastUpdateDateTime,"
	"weekIntervalSize,"
	"monthIntervalHash,"
	"monthIntervalSize,"
	"yearIntervalHash,"
	"yearIntervalSize"
	"daySkipIntevalSize,"
	"weekSkipIntervalHash,"
	"weekSkipIntervalSize,"
	"monthSkipIntervalHash,"
	"monthSkipIntervalSize,"
	"yearSkipIntervalHash,"
	"yearSkipIntervalSize"
	"FROM Dailies"
	"WHERE pk = ?0";
	
	sqlStatus = sqlite3_prepare_v2(db, sql, -1, &stmt, 0);
	if(sqlStatus != SQLITE_OK) {
		char errMsg[60];
		sprintf(errMsg,"sqlite3 Error: %d \nThere was an error preparing select statement",sqlStatus);
		SH_notifyOfError(SH_SQLITE3_ERROR, errMsg);
		return SH_SQLITE3_ERROR;
	}
	return SH_NO_ERROR;
}

