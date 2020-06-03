//
//  SHDaily_dbFuncs.c
//  SHModels
//
//  Created by Joel Pridgen on 5/28/20.
//  Copyright © 2020 Joel Gillette. All rights reserved.
//

#include "SHDaily_dbFuncs.h"
#include "SHSqlite3Extensions.h"
#include "SHConfigAccessor.h"
#include "SHHeroMonsterDbHelper.h"
#include "SHDatetime_struct.h"
#include "SHDueDateWeeklyContext_struct.h"
#include "SHWeekIntervalPointsFuncs.h"
#include "SHDBDueDateConstants.h"
#include "SHDueDatesWeeklyFuncs.h"
#include "SHUtilConstants.h"
#include "SHDateCompare.h"
#include <sqlite3.h>
#include <inttypes.h>
#include <stdbool.h>
#include <stdlib.h>

static const int32_t _INTERVAL_TYPE_IDX = 0;
static const int32_t _USE_DATE_IDX = 1;
static const int32_t _SAVED_PREV_DATE_IDX = 2;
static const int32_t _BIT_HASH_IDX = 3;
static const int32_t _INTERVAL_SIZE_IDX = 2;


static SHErrorCode _setupWeeklyDueDateContext(sqlite3_context* context, sqlite3_value** values,
	struct SHDueDateWeeklyContext *dueDateContext)
{
	SHErrorCode status = SH_NO_ERROR;
	struct SHDatetime savedPrevDate;
	int32_t bitHash = 0;
	int32_t intervalSize = 0;
	int32_t dayStartHour = 0;
	int32_t weekStartOffset = 0;
	struct SHWeekIntervalPointList intervalPoints;
	//expect timezone to already be compensated for
	if((status = SH_sqlite3_value_SHDatetime(values[_SAVED_PREV_DATE_IDX],&savedPrevDate, 0)) != SH_NO_ERROR) {
		return status;
	}
	bitHash = sqlite3_value_int(values[_BIT_HASH_IDX]);
	intervalSize = sqlite3_value_int(values[_INTERVAL_SIZE_IDX]);
	struct SHConfigAccessor *config = (struct SHConfigAccessor *)sqlite3_user_data(context);
	if(config) {
		if(config->getDayStartHour) {
			dayStartHour = config->getDayStartHour();
		}
		if(config->getWeekStartOffset) {
			weekStartOffset = config->getWeekStartOffset();
		}
	}
	SH_loadWeekIntervalPointsFromHash(bitHash, &intervalPoints);
	*dueDateContext = (struct SHDueDateWeeklyContext){
		.savedPrevDate = &savedPrevDate,
		.intervalPoints = &intervalPoints,
		.intervalSize = intervalSize,
		.dayStartHour = dayStartHour,
		.weekStartOffset = weekStartOffset
	};
	return status;
}


SHErrorCode _nextDueDate_WEEKLY(sqlite3_context* context, sqlite3_value** values,
	double *nextDueDateTimestamp)
{
	SHErrorCode status = SH_NO_ERROR;
	struct SHDatetime nextDueDate;
	struct SHDatetime useDate;
	struct SHDueDateWeeklyContext dueDateContext;
	if((status = SH_sqlite3_value_SHDatetime(values[_USE_DATE_IDX],&useDate, 0)) != SH_NO_ERROR) {
		return status;
	}
	if((status = _setupWeeklyDueDateContext(context, values, &dueDateContext)) != SH_NO_ERROR) {
		return status;
	}
	if((status = SH_nextDueDate_WEEKLY(&useDate, &dueDateContext, &nextDueDate)) != SH_NO_ERROR) {
		return status;
	}
	status = SH_dtToTimestamp(&nextDueDate, nextDueDateTimestamp);
	return status;
}


void SHDB_nextDueDate(sqlite3_context* context, int argc, sqlite3_value** values) {
	(void)argc;
	SHErrorCode status = SH_NO_ERROR;
	double nextDueDateTimestamp = 0;
	char msg[80];
	SHIntervalType intervalType = (SHIntervalType)sqlite3_value_int(values[_INTERVAL_TYPE_IDX]);
	if(SH_DAILY_INTERVAL & intervalType) {
		return;
	}
	if(SH_WEEKLY_INTERVAL & intervalType){
		if((status = _nextDueDate_WEEKLY(context, values, &nextDueDateTimestamp)) != SH_NO_ERROR) {
			goto fnErr;
		}
	}
	else {
		return;
	}
	
	sqlite3_result_double(context, nextDueDateTimestamp);
	return;
	fnErr:
		sprintf(msg, "error while calculating next due date for daily\nsh_error_code: %d\n", status);
		sqlite3_result_error(context, msg, -1);
}


static SHErrorCode _isDateActive_WEEKLY(sqlite3_context* context, sqlite3_value** values,
	bool *ans) {
	SHErrorCode status = SH_NO_ERROR;
	struct SHDatetime useDate;
	struct SHDueDateWeeklyContext dueDateContext;
		if((status = SH_sqlite3_value_SHDatetime(values[_USE_DATE_IDX], &useDate, 0)) != SH_NO_ERROR) {
			return status;
		}
		if((status = _setupWeeklyDueDateContext(context, values, &dueDateContext)) != SH_NO_ERROR) {
			return status;
		}
		status = SH_isDateADueDate_WEEKLY(&useDate, &dueDateContext, ans);
		return status;;
}


static SHErrorCode _isDateActive(sqlite3_context* context, sqlite3_value** values,
	bool *ans)
{
	SHIntervalType intervalType = (SHIntervalType)sqlite3_value_int(values[_INTERVAL_TYPE_IDX]);
	
	if(SH_DAILY_INTERVAL & intervalType) {
		return SH_LOGIC_MISROUTE;
	}
	if(SH_WEEKLY_INTERVAL & intervalType) {
		return _isDateActive_WEEKLY(context, values, ans);
	}
	else {
		return SH_LOGIC_MISROUTE;
	}
}


void SHDB_isDateActive(sqlite3_context* context, int argc, sqlite3_value** values) {
	(void)argc;
	SHErrorCode status = SH_NO_ERROR;
	bool ans = false;
	char msg[70];
	if((status = _isDateActive(context, values, &ans)) != SH_NO_ERROR) { goto fnErr; }
	sqlite3_result_int(context, ans);
	return;
	fnErr:
		sprintf(msg, "error while determining if daily is active\nsh_error_code: %d\n", status);
		sqlite3_result_error(context, msg, -1);
}


static SHErrorCode _missedDays_WEEKLY(sqlite3_context* context, sqlite3_value** values,
	int64_t *missedDays)
{
	struct SHDatetime useDate;
	SHErrorCode status = SH_NO_ERROR;
	if((status = SH_sqlite3_value_SHDatetime(values[_USE_DATE_IDX],&useDate, 0)) != SH_NO_ERROR) {
		return status;
	}
	struct SHDueDateWeeklyContext dueDateContext;
	if((status = _setupWeeklyDueDateContext(context, values, &dueDateContext)) != SH_NO_ERROR) {
		return status;
	}
	status = SH_missedDays_WEEKLY(&useDate, &dueDateContext, missedDays);
	return status;
}


static SHErrorCode _missedDays(sqlite3_context* context, sqlite3_value** values,
	int64_t *missedDays)
{
	SHIntervalType intervalType = (SHIntervalType)sqlite3_value_int(values[_INTERVAL_TYPE_IDX]);
	if(SH_DAILY_INTERVAL & intervalType) {
		return SH_LOGIC_MISROUTE;
	}
	if(SH_WEEKLY_INTERVAL & intervalType){
		return _missedDays_WEEKLY(context, values, missedDays);
	}
	else {
		return SH_LOGIC_MISROUTE;
	}
}


void SHDB_missedDays(sqlite3_context* context, int argc, sqlite3_value** values) {
	(void)argc;
	int64_t missedDays = SH_NOT_FOUND;
	SHErrorCode status = SH_NO_ERROR;
	char msg[70];
	if((status = _missedDays(context, values, &missedDays)) != SH_NO_ERROR) { goto fnErr; }
	sqlite3_result_int64(context, missedDays);
	return;
	fnErr:
		
		sprintf(msg, "error while getting number of missed days\nsh_error_code: %d\n", status);
		sqlite3_result_error(context, msg, 70);
}


void SHDB_penalty(sqlite3_context* context,int argc, sqlite3_value** values) {
	(void)argc;
	int64_t missedDays = SH_NOT_FOUND;
	SHErrorCode status = SH_NO_ERROR;
	char msg[70];
	if((status = _missedDays(context, values, &missedDays)) != SH_NO_ERROR) { goto fnErr; }
	int32_t urgency = sqlite3_value_int(values[5]);
	int32_t difficulty = sqlite3_value_int(values[6]);
	struct SHHeroMonsterDbHelper *heroMonster = (struct SHHeroMonsterDbHelper *)sqlite3_user_data(context);
	

	double result = 0;
	sqlite3_result_int64(context, (int32_t)result);
	return;
	fnErr:
		sprintf(msg, "error while calculating penalty\nsh_error_code: %d\n", status);
		sqlite3_result_error(context, msg, 70);
}


SHErrorCode _selectSavedUseDate(sqlite3_context* context, sqlite3_value** values,
	double *selectedTimestamp)
{
	(void)context;
	double *lastActivationDateTime = NULL;
	double *activeFromDateTime = NULL;
	double lastUpdateDateTime = 0;
	int32_t tzOffsetLastUpdateDateTime = 0;
	int32_t tzOffsetLastActivationDateTime = 0;
	bool activeFromHasPriority = false;
	bool lastUpdateHasPriority = false;
	SHErrorCode status = SH_NO_ERROR;
	if((status = SH_sqlite3_value_double_ptr(values[0], &lastActivationDateTime)) != SH_NO_ERROR) {
		goto fnExit;
	}
	tzOffsetLastActivationDateTime = sqlite3_value_int(values[1]);
	if((status = SH_sqlite3_value_double_ptr(values[2], &activeFromDateTime)) != SH_NO_ERROR) {
		goto fnExit;
	}
	tzOffsetLastUpdateDateTime = sqlite3_value_int(values[3]);
	lastUpdateDateTime = sqlite3_value_double(values[4]);
	activeFromHasPriority = (bool)sqlite3_value_int(values[5]);
	lastUpdateHasPriority = (bool)sqlite3_value_int(values[6]);
	if(lastActivationDateTime && !activeFromHasPriority && !lastUpdateHasPriority) {
		double timestamp = *lastActivationDateTime;
		timestamp -= tzOffsetLastActivationDateTime;
		*selectedTimestamp = timestamp;
		free(lastActivationDateTime);
		goto fnExit;
	}
	
	if(activeFromDateTime && !lastUpdateHasPriority) {
		double timestamp = *activeFromDateTime;
		//this may need its own tz property but tzOffsetLastUpdateDateTime is good alternative
		timestamp -= tzOffsetLastUpdateDateTime;
		*selectedTimestamp = timestamp;
		free(activeFromDateTime);
		goto fnExit;
	}
	lastUpdateDateTime -= tzOffsetLastUpdateDateTime;
	*selectedTimestamp = lastUpdateDateTime;
	fnExit:
		return status;
}


void SHDB_selectSavedUseDate(sqlite3_context* context, int argc, sqlite3_value** values) {
	(void)argc;
	SHErrorCode status = SH_NO_ERROR;
	double selectedTimestamp = 0;
	if((status = _selectSavedUseDate(context, values, &selectedTimestamp)) != SH_NO_ERROR) { goto fnExit; }
	sqlite3_result_double(context, selectedTimestamp);
	
	fnExit:
		return;
}


void SHDB_getDueStatus(sqlite3_context* context, int argc, sqlite3_value** values) {
	(void)argc;
	bool isTodayActive = false;
	SHErrorCode status = SH_NO_ERROR;
	char msg[70];
	if((status = _isDateActive(context, values, &isTodayActive)) != SH_NO_ERROR) { goto fnErr; }
	struct SHDatetime useDate;
	struct SHDatetime savedPrevDate;
	if((status = SH_sqlite3_value_SHDatetime(values[_USE_DATE_IDX],&useDate, 0)) != SH_NO_ERROR) {
		goto fnErr;
	}
	if((status = SH_sqlite3_value_SHDatetime(values[_SAVED_PREV_DATE_IDX], &savedPrevDate, 0)) != SH_NO_ERROR) {
		goto fnErr;
	}
	bool isDue = false;
	SH_isDateALTDateB(&savedPrevDate, &useDate, &isDue);
	if(isDue) {
		if(isTodayActive) {
			sqlite3_result_int(context, SH_IS_DUE);
		}
		sqlite3_result_int(context, SH_IS_NOT_DUE);
	}
	sqlite3_result_int(context, SH_IS_COMPLETED);
	fnErr:
		
		sprintf(msg, "error while determining due date status\nsh_error_code: %d\n", status);
		sqlite3_result_error(context, msg, -1);
}
