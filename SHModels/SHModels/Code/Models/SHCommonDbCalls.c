//
//  SHCommonDbCalls.c
//  SHModels
//
//  Created by Joel Pridgen on 5/31/20.
//  Copyright © 2020 Joel Gillette. All rights reserved.
//

#include "SHCommonDbCalls.h"


SHErrorCode SH_deleteRecord(sqlite3 *db, const char* tableName, int64_t pk) {
	int32_t sqlStatus = SQLITE_OK;
	SHErrorCode status = SH_NO_ERROR;
	sqlite3_stmt *stmt = NULL;
	char errMsg[100];
	char *sql = "DELETE FROM ?1 "
	"WHERE pk = ?2";
	
	sqlStatus = sqlite3_prepare_v2(db, sql, -1, &stmt, 0);
	if((sqlStatus = sqlite3_bind_text(stmt, 1, (char *)tableName, -1, SQLITE_TRANSIENT)) != SQLITE_OK) { goto sqlErr; }
	if((sqlStatus = sqlite3_bind_int64(stmt, 2, pk) != SQLITE_OK)) { goto sqlErr; }
	
	if((sqlStatus = sqlite3_step(stmt)) != SQLITE_OK) { goto sqlErr; }
	
	goto fnExit;
	sqlErr:
		sprintf(errMsg,"sqlite3 Error: %d \nThere was an error deleting record",sqlStatus);
		SH_notifyOfError(SH_SQLITE3_ERROR, errMsg);
		status = SH_SQLITE3_ERROR;
	fnExit:
		sqlite3_finalize(stmt);
		return status;
}
