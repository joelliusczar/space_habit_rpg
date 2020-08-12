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
#include "SHDatetime_struct.h"
#include "SHDueDateWeeklyContext_struct.h"
#include "SHWeekIntervalPointsFuncs.h"
#include "SHActiveDaysConstants.h"
#include "SHDueDatesWeeklyFuncs.h"
#include "SHUtilConstants.h"
#include "SHDateCompare.h"
#include "SHActiveDaysValues.h"
#include "SHIntervalTypeHelper.h"
#include <sqlite3.h>
#include <inttypes.h>
#include <stdbool.h>
#include <stdlib.h>

static const int32_t _BIT_HASH_IDX = 0;
static const int32_t _USE_DATE_IDX = 1;
static const int32_t _SAVED_PREV_DATE_IDX = 2;
static const int32_t _LOCAL_TZ_OFFSET_IDX = 3;


static SHErrorCode _setupDueDateWeeklyContext(sqlite3_context* context, struct SHActiveDaysValues *activeDays,
	sqlite3_value** values, struct SHDueDateWeeklyContext *dueDateContext)
{
	SHErrorCode status = SH_NO_ERROR;
	struct SHDatetime savedPrevDate;
	SHIntervalType baseIntervalType = SH_extractBaseIntervalType(activeDays->intervalType);
	int32_t bitHash = baseIntervalType & SH_INVERSE_INTERVAL_MODIFIER ?
		activeDays->weekSkipIntervalHash : activeDays->weekIntervalHash;;
	int32_t intervalSize = baseIntervalType & SH_INVERSE_INTERVAL_MODIFIER ?
		activeDays->weekSkipIntervalSize : activeDays->weekIntervalSize;
	int32_t dayStartHour = 0;
	int32_t weekStartOffset = 0;
	struct SHWeekIntervalPointList intervalPoints;
	//expect timezone to already be compensated for
	if((status = SH_sqlite3_value_SHDatetime(values[_SAVED_PREV_DATE_IDX], &savedPrevDate, 0)) != SH_NO_ERROR) {
		return status;
	}
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
		.intervalPoints = &intervalPoints,
		.intervalSize = intervalSize,
		.dayStartHour = dayStartHour,
		.weekStartOffset = weekStartOffset
	};
	return status;
}



void SH_db_nextDueDate(sqlite3_context* context, int argc, sqlite3_value** values) {
	(void)argc;
	SHErrorCode status = SH_NO_ERROR;
	double nextDueDateTimestamp = 0;
	char msg[80];
	struct SHDatetime nextDueDate;
	struct SHDatetime useDate;
	struct SHDueDateWeeklyContext dueDateContext;
	struct SHActiveDaysValues activeDays;
	if((status = SH_sqlite3_copy_value_blobFixed(values[_BIT_HASH_IDX], &activeDays, sizeof(struct SHActiveDaysValues)))
		!= SH_NO_ERROR) { goto fnErr; }
	int32_t localTzOffset = sqlite3_value_int(values[_LOCAL_TZ_OFFSET_IDX]);
	if((status = SH_sqlite3_value_SHDatetime(values[_USE_DATE_IDX],&useDate, localTzOffset)) != SH_NO_ERROR) {
		goto fnErr;
	}

	if(SH_DAILY_INTERVAL & activeDays.intervalType) {
		status |= SH_LOGIC_MISROUTE;
		goto fnErr;
	}
	if(SH_WEEKLY_INTERVAL & activeDays.intervalType) {
		if((status = _setupDueDateWeeklyContext(context, &activeDays, values, &dueDateContext)) != SH_NO_ERROR) {
			goto fnErr;
		}
		if((status = SH_nextDueDate_WEEKLY(&useDate, &dueDateContext, &nextDueDate)) != SH_NO_ERROR) {
			goto fnErr;
		}
	}
	status = SH_dtToTimestamp(&nextDueDate, &nextDueDateTimestamp);
	
	sqlite3_result_double(context, nextDueDateTimestamp);
	return;
	fnErr:
		sprintf(msg, "error while calculating next due date for daily\nsh_error_code: %d\n", status);
		sqlite3_result_error(context, msg, -1);
}



static SHErrorCode _isDateActive(sqlite3_context* context, sqlite3_value** values,
	bool *ans)
{
	SHErrorCode status = SH_NO_ERROR;
	struct SHActiveDaysValues activeDays;
	struct SHDatetime useDate;
	struct SHDatetime savedPrevDate;
	int32_t localTzOffset = sqlite3_value_int(values[_LOCAL_TZ_OFFSET_IDX]);
	if((status = SH_sqlite3_value_SHDatetime(values[_USE_DATE_IDX], &useDate, localTzOffset)) != SH_NO_ERROR) {
		return status;
	}
	if((status = SH_sqlite3_copy_value_blobFixed(values[_BIT_HASH_IDX], &activeDays, sizeof(struct SHActiveDaysValues)))
		!= SH_NO_ERROR) { return status; }
		
	//expect timezone to already be compensated for
	if((status = SH_sqlite3_value_SHDatetime(values[_SAVED_PREV_DATE_IDX], &savedPrevDate, 0)) != SH_NO_ERROR) {
		return status;
	}
	if(SH_DAILY_INTERVAL & activeDays.intervalType) {
		return SH_LOGIC_MISROUTE;
	}
	if(SH_WEEKLY_INTERVAL & activeDays.intervalType) {
		
		struct SHDueDateWeeklyContext dueDateContext;
		if((status = _setupDueDateWeeklyContext(context, &activeDays, values, &dueDateContext)) != SH_NO_ERROR) {
			return status;
		}
		status = SH_isDateADueDate_WEEKLY(&useDate, &dueDateContext, ans);
		return status;
	}
	else {
		return SH_LOGIC_MISROUTE;
	}
}


void SH_db_isDateActive(sqlite3_context* context, int argc, sqlite3_value** values) {
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


static SHErrorCode _missedDays(sqlite3_context* context, sqlite3_value** values,
	int64_t *missedDays)
{
	SHErrorCode status = SH_NO_ERROR;
	struct SHDatetime useDate;
	int32_t localTzOffset = sqlite3_value_int(values[_LOCAL_TZ_OFFSET_IDX]);
	if((status = SH_sqlite3_value_SHDatetime(values[_USE_DATE_IDX], &useDate, localTzOffset)) != SH_NO_ERROR) {
		return status;
	}
	struct SHActiveDaysValues activeDays;
	if((status = SH_sqlite3_copy_value_blobFixed(values[_BIT_HASH_IDX], &activeDays, sizeof(struct SHActiveDaysValues)))
		!= SH_NO_ERROR)
	{
		return status;
	}
	if(SH_DAILY_INTERVAL & activeDays.intervalType) {
		return SH_LOGIC_MISROUTE;
	}
	if(SH_WEEKLY_INTERVAL & activeDays.intervalType){
		
		struct SHDueDateWeeklyContext dueDateContext;
		if((status = _setupDueDateWeeklyContext(context, &activeDays, values, &dueDateContext)) != SH_NO_ERROR) {
			return status;
		}
		status = SH_missedDays_WEEKLY(&useDate, &dueDateContext, missedDays);
		return status;
	}
	else {
		return SH_LOGIC_MISROUTE;
	}
}


void SH_db_missedDays(sqlite3_context* context, int argc, sqlite3_value** values) {
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


void SH_db_penalty(sqlite3_context* context,int argc, sqlite3_value** values) {
	(void)argc;
	int64_t missedDays = SH_NOT_FOUND;
	SHErrorCode status = SH_NO_ERROR;
	char msg[70];
	if((status = _missedDays(context, values, &missedDays)) != SH_NO_ERROR) { goto fnErr; }
	int32_t urgency = sqlite3_value_int(values[4]);
	int32_t difficulty = sqlite3_value_int(values[5]);
	double monsterAtkMod = sqlite3_value_double(values[6]);
	double heroDefMod = sqlite3_value_double(values[7]);
	double result = ((((urgency * difficulty) + 1) * monsterAtkMod) - heroDefMod) * missedDays ;
	sqlite3_result_int64(context, (int64_t)result);
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


void SH_db_selectSavedUseDate(sqlite3_context* context, int argc, sqlite3_value** values) {
	(void)argc;
	SHErrorCode status = SH_NO_ERROR;
	double selectedTimestamp = 0;
	if((status = _selectSavedUseDate(context, values, &selectedTimestamp)) != SH_NO_ERROR) { goto fnExit; }
	sqlite3_result_double(context, selectedTimestamp);
	
	fnExit:
		return;
}


void SH_db_getDueStatus(sqlite3_context* context, int argc, sqlite3_value** values) {
	(void)argc;
	bool isTodayActive = false;
	SHErrorCode status = SH_NO_ERROR;
	char msg[70];
	if((status = _isDateActive(context, values, &isTodayActive)) != SH_NO_ERROR) { goto fnErr; }
	struct SHDatetime useDate;
	struct SHDatetime savedPrevDate;
	int32_t localTzOffset = sqlite3_value_int(values[_LOCAL_TZ_OFFSET_IDX]);
	if((status = SH_sqlite3_value_SHDatetime(values[_USE_DATE_IDX],&useDate, localTzOffset)) != SH_NO_ERROR) {
		goto fnErr;
	}
	if((status = SH_sqlite3_value_SHDatetime(values[_SAVED_PREV_DATE_IDX], &savedPrevDate, 0)) != SH_NO_ERROR) {
		goto fnErr;
	}
	bool isPossiblyDue = false;
	SH_isDateXBeforeDateY(&savedPrevDate, &useDate, &isPossiblyDue);
	if(isPossiblyDue) {
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
