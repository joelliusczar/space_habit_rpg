//
//  SHWeeklyIntervalItermFunctions.c
//  SHSpecial_C
//
//  Created by Joel Pridgen on 4/21/20.
//  Copyright © 2020 Joel Gillette. All rights reserved.
//

#include "SHWeekIntervalPointsFuncs.h"
#include "SHUtilConstants.h"
#include <assert.h>


int32_t SH_findPrevActiveDayIdx(struct SHWeekIntervalPointList const * intervalPoints, int32_t weekdayIdx) {
	if(!intervalPoints || weekdayIdx < 0 || weekdayIdx > SH_DAYS_IN_WEEK) return SH_NOT_FOUND;
	for(int32_t idx = weekdayIdx - 1; idx >= 0; idx--) {
		if(intervalPoints->days[idx].isDayActive) {
			return idx;
		}
	}
	for(int32_t idx = SH_DAYS_IN_WEEK - 1; idx > weekdayIdx; idx--) {
		if(intervalPoints->days[idx].isDayActive) {
			return idx;
		}
	}
	if(intervalPoints->days[weekdayIdx].isDayActive) {
		return weekdayIdx;
	}
	return SH_NOT_FOUND;
}


int32_t SH_activeDaysCountInRange(struct SHWeekIntervalPointList const * intervalPoints, int32_t startIdx,
	int32_t len)
{
	if(startIdx < 0 || startIdx + len > SH_DAYS_IN_WEEK) return SH_NOT_FOUND;
	int32_t count = 0;
	for(int32_t idx = startIdx; idx < startIdx + len; idx++) {
		if(intervalPoints->days[idx].isDayActive) count++;
	}
	return count;
}


int32_t SH_formatStrIntervalPoint(struct SHWeekIntervalPoint const * intervalPoint, char *str) {
	return sprintf(str,"isDayActive? %s forrange: %d backrange: %d",
		(intervalPoint->isDayActive ? "Yes": "No"),
		intervalPoint->forrange, intervalPoint->backrange);
}


void SH_loadWeekIntervalPointsFromHash(int32_t bitHash, struct SHWeekIntervalPointList * intervalPoints) {
	assert(intervalPoints);
	int32_t mask = 1;
	for(int32_t idx = 0; idx < SH_DAYS_IN_WEEK; idx++) {
		mask <<= idx;
		if(bitHash & mask) {
			intervalPoints->days[idx].isDayActive = true;
		}
		else {
			intervalPoints->days[idx].isDayActive = false;
		}
	}
}
