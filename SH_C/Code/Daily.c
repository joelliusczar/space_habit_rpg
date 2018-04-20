//
//  Daily_c.c
//  SHModels
//
//  Created by Joel Pridgen on 4/17/18.
//  Copyright © 2018 Joel Gillette. All rights reserved.
//

#include "Daily.h"
#include "DTConstants.h"
#include "SHArray.h"

MAKE_FIND_IDX_REV(char,bool,*,*)


void filWeek(int *daysAheadCounts,int *daysBeforeCounts,bool *activeDays
             ,RateValueItem *rvi){
    for(int dayIdx = 0;dayIdx < WEEKLEN;dayIdx++){
        rvi[0].forrange = daysAheadCounts[dayIdx];
        rvi[0].backrange = daysBeforeCounts[dayIdx];
        rvi[0].isDayActive = activeDays[dayIdx];
    }
}
#pragma GCC diagnostic push
#pragma GCC diagnostic ignored "-Wunused-parameter"

static bool isDayActive(char *day,long idx,bool *activeDays){
    return activeDays[idx];
}

#pragma GCC diagnostic pop

static void setDayCounts(int *daysCounts,bool *activeDays,int counter,bool isReverse){
    for(int dayIdx = 0;dayIdx < WEEKLEN;dayIdx++){
        int useIdx = isReverse?WEEKLEN -dayIdx -1:dayIdx;
        counter++;
        daysCounts[useIdx] = counter;
        if(activeDays[useIdx]){
            counter = 0;
        }
    }
}


void buildWeek(bool *activeDays,int scaler,RateValueItem *rvi){
    long lastIdx = findIdxRev(char,bool)(WEEKDAYS,WEEKLEN,&isDayActive);
    if(lastIdx == NOT_FOUND){
        buildEmptyWeek(rvi);
        return;
    }
    long daysBefore = (WEEKLEN - lastIdx) + (scaler -1)*WEEKLEN -1;
}

void buildEmptyWeek(RateValueItem *rvi){
    for(int i = 0;i < WEEKLEN;i++){
        rvi[i].forrange = 0;
        rvi[i].backrange = 0;
        rvi[i].isDayActive = false;
    }
}
