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
#include "SHRateValueItem.h"

struct SHDailyWeeklyDueDateInput {
	SHDatetime *lastDueDate;
	SHDatetime *checkinDate;
	SHRateValueItem *rvi;
	int64_t intervalSize;
	int64_t dayStartHour;
	int32_t weekStartOffset;
};

typedef struct SHDailyWeeklyDueDateInput SHDailyWeeklyDueDateInput;


void sh_fillWeek(int64_t *daysAheadCounts,int64_t *daysBeforeCounts,bool *activeDays,SHRateValueItem *rvi);

void sh_buildWeek(bool *activeDays,int64_t scaler,SHRateValueItem *rvi);

void sh_buildEmptyWeek(SHRateValueItem *rvi);

SHErrorCode SH_previousDueDate_WEEKLY(SHDailyWeeklyDueDateInput *input, SHDatetime *ans);

SHErrorCode SH_bothWeeklyDueDatesFromLastDueDate(SHDailyWeeklyDueDateInput *input, SHDatetime **ans, int32_t *ansLen);

SHErrorCode SH_nextDueDate_WEEKLY(SHDailyWeeklyDueDateInput *input, SHDatetime *ans);

SHErrorCode SH_isDateADueDate_WEEKLY(SHDailyWeeklyDueDateInput *input, bool *ans);

int64_t sh_calcDaysAgoDayWasActive(int32_t weekdayIdx, int64_t scaler);

/*
 activeDays: an array of exactly 7 elements.
 intervalSize: this is the frequency, ex: event happens every 3 weeks
 rvi: this should be an array of 7 elements. Any values in this will get over written
 void buildWeek(bool *activeDays,int64_t scaler,RateValueItem *rvi)
 */
#endif /* SHDaily_C_h */
