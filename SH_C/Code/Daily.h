//
//  Daily_c.h
//  SHModels
//
//  Created by Joel Pridgen on 4/17/18.
//  Copyright © 2018 Joel Gillette. All rights reserved.
//

#ifndef Daily_h
#define Daily_h

#include <stdio.h>
#include <stdbool.h>
#include <inttypes.h>
#include "SHDatetime.h"

typedef struct {
    bool isDayActive;
    long backrange;
    long forrange;
} RateValueItem;

void filWeek(int64_t *daysAheadCounts,int64_t *daysBeforeCounts,bool *activeDays
  ,RateValueItem *rvi);
void buildWeek(bool *activeDays,int64_t scaler,RateValueItem *rvi);
void buildEmptyWeek(RateValueItem *rvi);
bool previousDueDate_WEEKLY(SHDatetime *lastDueDate,SHDatetime *checkinDate
  ,RateValueItem *rvi,int64_t scaler,SHDatetime *ans,int *error);
#endif /* Daily_h */
