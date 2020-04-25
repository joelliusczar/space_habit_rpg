//
//  SHWeeklyIntervalItermFunctions.c
//  SHSpecial_C
//
//  Created by Joel Pridgen on 4/21/20.
//  Copyright © 2020 Joel Gillette. All rights reserved.
//

#include "SHWeekIntervalPointsFuncs.h"
#include "SHUtils_C.h"
#include "SHDatetime.h"


int32_t SH_findPrevActiveDayIdx(SHWeekIntervalPoint const * intervalPoints, int32_t weekdayIdx) {
	if(!intervalPoints || weekdayIdx < 0 || weekdayIdx > SH_DAYS_IN_WEEK) return SH_NOT_FOUND;
	for(int32_t idx = weekdayIdx - 1; idx >= 0; idx--) {
		if(intervalPoints[idx].isDayActive) {
			return idx;
		}
	}
	for(int32_t idx = SH_DAYS_IN_WEEK - 1; idx > weekdayIdx; idx--) {
		if(intervalPoints[idx].isDayActive) {
			return idx;
		}
	}
	return SH_NOT_FOUND;
}


int32_t SH_activeDaysCountInRange(SHWeekIntervalPoint const * intervalPoints, int32_t startIdx, int32_t len) {
	if(startIdx < 0 || startIdx > SH_DAYS_IN_WEEK || len > SH_DAYS_IN_WEEK) return SH_NOT_FOUND;
	int32_t count = 0;
	for(int32_t idx = startIdx; idx < len; idx++) {
		if(intervalPoints[idx].isDayActive) count++;
	}
	return count;
}


int32_t SH_formatStrIntervalPoint(SHWeekIntervalPoint const * intervalPoint, char *str) {
	return sprintf(str,"isDayActive? %s forrange: %d backrange: %d",
		(intervalPoint->isDayActive ? "Yes": "No"),
		intervalPoint->forrange, intervalPoint->backrange);
}
