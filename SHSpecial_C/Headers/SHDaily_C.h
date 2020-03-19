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




void sh_fillWeek(int64_t *daysAheadCounts,int64_t *daysBeforeCounts,bool *activeDays,SHRateValueItem *rvi);
void sh_buildWeek(bool *activeDays,int64_t scaler,SHRateValueItem *rvi);
void sh_buildEmptyWeek(SHRateValueItem *rvi);
bool sh_previousDueDate_WEEKLY(SHDatetime *lastDueDate,SHDatetime *checkinDate,SHRateValueItem *rvi
	,int64_t scaler,int64_t dayStartHour,SHDatetime *ans,SHError *error);
	
bool sh_previousDueDateWithPreparedInputs_WEEKLY(SHDatetime *lastDueDate,SHDatetime *checkinDate
,SHRateValueItem *rvi,int64_t scaler, int64_t dayStartHour,SHDatetime *ans,SHError *error);

SHDatetime* sh_bothWeeklyDueDatesFromLastDueDate(SHDatetime* lastDueDate,SHDatetime* checkinDate
	,SHRateValueItem* week, int64_t scaler, int64_t dayStartHour,SHError *error);

bool sh_nextDueDate_WEEKLY(SHDatetime* lastDueDate,SHDatetime* checkinDate, SHRateValueItem* week,
	int64_t scaler, int64_t dayStartHour, SHDatetime *ans,SHError* error);

bool sh_isDateADueDate_WEEKLY(SHDatetime *lastDueDate,SHDatetime *checkinDate
,SHRateValueItem *rvi,int64_t scaler, int64_t dayStartHour,SHError *error);
	
int64_t sh_calcDaysAgoDayWasActive(int32_t weekdayIdx, int64_t scaler);

/*
 activeDays: an array of exactly 7 elements.
 scaler: this is the frequency, ex: event happens every 3 weeks
 rvi: this should be an array of 7 elements. Any values in this will get over written
 void buildWeek(bool *activeDays,int64_t scaler,RateValueItem *rvi)
 */
#endif /* SHDaily_C_h */
