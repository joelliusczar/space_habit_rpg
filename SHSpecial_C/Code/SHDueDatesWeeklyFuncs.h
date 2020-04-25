//
//	SHDaily_c.h
//	SHModels
//
//	Created by Joel Pridgen on 4/17/18.
//	Copyright © 2018 Joel Gillette. All rights reserved.
//

#ifndef SHDaily_C_h
#define SHDaily_C_h

#include <stdio.h>
#include <stdbool.h>
#include <inttypes.h>
#include "SHDatetimeFuncs.h"
#include "SHErrorHandling.h"
#include "SHWeekIntervalPoint.h"

struct SHDailyWeeklyDueDateInput {
	SHDatetime *prevUseDate;
	SHDatetime *useDate;
	SHWeekIntervalPoint *intervalPoints;
	int32_t intervalSize;
	int32_t dayStartHour;
	int32_t weekStartOffset;
};

typedef struct SHDailyWeeklyDueDateInput SHDailyWeeklyDueDateInput;


void SH_fillWeek(int32_t *daysAheadCounts, int32_t *daysBeforeCounts,
	SHWeekIntervalPoint *intervalPoints);

void SH_refreshWeek(SHWeekIntervalPoint *intervalPoints, int32_t intervalSize);

SHErrorCode SH_previousDueDate_WEEKLY(SHDailyWeeklyDueDateInput *input, SHDatetime *ans);

SHErrorCode SH_bothWeeklyDueDatesFromLastDueDate(SHDailyWeeklyDueDateInput *input, SHDatetime **ans, int32_t *ansLen);

SHErrorCode SH_nextDueDate_WEEKLY(SHDailyWeeklyDueDateInput *input, SHDatetime *ans);

SHErrorCode SH_isDateADueDate_WEEKLY(SHDailyWeeklyDueDateInput *input, bool *ans);

int32_t SH_calcDaysAgoDayWasActive(int32_t weekdayIdx, int32_t intervalSize);

SHErrorCode SH_backupDateForReferenceDate(SHDailyWeeklyDueDateInput *input, SHDatetime *ans);

SHErrorCode SH_isWeekActiveForDate(SHDailyWeeklyDueDateInput *input, bool *ans);

/*
 activeDays: an array of exactly 7 elements.
 intervalSize: this is the frequency, ex: event happens every 3 weeks
 intervalPoints: this should be an array of 7 elements. Any values in this will get over written
 void buildWeek(bool *activeDays,int64_t scaler,RateValueItem *intervalPoints)
 */
#endif /* SHDaily_C_h */
