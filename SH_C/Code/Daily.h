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

typedef struct {
    bool isDayActive;
    int backrange;
    int forrange;
} RateValueItem;

void filWeek(int *daysAheadCounts,int *daysBeforeCounts,bool *activeDays
  ,RateValueItem *rvi);
void buildWeek(bool *activeDays,int scaler,RateValueItem *rvi);
void buildEmptyWeek(RateValueItem *rvi);
#endif /* Daily_h */
