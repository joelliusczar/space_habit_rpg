//
//  SHHabit_dbCalls.c
//  SHModels
//
//  Created by Joel Pridgen on 5/30/20.
//  Copyright © 2020 Joel Gillette. All rights reserved.
//

#include "SHHabit_dbCalls.h"
#include "SHTableNames.h"


SHErrorCode _insertHabit(sqlite3 *db, struct SHHabitBase const * habit, const char* tableName, int64_t *insertedPk) {
	int32_t sqlStatus = SQLITE_OK;
	SHErrorCode status = SH_NO_ERROR;
	sqlite3_stmt *stmt = NULL;
	char errMsg[60];
	const char *sqlMsg = NULL;
	char sql[125];
	char *sqlFormat = "INSERT INTO %s ( "
	"name, "
	"lastUpdated, "
	"tzOffsetLastUpdateDateTime "
	") VALUES(?1,?2,?3) ";
	sprintf(sql, sqlFormat, tableName);
	if((sqlStatus = sqlite3_prepare_v2(db, sql, -1, &stmt, 0)) != SQLITE_OK) { goto sqlErr; }
	if((sqlStatus = sqlite3_bind_text(stmt, 1, habit->name, -1, SQLITE_TRANSIENT)) != SQLITE_OK) { goto sqlErr; }
	if((sqlStatus = sqlite3_bind_double(stmt, 2, habit->lastUpdated) != SQLITE_OK)) { goto sqlErr; }
	if((sqlStatus = sqlite3_bind_int(stmt, 3, habit->tzOffsetLastUpdateDateTime) != SQLITE_OK)) { goto sqlErr; }
	
	if((sqlStatus = sqlite3_step(stmt)) != SQLITE_DONE) { goto sqlErr; }
	*insertedPk = (int64_t)sqlite3_last_insert_rowid(db);
	
	goto fnExit;
	sqlErr:
		sqlMsg = sqlite3_errmsg(db);
		sprintf(errMsg,"sqlite3 Error: %d \nThere was an error inserting into %s",sqlStatus, tableName);
		SH_notifyOfError(SH_SQLITE3_ERROR, errMsg);
		SH_notifyOfError(SH_SQLITE3_ERROR, sqlMsg);
		status = SH_SQLITE3_ERROR;
	fnExit:
		sqlite3_finalize(stmt);
		return status;
}


SHErrorCode SH_insertHabit_Daily(sqlite3 *db, struct SHHabitBase const * habit, int64_t *insertedPk) {
	return _insertHabit(db, habit, SH_TABLE_NAME_DAILIES, insertedPk);
}
