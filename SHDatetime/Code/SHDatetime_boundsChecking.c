//
//  SHDatetime_boundsChecking.c
//  SHDatetime
//
//  Created by Joel Pridgen on 5/1/20.
//  Copyright © 2020 Joel Gillette. All rights reserved.
//

#include "SHDatetime_boundsChecking.h"
#include "SHDTConstants.h"
#include "SHLeapYearFuncs.h"
#include "SHDayCounts.h"
#include <float.h>


SHErrorCode SH_isTimestampRangeInvalid(double timestamp, int32_t timezoneOffset) {
	SHErrorCode status = SH_NO_ERROR;
	if(timestamp < 0 && (SH_YEAR_ZERO_FIRST_SEC - timestamp) > -1 * timezoneOffset){
		SH_notifyOfError(SH_OUT_OF_RANGE,"timestamp is earlier than earliest date");
		status = SH_OUT_OF_RANGE;
		goto cleanup;
	}
	if(timestamp > 0 && (DBL_MAX - timestamp) < timezoneOffset){
		SH_notifyOfError(SH_OUT_OF_RANGE,"timestamp is later than max date");
		status = SH_OUT_OF_RANGE;
		goto cleanup;
	}
cleanup:
	return status;
}


bool SH_areTimeComponentsValid(struct SHDatetime const *dt){
	shLog("SH__areTimeComponentsValid");
	bool isValid = (dt->year >= 0 && dt->year <= 9999);
	isValid &= (dt->hour >= 0 && dt->hour < 24);
	isValid &= (dt->minute >= 0 && dt->minute < 60);
	isValid &= (dt->second >= 0 && dt->second < 60);
	isValid &= (dt->month > 0 && dt->month < 13);
	if(!isValid) return isValid;
	bool isLeapYear = SH_isLeapYear(dt->year);
	isValid &= (dt->day > 0 && dt->day <= (SH_monthCount[dt->month-1] + (isLeapYear && dt->month == 2 ? 1: 0)));
	shLog("leaving SH__areTimeComponentsValid");
	return isValid;
}
