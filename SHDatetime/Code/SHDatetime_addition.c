//
//  SHDatetimeAddition.c
//  SHDatetime
//
//  Created by Joel Pridgen on 5/7/20.
//  Copyright © 2020 Joel Gillette. All rights reserved.
//

#include "SHDatetime_addition.h"
#include "SHDatetimeFuncs.h"
#include "SHUtilConstants.h"
#include "SHTimeZone.h"
#include "SHDayCounts.h"
#include "SHLeapYearFuncs.h"
#include <assert.h>


SHErrorCode SH_addDaysToDt(struct SHDatetime *dt, int64_t days, SHTimeAdjustOptions options){
	shLog("SH_addDaysToDt");
	(void)options;
	assert(dt);
	SHErrorCode status = SH_NO_ERROR;
	if(days == 0) goto success;
	double timestamp;
	if((status = SH_dtToTimestamp(dt, &timestamp)) != SH_NO_ERROR) {
		goto cleanup;
	}
	timestamp += (days * SH_DAY_IN_SECONDS);
	struct SHTimeshift *shifts = dt->shifts;
	int32_t shiftLen = dt->shiftLen;
	int32_t currentShiftIdx = dt->currentShiftIdx;
	SH_timestampToDt(timestamp, dt->timezoneOffset, dt);
	dt->shifts = shifts;
	dt->shiftLen = shiftLen;
	dt->currentShiftIdx = currentShiftIdx;
	shLog("almost leaving SH_addDaysToDt");
	status = SH_UpdateTimezoneForShifts(dt);
	success:
	cleanup:
		return status;
}


SHErrorCode SH_addMonthsToDt(struct SHDatetime *dt,int64_t months,SHTimeAdjustOptions options){
	assert(dt);
	SHErrorCode status = SH_NO_ERROR;
	if(months == 0) goto nochange;
	if(options == SH_TIME_ADJUST_NO_OPTION) options = SH_TIME_ADJUST_SHIFT_BKD;
	int64_t totalMonths = months + dt->month;
	int32_t exMonths = totalMonths % SH_YEAR_IN_MONTHS;
	int64_t years = totalMonths / SH_YEAR_IN_MONTHS;
	dt->month = exMonths;
	dt->year += years;
	int32_t monthLastDay = SH_monthCount[dt->month -1]
		+ (SH_isOffsettedYearCountLeap(dt->year) && dt->month == SH_FEB ? 1 : 0);
	if(dt->day > monthLastDay){
		if(options == SH_TIME_ADJUST_SHIFT_BKD){
			dt->day = monthLastDay;
		}
		else if(options == SH_TIME_ADJUST_SHIFT_FWD){
			dt->day = 1;
			dt->month++;
		}
	}
	status = SH_UpdateTimezoneForShifts(dt);
	dt->isTimestampValid = false;
	nochange:
		return status;
}


static SHErrorCode _addYears_SHIFT(struct SHDatetime *dt,int64_t years, SHTimeAdjustOptions options) {
	SHErrorCode status = SH_NO_ERROR;
	int64_t yearSum = years + dt->year;
	options = options == SH_TIME_ADJUST_NO_OPTION ? SH_TIME_ADJUST_SHIFT_BKD : options;
	if(options & SH_TIME_ADJUST_ERROR){
		if(!SH_isLeapYear(yearSum) && SH_isFeb29(dt)){
			SH_notifyOfError(SH_INPUT_BAD_RESULTS,"Date addition caused Feb 29 to happen on non leap year");
			status = SH_INPUT_BAD_RESULTS;
			goto cleanup;
		}
		dt->year = yearSum;
		goto success;
	}
	if((options & SH_TIME_ADJUST_SHIFT_BKD) || (options & SH_TIME_ADJUST_SHIFT_FWD)){
		if(!SH_isLeapYear(yearSum) && SH_isFeb29(dt)){
			if(options & SH_TIME_ADJUST_SHIFT_BKD) dt->day = 28;
			else if(options & SH_TIME_ADJUST_SHIFT_FWD){
				dt->day = 1;
				dt->month = 3;
			}
		}
		dt->year = yearSum;
		goto success;
	}
	SH_notifyOfError(SH_INPUT_BAD_RESULTS,"Invalid options");
	status = SH_INPUT_BAD_RESULTS;
	success:
		dt->isTimestampValid = false;
	cleanup:
		return status;
}


SHErrorCode SH_addYearsToDt(struct SHDatetime *dt, int64_t years, SHTimeAdjustOptions options){
	assert(dt);
	SHErrorCode status = SH_NO_ERROR;
	if(years == 0) goto success;
	if((options & (SH_TIME_ADJUST_SHIFT_BKD | SH_TIME_ADJUST_SHIFT_FWD)) || options == SH_TIME_ADJUST_NO_OPTION){
			return _addYears_SHIFT(dt, years, options);
	}
	if(options & SH_TIME_ADJUST_SIMPLE){
		double timestamp;
		if((status = SH_dtToTimestamp(dt, &timestamp)) != SH_NO_ERROR) {
			goto cleanup;
		}
		timestamp += years * SH_SECONDS_PER_YEAR;
		if((status = SH_timestampToDt(timestamp, dt->timezoneOffset, dt)) != SH_NO_ERROR) {
			goto cleanup;
		}
		
	}
	status = SH_ILLEGAL_INPUTS;
	success:
	cleanup:
		return status;
}
