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
#include <stdlib.h>

DEF_FIND_IDX_REV(bool,int,,)
DEF_FIND_IDX(bool,int,,)


#pragma GCC diagnostic push
#pragma GCC diagnostic ignored "-Wunused-parameter"

static bool _isDayActive(bool isActive,int64_t idx,int blank){
    return isActive;
}

#pragma GCC diagnostic pop

static void _setDayCounts(int64_t *daysCounts,bool *activeDays,int64_t counter
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


static int64_t _distanceFromActiveWeek(int64_t weekNum,int64_t weekScaler){
    return weekNum % (weekScaler * DAYS_IN_WEEK);
}


void buildWeek(bool *activeDays,int64_t scaler,RateValueItem *rvi){
    int64_t lastIdx = findIdxRev(bool,int)(activeDays,WEEKLEN,&_isDayActive,0);
    if(lastIdx == NOT_FOUND){
        buildEmptyWeek(rvi);
        return;
    }
    int64_t daysBefore = (WEEKLEN - lastIdx) + (scaler -1)*WEEKLEN -1;
    int64_t daysBeforeCounts[WEEKLEN];
    _setDayCounts(daysBeforeCounts,activeDays,daysBefore,false);
    int64_t firstIdx = findIdx(bool,int)(activeDays,WEEKLEN,&_isDayActive,0);
    int64_t daysAhead = firstIdx + (scaler -1)*WEEKLEN;
    int64_t daysAheadCounts[WEEKLEN];
    _setDayCounts(daysAheadCounts,activeDays,daysAhead,true);
    
    return filWeek(daysAheadCounts,daysBeforeCounts,activeDays,rvi);
}


void buildEmptyWeek(RateValueItem *rvi){
    for(int i = 0;i < WEEKLEN;i++){
        rvi[i].forrange = 0;
        rvi[i].backrange = 0;
        rvi[i].isDayActive = false;
    }
}

static int _findPrevDayIdxInWeek(bool isActiveWeek,int checkinDayIdx
  ,RateValueItem *week){
    int prevDayIdx = DAYS_IN_WEEK;
    for(int i = 0; i < DAYS_IN_WEEK; i++){
        int reverseDayIdx = isActiveWeek ?
          (DAYS_IN_WEEK + checkinDayIdx - i -1) & DAYS_IN_WEEK :
          DAYS_IN_WEEK - i - 1;
        if(week[reverseDayIdx].isDayActive){
            prevDayIdx = reverseDayIdx;
            break;
        }
    }
    return prevDayIdx < DAYS_IN_WEEK ? prevDayIdx : NOT_FOUND;
}

static int _findNextDayIdx(int checkinDayIdx,RateValueItem* week){
    for(int i = 0; i < DAYS_IN_WEEK; i++){
        int dayIdx = (DAYS_IN_WEEK + checkinDayIdx + i) % DAYS_IN_WEEK;
        if(week[dayIdx].isDayActive){
            return dayIdx;
        }
    }
    return NOT_FOUND;
}

static int _offsetForSameWeek(bool isActiveWeek, int inputDayIdx,int prevDayIdx){
    /*
     if checkin day is in active week but before all active days
     push it back a week so that it get's the last active day of
     the previous active weeks
     */
    return prevDayIdx > inputDayIdx || (prevDayIdx == inputDayIdx && isActiveWeek)
      ? DAYS_IN_WEEK : 0;
}


bool previousDueDate_WEEKLY(SHDatetime *lastDueDate,SHDatetime *checkinDate
  ,RateValueItem *rvi,int64_t scaler,SHDatetime *ans,SHError *error){
    if(!(lastDueDate&&checkinDate&&rvi)) return handleError(NULL_VALUES, "", error);
    SHErrorCode cnvtErr1,cnvtErr2;
    if(!(dtToTimestamp(checkinDate,&cnvtErr1) > dtToTimestamp(lastDueDate,&cnvtErr2))){
        return handleError(OUT_OF_RANGE,"",error);
    }
    if(cnvtErr1||cnvtErr2) return handleError(cnvtErr1||cnvtErr2, "", error);
    
    int lastDayIdx = calcWeekdayIdx_m(lastDueDate,error);
    SHDatetime firstDayOfFirstWeek;
    tryAddDaysToDt_m(lastDueDate,-lastDayIdx,0,&firstDayOfFirstWeek,error);
    int64_t daySpan = dateDiffDays_m(checkinDate,&firstDayOfFirstWeek,error);
    int checkinDayIdx = calcWeekdayIdx_m(checkinDate,error);
    int64_t firstSunToPrevSunSpan = daySpan - checkinDayIdx;
    bool isActiveWeek = _distanceFromActiveWeek(firstSunToPrevSunSpan, scaler) == 0;
    int prevDayIdx = _findPrevDayIdxInWeek(isActiveWeek, checkinDayIdx, rvi);
    firstSunToPrevSunSpan -= (_offsetForSameWeek(isActiveWeek,checkinDayIdx,prevDayIdx));
    int64_t sunOfPrevActionWeek
      = firstSunToPrevSunSpan - _distanceFromActiveWeek(firstSunToPrevSunSpan, scaler);
    tryAddDaysToDt_m(&firstDayOfFirstWeek,sunOfPrevActionWeek + prevDayIdx,0,ans,error);
    if(!(dtToTimestamp(ans,&cnvtErr1) <= dtToTimestamp(checkinDate,&cnvtErr2))){
        return handleError(OUT_OF_RANGE,"",error);
    }
    return true;
}


SHDatetime* bothWeeklyDueDatesFromLastDueDate(SHDatetime* lastDueDate,SHDatetime* checkinDate
  ,RateValueItem* week,int64_t scaler,SHError *error){
    SHDatetime previousDate;
    previousDueDate_WEEKLY(lastDueDate, checkinDate, week, scaler, &previousDate, error);
    int prevDayIdx = calcWeekdayIdx_m(&previousDate, error);
    SHDatetime firstDayOfPrevWeek;
    tryAddDaysToDt_m(&previousDate, -1*prevDayIdx, 0, &firstDayOfPrevWeek, error);
    int64_t daySpan = dateDiffDays_m(&firstDayOfPrevWeek, checkinDate, error);
    int checkinDayIdx = calcWeekdayIdx_m(checkinDate, error);
    int64_t prevSunToThisSunSpan = daySpan - checkinDayIdx;
    int64_t weekCount = (_distanceFromActiveWeek(prevSunToThisSunSpan, scaler)/DAYS_IN_WEEK);
    int64_t nextActiveWeek = prevSunToThisSunSpan + (((scaler - weekCount) % scaler) * DAYS_IN_WEEK);
    int weekStartIdx = weekCount == 0 ? checkinDayIdx : 0;
    int nextDayIdx = _findNextDayIdx(weekStartIdx, week);
    int64_t sameWeekOffset = nextDayIdx < checkinDayIdx && weekCount == 0 ? scaler * DAYS_IN_WEEK : 0;
    SHDatetime result;
    tryAddDaysToDt_m(&firstDayOfPrevWeek, nextActiveWeek + nextDayIdx + sameWeekOffset
      ,0,&result, error);
    SHDatetime* resultPair = malloc(sizeof(SHDatetime)*2);
    resultPair[0] = previousDate;
    resultPair[1] = result;
    return resultPair;
}

bool nextDueDate_WEEKLY(SHDatetime* lastDueDate,SHDatetime* checkinDate
  , RateValueItem* week,int64_t scaler,SHDatetime *ans,SHError* error){
    SHDatetime* resultPair = bothWeeklyDueDatesFromLastDueDate(lastDueDate, checkinDate
      , week, scaler, error);
    *ans = resultPair[1];
    free(resultPair);
    if(error->code) return handleError(error->code, "", error);
    return true;
}
