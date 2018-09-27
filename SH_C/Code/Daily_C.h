//
//  Daily_c.h
//  SHModels
//
//  Created by Joel Pridgen on 4/17/18.
//  Copyright © 2018 Joel Gillette. All rights reserved.
//

#ifndef Daily_C_h
#define Daily_C_h

#include <stdio.h>
#include <stdbool.h>
#include <inttypes.h>
#include "SHDatetime.h"
#include "ErrorHandling.h"

typedef struct {
    bool isDayActive;
    int64_t backrange;
    int64_t forrange;
} RateValueItem;

void filWeek(int64_t *daysAheadCounts,int64_t *daysBeforeCounts,bool *activeDays
  ,RateValueItem *rvi);
void buildWeek(bool *activeDays,int64_t scaler,RateValueItem *rvi);
void buildEmptyWeek(RateValueItem *rvi);
bool previousDueDate_WEEKLY(SHDatetime *lastDueDate,SHDatetime *checkinDate
  ,RateValueItem *rvi,int64_t scaler,SHDatetime *ans,SHError *error);
SHDatetime* bothWeeklyDueDatesFromLastDueDate(SHDatetime* lastDueDate,SHDatetime* checkinDate
  ,RateValueItem* week,int64_t scaler,SHError *error);
bool nextDueDate_WEEKLY(SHDatetime* lastDueDate,SHDatetime* checkinDate
  , RateValueItem* week,int64_t scaler,SHDatetime *ans,SHError* error);

/*
 activeDays: an array of exactly 7 elements.
 scaler: this is the frequency, ex: event happens every 3 weeks
 rvi: this should be an array of 7 elements. Any values in this will get over written
 void buildWeek(bool *activeDays,int64_t scaler,RateValueItem *rvi)
 */
#endif /* Daily_C_h */
