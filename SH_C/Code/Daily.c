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
#include "ErrorHandling.h"

DEF_FIND_IDX_REV(bool,int,,)
DEF_FIND_IDX(bool,int,,)


#pragma GCC diagnostic push
#pragma GCC diagnostic ignored "-Wunused-parameter"

static bool isDayActive(bool isActive,int64_t idx,int blank){
    return isActive;
}

#pragma GCC diagnostic pop

static void setDayCounts(int64_t *daysCounts,bool *activeDays,int64_t counter
  ,bool isReverse){
    for(int dayIdx = 0;dayIdx < WEEKLEN;dayIdx++){
        int useIdx = isReverse?WEEKLEN -dayIdx -1:dayIdx;
        counter++;
        daysCounts[useIdx] = counter;
        if(activeDays[useIdx]){
            counter = 0;
        }
    }
}


void filWeek(int64_t *daysAheadCounts,int64_t *daysBeforeCounts,bool *activeDays
             ,RateValueItem *rvi){
    for(int dayIdx = 0;dayIdx < WEEKLEN;dayIdx++){
        rvi[0].forrange = daysAheadCounts[dayIdx];
        rvi[0].backrange = daysBeforeCounts[dayIdx];
        rvi[0].isDayActive = activeDays[dayIdx];
    }
}


void buildWeek(bool *activeDays,int64_t scaler,RateValueItem *rvi){
    int64_t lastIdx = findIdxRev(bool,int)(activeDays,WEEKLEN,&isDayActive,0);
    if(lastIdx == NOT_FOUND){
        buildEmptyWeek(rvi);
        return;
    }
    int64_t daysBefore = (WEEKLEN - lastIdx) + (scaler -1)*WEEKLEN -1;
    int64_t daysBeforeCounts[WEEKLEN];
    setDayCounts(daysBeforeCounts,activeDays,daysBefore,false);
    int64_t firstIdx = findIdx(bool,int)(activeDays,WEEKLEN,&isDayActive,0);
    int64_t daysAhead = firstIdx + (scaler -1)*WEEKLEN;
    int64_t daysAheadCounts[WEEKLEN];
    setDayCounts(daysAheadCounts,activeDays,daysAhead,true);
    
    return filWeek(daysAheadCounts,daysBeforeCounts,activeDays,rvi);
}


void buildEmptyWeek(RateValueItem *rvi){
    for(int i = 0;i < WEEKLEN;i++){
        rvi[i].forrange = 0;
        rvi[i].backrange = 0;
        rvi[i].isDayActive = false;
    }
}


bool previousDueDate_WEEKLY(SHDatetime *lastDueDate,SHDatetime *checkinDate
  ,RateValueItem *rvi,int64_t scaler,SHDatetime *ans,int *error){
    if(!(lastDueDate&&checkinDate&&rvi)) return setErrorCode(NULL_VALUES,error);
    int cnvtErr1,cnvtErr2;
    if(!(dtToTimestamp(checkinDate,&cnvtErr1) > dtToTimestamp(lastDueDate,&cnvtErr2))){
        return setErrorCode(OUT_OF_RANGE,error);
    }
    if(cnvtErr1||cnvtErr2) return setErrorCode(cnvtErr1|cnvtErr2,error);
    
    int lastDayIdx = calcWeekdayIdx(lastDueDate,error);
    SHDatetime firstDayOfFirstWeek;
    tryAddDaysToDt(lastDueDate,-lastDayIdx,0,&firstDayOfFirstWeek,error);
    if(*error) return setErrorCode(*error,error);
    int64_t daySpan = dateDiffDays(checkinDate,&firstDayOfFirstWeek,error);
    int checkinDayIDx = calcWeekdayIdx(checkinDate,error);
    
}
