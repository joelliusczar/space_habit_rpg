//
//  SHDaily_c.h
//  SHModels
//
//  Created by Joel Pridgen on 4/17/18.
//  Copyright © 2018 Joel Gillette. All rights reserved.
//

#ifndef SHDaily_C_h
#define SHDaily_C_h

#include <stdio.h>
#include <stdbool.h>
#include <inttypes.h>
#include "SHDatetime.h"
#include "SHErrorHandling.h"
#include "SHRateValueItem.h"




void shFillWeek(int64_t *daysAheadCounts,int64_t *daysBeforeCounts,bool *activeDays,SHRateValueItem *rvi);
void shBuildWeek(bool *activeDays,int64_t scaler,SHRateValueItem *rvi);
void shBuildEmptyWeek(SHRateValueItem *rvi);
bool shPreviousDueDate_WEEKLY(SHDatetime *lastDueDate,SHDatetime *checkinDate,SHRateValueItem *rvi
,int64_t scaler,SHDatetime *ans,SHError *error);

SHDatetime* shBothWeeklyDueDatesFromLastDueDate(SHDatetime* lastDueDate,SHDatetime* checkinDate
,SHRateValueItem* week,int64_t scaler,SHError *error);

bool shNextDueDate_WEEKLY(SHDatetime* lastDueDate,SHDatetime* checkinDate, SHRateValueItem* week,int64_t scaler
,SHDatetime *ans,SHError* error);

bool shNextDueDate_WEEKLY_INV(SHDatetime* lastDueDate,SHDatetime* checkinDate, SHRateValueItem* week,int64_t scaler
,SHDatetime *ans,SHError* error);

bool shIsDateADueDate(SHDatetime* previousDueDate,SHDatetime* checkinDate, SHRateValueItem* week,int64_t scaler
,SHError *error);

/*
 activeDays: an array of exactly 7 elements.
 scaler: this is the frequency, ex: event happens every 3 weeks
 rvi: this should be an array of 7 elements. Any values in this will get over written
 void buildWeek(bool *activeDays,int64_t scaler,RateValueItem *rvi)
 */
#endif /* SHDaily_C_h */
