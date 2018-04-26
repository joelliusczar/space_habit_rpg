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
#include "ErrorConstants.h"

MAKE_FIND_IDX_REV(bool,int,,)
MAKE_FIND_IDX(bool,int,,)

static bool _setError(int code,int *error){
    *error = code;
    return false;
}

#pragma GCC diagnostic push
#pragma GCC diagnostic ignored "-Wunused-parameter"

static bool isDayActive(bool isActive,long idx,int blank){
    return isActive;
}

#pragma GCC diagnostic pop

static void setDayCounts(long *daysCounts,bool *activeDays,long counter,bool isReverse){
    for(int dayIdx = 0;dayIdx < WEEKLEN;dayIdx++){
        int useIdx = isReverse?WEEKLEN -dayIdx -1:dayIdx;
        counter++;
        daysCounts[useIdx] = counter;
        if(activeDays[useIdx]){
            counter = 0;
        }
    }
}


void filWeek(long *daysAheadCounts,long *daysBeforeCounts,bool *activeDays
             ,RateValueItem *rvi){
    for(int dayIdx = 0;dayIdx < WEEKLEN;dayIdx++){
        rvi[0].forrange = daysAheadCounts[dayIdx];
        rvi[0].backrange = daysBeforeCounts[dayIdx];
        rvi[0].isDayActive = activeDays[dayIdx];
    }
}


void buildWeek(bool *activeDays,long scaler,RateValueItem *rvi){
    long lastIdx = findIdxRev(bool,int)(activeDays,WEEKLEN,&isDayActive,0);
    if(lastIdx == NOT_FOUND){
        buildEmptyWeek(rvi);
        return;
    }
    long daysBefore = (WEEKLEN - lastIdx) + (scaler -1)*WEEKLEN -1;
    long daysBeforeCounts[WEEKLEN];
    setDayCounts(daysBeforeCounts,activeDays,daysBefore,false);
    long firstIdx = findIdx(bool,int)(activeDays,WEEKLEN,&isDayActive,0);
    long daysAhead = firstIdx + (scaler -1)*WEEKLEN;
    long daysAheadCounts[WEEKLEN];
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


bool previousDueDate_WEEKLY(SHDateTime *lastDueDate,SHDateTime *checkinDate
                            ,RateValueItem *rvi,long scaler,SHDateTime *ans,int *error){
    if(!(lastDueDate&&checkinDate&&rvi)) return _setError(NULL_VALUES,error);
    int cnvtErr1,cnvtErr2;
    if(!(dtToTimestamp(checkinDate,&cnvtErr1) > dtToTimestamp(lastDueDate,&cnvtErr2))){
        return _setError(OUT_OF_RANGE,error);
    }
    if(cnvtErr1||cnvtErr2) return _setError(0,error);
    
    int lastDayIdx = calcWeekdayIdx(lastDueDate,error);
    SHDateTime *firstDayOfFirstWeek;
    tryAddDaysToDt(&lastDueDate,-lastDayIdx,0,&firstDayOfFirstWeek,error);
    long daySpan = dateDiffDays(checkinDate,firstDayOfFirstWeek,error);
}
