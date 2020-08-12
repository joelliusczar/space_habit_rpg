//
//  SHDaily_dbFuncs.c
//  SHData
//
//  Created by Joel Pridgen on 5/20/20.
//  Copyright © 2020 Joel Gillette. All rights reserved.
//

#include "SHDaily_dbCalls.h"
#include "SHSqlite3Extensions.h"
#include "SHTableDailiesFuncs.h"
#include "SHDaily_dbStatementBuilders.h"
#include <SHUtils_C/SHGenAlgos.h>
#include <SHUtils_C/SHTree.h>
#include <SHUtils_C/SHDynamicArray.h>
#include <SHUtils_C/SHIterableWrapper.h>
#include <SHUtils_C/SHPipeline.h>
#include <stdlib.h>
#include <string.h>

SHErrorCode SH_bindAllDailyParams(sqlite3_stmt *stmt, struct SHDaily const * const daily) {
	int32_t sqlStatus = SQLITE_OK;
	char errMsg[70];
	if((sqlStatus = sqlite3_bind_text(stmt, 1, (char *)daily->base.name, -1, SQLITE_TRANSIENT)) != SQLITE_OK) { goto sqlErr; }
	if((sqlStatus = sqlite3_bind_double(stmt, 2, daily->base.lastUpdated) != SQLITE_OK)) { goto sqlErr; }
	if((sqlStatus = SH_sqlite3_bind_optional_double(stmt, 3, daily->activeFromDateTime) != SQLITE_OK)) { goto sqlErr; }
	if((sqlStatus = SH_sqlite3_bind_optional_double(stmt, 4, daily->activeToDateTime) != SQLITE_OK)) { goto sqlErr; }
	if((sqlStatus = sqlite3_bind_int(stmt, 5, daily->activeFromHasPriority) != SQLITE_OK)) { goto sqlErr; }
	if((sqlStatus = sqlite3_bind_int(stmt, 6, daily->isEnabled) != SQLITE_OK)) { goto sqlErr; }
	if((sqlStatus = sqlite3_bind_int(stmt, 7, daily->lastUpdateHasPriority) != SQLITE_OK)) { goto sqlErr; }
	if((sqlStatus = sqlite3_bind_text(stmt, 8, (char *)daily->note, -1, SQLITE_TRANSIENT) != SQLITE_OK)) { goto sqlErr; }
	if((sqlStatus = sqlite3_bind_int(stmt, 9, daily->customUseOrder) != SQLITE_OK)) { goto sqlErr; }
	if((sqlStatus = sqlite3_bind_int(stmt, 10, daily->dayStartTime) != SQLITE_OK)) { goto sqlErr; }
	if((sqlStatus = sqlite3_bind_int(stmt, 11, daily->difficulty) != SQLITE_OK)) { goto sqlErr; }
	if((sqlStatus = sqlite3_bind_int(stmt, 12, daily->urgency) != SQLITE_OK)) { goto sqlErr; }
	if((sqlStatus = sqlite3_bind_int(stmt, 13, daily->base.tzOffsetLastUpdateDateTime) != SQLITE_OK)) { goto sqlErr; }
	if((sqlStatus = sqlite3_bind_blob(stmt, 14, &daily->activeDays, sizeof(struct SHActiveDaysValues), SQLITE_TRANSIENT))
		!= SQLITE_OK) { goto sqlErr; }
	if((sqlStatus = sqlite3_bind_int(stmt, 15, daily->stepCountMax) != SQLITE_OK)) { goto sqlErr; }
		
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
	if((status = SH_buildStatement_updateDailyStmt(&stmt, db)) != SH_NO_ERROR) { goto sqlErr; }
	if((status = SH_bindAllDailyParams(stmt, daily)) != SH_NO_ERROR) { goto sqlErr; }
	if((sqlStatus = sqlite3_bind_int64(stmt, 16, daily->base.pk)) != SQLITE_OK) { goto sqlErr; }
	sqlStatus = sqlite3_step(stmt);
	if(sqlStatus != SQLITE_OK && sqlStatus != SQLITE_DONE) { goto sqlErr; }
	
	goto fnExit;
	sqlErr:
		sprintf(errMsg,"sqlite3 Error: %d \nThere was an error updating daily",sqlStatus);
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


static void _setActiveDaysDefault(struct SHActiveDaysValues *activeDays) {
		activeDays->intervalType = SH_WEEKLY_INTERVAL;
		activeDays->dayIntevalSize = 1;
		activeDays->daySkipIntevalSize = 1;
		activeDays->weekIntervalHash = SH_FULL_WEEK_HASH;
		activeDays->weekSkipIntervalHash = 0;
		activeDays->weekIntervalSize = 1;
		activeDays->weekSkipIntervalSize = 1;
		activeDays->monthIntervalHash = SH_FULL_MONTH_HASH;
		activeDays->monthSkipIntervalHash = 0;
		activeDays->monthIntervalSize = 1;
		activeDays->monthSkipIntervalSize = 1;
		memset(activeDays->yearIntervalHash, 0xff, SH_YEAR_HASH_BYTE_COUNT);
		memset(activeDays->yearSkipIntervalHash, 0, SH_YEAR_HASH_BYTE_COUNT);
		activeDays->yearIntervalSize = 1;
		activeDays->yearSkipIntervalSize = 1;
}


static SHErrorCode _setDailyValues(sqlite3_stmt *stmt, struct SHDaily *daily) {
	
	SHErrorCode status = SH_NO_ERROR;
	memset(daily, 0, sizeof(struct SHDaily));
	daily->base.pk = sqlite3_column_int(stmt, 0);
	if((status = SH_sqlite3_copy_column_text(stmt, 1, &daily->base.name)) != SH_NO_ERROR) { return status; }
	daily->base.lastUpdated = sqlite3_column_double(stmt, 2);
	if((status = SH_sqlite3_column_double_ptr(stmt,3, &daily->activeFromDateTime)) != SH_NO_ERROR) {
		goto cleanup;
	}
	if((status = SH_sqlite3_column_double_ptr(stmt,4, &daily->activeToDateTime)) != SH_NO_ERROR) {
		goto cleanup;
	}
	daily->activeFromHasPriority = sqlite3_column_int(stmt, 5);
	daily->isEnabled = sqlite3_column_int(stmt, 6);
	daily->lastUpdateHasPriority = sqlite3_column_int(stmt, 7);
	if((status = SH_sqlite3_copy_column_text(stmt, 8, &daily->note)) != SH_NO_ERROR) {
		goto cleanup;
	}
	daily->customUseOrder = sqlite3_column_int(stmt, 9);
	daily->dayStartTime = sqlite3_column_int(stmt, 10);
	daily->difficulty = sqlite3_column_int(stmt, 11);
	daily->urgency = sqlite3_column_int(stmt, 12);
	daily->base.tzOffsetLastUpdateDateTime = sqlite3_column_int(stmt, 13);
	if(sqlite3_column_type(stmt, 14) != SQLITE_NULL) {
		if((status = SH_sqlite3_copy_column_blobFixed(stmt, 14, &daily->activeDays, sizeof(struct SHActiveDaysValues)))
			!= SH_NO_ERROR)
		{
			goto cleanup;
		}
	}
	else {
		_setActiveDaysDefault(&daily->activeDays);
	}
	daily->stepCountMax = sqlite3_column_int(stmt, 15);
	daily->difficulty = daily->difficulty > 0 ? daily->difficulty : 3;
	daily->urgency = daily->urgency > 0 ? daily->urgency : 3;
	return SH_NO_ERROR;
	cleanup:
		free(daily->note);
		free(daily->activeToDateTime);
		free(daily->activeFromDateTime);
		free(daily->base.name);
		SH_notifyOfError(status, "Issue while loading fetched values into daily");
		return status;
}



static SHErrorCode _setTableDailyValues(sqlite3_stmt *stmt, struct SHTableDaily *tableDaily) {
	SHErrorCode status = SH_NO_ERROR;
	tableDaily->pk = sqlite3_column_int(stmt, 0);
	tableDaily->streakLength = sqlite3_column_int(stmt, 1);
	tableDaily->maxStreak = sqlite3_column_int(stmt, 2);
	tableDaily->dailyXp = sqlite3_column_int(stmt, 3);
	
	if(!(tableDaily->stepLastActivationDateTime = malloc(sizeof(struct SHDatetime)))) goto cleanup;
	if(!(tableDaily->savedUseDate = malloc(sizeof(struct SHDatetime)))) goto cleanup;
	if(!(tableDaily->nextDueDate = malloc(sizeof(struct SHDatetime)))) goto cleanup;
	if(!(tableDaily->fullLastActivationDateTime = malloc(sizeof(struct SHDatetime)))) goto cleanup;
	
	int32_t tzOffsetStepLastActivation = sqlite3_column_int(stmt, 5); //skip a number on purpose
	if((status = SH_sqlite3_column_SHDatetime(stmt, 4, tableDaily->stepLastActivationDateTime,
		tzOffsetStepLastActivation))
			!= SH_NO_ERROR)
	{
		goto cleanup;
	}
	
	int32_t tzOffsetFullLastActivation = sqlite3_column_int(stmt, 7); //skip a number on purpose
	if((status = SH_sqlite3_column_SHDatetime(stmt, 6, tableDaily->fullLastActivationDateTime,
		tzOffsetFullLastActivation))
			!= SH_NO_ERROR)
	{
		goto cleanup;
	}
	tableDaily->stepCount = sqlite3_column_int(stmt, 8);
	if((status = SH_sqlite3_column_SHDatetime(stmt, 9, tableDaily->savedUseDate, 0)) != SH_NO_ERROR) {
		goto cleanup;
	}
	tableDaily->dailyLvl = sqlite3_column_int(stmt, 10);
	if((status = SH_sqlite3_copy_column_text(stmt, 11, &tableDaily->name)) != SH_NO_ERROR) { goto cleanup; }
	
	if((status = SH_sqlite3_column_SHDatetime(stmt, 12, tableDaily->nextDueDate, 0)) != SH_NO_ERROR) {
		goto cleanup;
	}
	tableDaily->dueStatus = sqlite3_column_int(stmt, 13);
	tableDaily->stepCountMax = sqlite3_column_int(stmt, 14);
	goto fnExit;
	cleanup:
		SH_cleanupTableDaily(tableDaily);
	fnExit:
		return status;
}


SHErrorCode SH_fetchSingleDaily(sqlite3 *db, int64_t pk, struct SHDaily *daily) {
	if(!db || !daily) return SH_ILLEGAL_INPUTS;
	int32_t sqlStatus = SQLITE_OK;
	SHErrorCode status = SH_NO_ERROR;
	sqlite3_stmt *stmt = NULL;
	char errMsg[60];
	if((status = SH_buildStatement_fetchSingleDaily(&stmt, db)) != SH_NO_ERROR) { goto shErr; }
	if((sqlStatus = sqlite3_bind_int64(stmt, 1, pk)) != SQLITE_OK) { goto sqlErr; }
	sqlStatus = sqlite3_step(stmt);
	if(sqlStatus != SQLITE_ROW && sqlStatus != SQLITE_DONE) { goto sqlErr; }
	if((status = _setDailyValues(stmt, daily)) != SH_NO_ERROR) { goto shErr; }
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


static void *_tableDailyFetchGenFn(sqlite3_stmt *stmt, bool *hasNext) {
	int32_t sqlStatus = SQLITE_OK;
	SHErrorCode status = SH_NO_ERROR;
	struct SHTableDaily *tableDaily = NULL;
	sqlStatus = sqlite3_step(stmt);
	if(sqlStatus != SQLITE_OK && sqlStatus != SQLITE_ROW && sqlStatus != SQLITE_DONE) goto errExit;
	if(sqlStatus == SQLITE_DONE) {
		*hasNext = false;
	}
	tableDaily = malloc(sizeof(struct SHTableDaily));
	if(!tableDaily) goto allocFail;
	if((status = _setTableDailyValues(stmt, tableDaily)) != SH_NO_ERROR) { goto cleanup; }
	
	return tableDaily;
	allocFail:
		SH_notifyOfError(SH_ALLOC_NO_MEM, "Failed to alloc additional memory in _tableDailyFetchGenFn");
	cleanup:
		SH_notifyOfError(status, "Error after setting table values _tableDailyFetchGenFn");
		SH_cleanupTableDaily(tableDaily);
	errExit:
		return NULL;
}


SHErrorCode SH_fetchTableDailies(struct SHModelsQueueStore *queueStoreItem)
{
	if(!queueStoreItem || !queueStoreItem->dateProvider || !queueStoreItem->dateProvider->getDate) {
		return SH_ILLEGAL_INPUTS;
	}
	
	SHErrorCode status = SH_NO_ERROR;
	int32_t sqlStatus = SQLITE_OK;
	sqlite3_stmt *stmt = NULL;
	const struct SHDatetimeProvider *dateProvider = queueStoreItem->dateProvider;
	struct SHDatetime *dt = dateProvider->getDate();
	char errMsg[70];
	struct SHPipeline *pipeline = NULL;
	struct SHIterableWrapper *iterable = NULL;
	if((status = SH_buildStatement_fetchAllTableDailies(&stmt, queueStoreItem->db)) != SH_NO_ERROR) { goto sqlErr; }
	int32_t localTzOffset = dateProvider && dateProvider->getLocalTzOffset ? dateProvider->getLocalTzOffset() : 0;
	if((sqlStatus = sqlite3_bind_int(stmt, 1, localTzOffset)) != SQLITE_OK) { goto shErr; }
	if((sqlStatus = SH_sqlite3_bind_datetime(stmt, 2, dt)) != SQLITE_OK) { goto shErr; }
	
	pipeline = SH_pipeline_useGrouping(
		SH_pipeline_init(stmt,
			(void *(*)(void*, bool *))_tableDailyFetchGenFn,
			(void (*)(void*))sqlite3_finalize, (void (*)(void*))SH_cleanupTableDaily),
		(void *(*)(void*, void*, uint64_t))SH_tableDailiesGrouper, NULL, NULL,
		&SH_TREE_FN_DEFS, (int32_t (*)(void*, void*))SH_tableDailySortingFn, NULL);
	if(!pipeline) goto allocErr;
	iterable = SH_pipeline_completeAsIterable(pipeline, &SH_ARRAY_FN_DEFS, NULL);
	if(!iterable) goto allocErr;
	queueStoreItem->dailyStorage = iterable;
	goto fnExit;
	allocErr:
		status |= SH_ALLOC_NO_MEM;
		SH_notifyOfError(status, "Failed to allocate memory in SH_fetchTableDailies");
		goto cleanup;
	sqlErr:
		sprintf(errMsg,"sqlite3 Error: %d \nThere was an error fetching daily",sqlStatus);
		SH_notifyOfError(SH_SQLITE3_ERROR, errMsg);
		status |= SH_SQLITE3_ERROR;
		goto fnExit;
	shErr:
		SH_notifyOfError(SH_SQLITE3_ERROR, "Something happened while binding");
		goto cleanup;
	cleanup:
		SH_pipeline_cleanup(pipeline);
		sqlite3_finalize(stmt);
	fnExit:
		SH_freeSHDatetime(dt);
		return status;
}
