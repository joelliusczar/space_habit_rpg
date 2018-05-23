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
#include "SHDatetime.h"

typedef struct {
    bool isDayActive;
    long backrange;
    long forrange;
} RateValueItem;

void filWeek(long *daysAheadCounts,long *daysBeforeCounts,bool *activeDays
  ,RateValueItem *rvi);
void buildWeek(bool *activeDays,long scaler,RateValueItem *rvi);
void buildEmptyWeek(RateValueItem *rvi);
bool previousDueDate_WEEKLY(SHDatetime *lastDueDate,SHDatetime *checkinDate
  ,RateValueItem *rvi,long scaler,SHDatetime *ans,int *error);
#endif /* Daily_h */
