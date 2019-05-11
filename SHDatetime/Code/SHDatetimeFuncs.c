 //
//  c_datetime.c
//  SHCommon
//
//  Created by Joel Pridgen on 3/10/18.
//  Copyright © 2018 Joel Gillette. All rights reserved.
//


#include "SHDatetime.h"
#include "SHDatetimeMod.h"


double shCreateDateTime(int64_t year,int month,int day,int hour,int minute,int second
  ,int timezoneOffset,SHErrorCode *error){
    SHError err;
    shPrepareSHError(&err);
    double ans = shCreateDateTime_m(year,month,day,hour,minute,second,timezoneOffset,&err);
    if(error) *error = err.code;
    return ans;
}


int shIsValidSHDateTime(SHDatetime const *dt){
    return shIsValidSHDateTime_m(dt);
}

bool shTryCreateDateTime(int64_t year,int month,int day,int hour,int minute,int second
  ,int timezoneOffset,double *ans,SHErrorCode *error){
    SHError err;
    shPrepareSHError(&err);
    bool isSuccess = shTryCreateDateTime_m(year, month, day, hour, minute, second,
      timezoneOffset, ans, &err);
    if(error) *error = err.code;
    return isSuccess;
}

double shCreateDate(int64_t year,int month,int day,int timezoneOffset,SHErrorCode *error){
    SHError err;
    shPrepareSHError(&err);
    double ans = shCreateDate_m(year,month,day,timezoneOffset,&err);
    if(error) *error = err.code;
    return ans;
}

bool shTryCreateDate(int64_t year,int month,int day,int timezoneOffset,double *ans,
    SHErrorCode *error){
    SHError err;
    shPrepareSHError(&err);
    bool isSuccess = shTryCreateDate_m(year,month,day,timezoneOffset,ans,&err);
    if(error) *error = err.code;
    return isSuccess;
}

double shCreateTime(int hour,int minute,int second,SHErrorCode *error){
    SHError err;
    shPrepareSHError(&err);
    double ans = shCreateTime_m(hour,minute,second,&err);
    if(error) *error = err.code;
    return ans;
}

bool shTryCreateTime(int hour,int minute,int second,double *ans,SHErrorCode *error){
    SHError err;
    shPrepareSHError(&err);
    bool isSuccess = shTryCreateTime_m(hour,minute,second,ans,&err);
    if(error) *error = err.code;
    return isSuccess;
}


bool shTryTimestampToDt(double timestamp, int timezoneOffset,SHDatetime *dt,
  SHErrorCode *error){
    SHError err;
    shPrepareSHError(&err);
    bool isSuccess = shTryTimestampToDt_m(timestamp,timezoneOffset,dt,&err);
    if(error) *error = err.code;
    return isSuccess;
}

bool shTimestampToDtUnitsOnly(double timestamp,SHDatetime *dt,SHErrorCode *error){
    SHError err;
    shPrepareSHError(&err);
    bool isSuccess = shTimestampToDtUnitsOnly_m(timestamp,dt,&err);
    if(error) *error = err.code;
    return isSuccess;
}

bool shTryDtToTimestamp(SHDatetime const *dt,double *ans,SHErrorCode *error){
    shLog("shTryDtToTimestamp");
    SHError err;
    shPrepareSHError(&err);
    bool isSuccess = shTryDtToTimestamp_m(dt,ans,&err);
    if(error) *error = err.code;
    shLog("leaving shTryDtToTimestamp");
    return isSuccess;
}

double shDtToTimestamp(SHDatetime const *dt,SHErrorCode *error){
    shLog("shDtToTimestamp");
    SHError err;
    shPrepareSHError(&err);
    double ans = shDtToTimestamp_m(dt,&err);
    if(error) *error = err.code;
    shLog("leaving shDtToTimestamp");
    return ans;
}


bool shTryExtractTime(SHDatetime *dt,double *ans,SHErrorCode *error){
    SHError err;
    shPrepareSHError(&err);
    bool isSuccess = shTryExtractTime_m(dt,ans,&err);
    if(error) *error = err.code;
    return isSuccess;
}


double shExtractTime(SHDatetime *dt,SHErrorCode *error){
    SHError err;
    shPrepareSHError(&err);
    double ans = shExtractTime_m(dt,&err);
    if(error) *error = err.code;
    return ans;
}


bool shTryAddDaysToDtInPlace(SHDatetime *dt,int64_t days,TimeAdjustOptions options,
  SHErrorCode *error){
    SHError err;
    shPrepareSHError(&err);
    bool isSuccess = shTryAddDaysToDtInPlace_m(dt,days,options,&err);
    if(error) *error = err.code;
    return isSuccess;
}


bool shTryAddDaysToDt(SHDatetime const *dt,int64_t days,TimeAdjustOptions options
  ,SHDatetime *ans,SHErrorCode *error){
    shLog("shTryAddDaysToDt");
    SHError err;
    shPrepareSHError(&err);
    bool isSuccess = shTryAddDaysToDt_m(dt,days,options,ans,&err);
    if(error) *error = err.code;
    shLog("leaving shTryAddDaysToDt");
    return isSuccess;
}

#pragma GCC diagnostic push
#pragma GCC diagnostic ignored "-Wunused-parameter"

bool shTryAddDaysToTimestamp(double timestamp,int64_t days, TimeAdjustOptions options,
   double *ans,SHErrorCode *error){
    SHError err;
    shPrepareSHError(&err);
    bool isSuccess = shTryAddDaysToTimestamp_m(timestamp,days,options,ans,&err);
    if(error) *error = err.code;
    return isSuccess;
}

#pragma GCC diagnostic pop

bool shTryAddMonthsToDt(SHDatetime const *dt,int64_t months,TimeAdjustOptions options
  ,SHDatetime *ans,SHErrorCode *error){
    SHError err;
    shPrepareSHError(&err);
    bool isSuccess = shTryAddMonthsToDt_m(dt,months,options,ans,&err);
    if(error) *error = err.code;
    return isSuccess;
}

bool shTryAddMonthsToDtInPlace(SHDatetime *dt,int64_t months,TimeAdjustOptions options,
  SHErrorCode *error){
    SHError err;
    shPrepareSHError(&err);
    bool isSuccess = shTryAddMonthsToDtInPlace_m(dt,months,options,&err);
    if(error) *error = err.code;
    return isSuccess;
}

bool shTryAddMonthsToTimestamp(double timestamp,int64_t months,int timezoneOffset,
  TimeAdjustOptions options,double *ans,SHErrorCode *error){
    SHError err;
    shPrepareSHError(&err);
    bool isSuccess = shTryAddMonthsToTimestamp_m(timestamp,months,timezoneOffset,options,
      ans,&err);
    if(error) *error = err.code;
    return isSuccess;
}


double shAddYearsToTimestamp(double timestamp,int64_t years,int timezoneOffset,
  TimeAdjustOptions options,SHErrorCode *error){
    SHError err;
    shPrepareSHError(&err);
    double ans = shAddYearsToTimestamp_m(timestamp,years,timezoneOffset,options,&err);
    if(error) *error = err.code;
    return ans;
}

bool shTryAddYearsToTimestamp(double timestamp,int64_t years,int timezoneOffset,
  TimeAdjustOptions options,double *ans,SHErrorCode *error){
    SHError err;
    shPrepareSHError(&err);
    bool isSuccess = shTryAddYearsToTimestamp_m(timestamp,years,timezoneOffset,options,
      ans,&err);
    if(error) *error = err.code;
    return isSuccess;
}

bool shTryAddYearsToDt(SHDatetime const *dt,int64_t years,TimeAdjustOptions options
  ,SHDatetime *ans,SHErrorCode *error){
    SHError err;
    shPrepareSHError(&err);
    bool isSuccess = shTryAddYearsToDt_m(dt,years,options,ans,&err);
    if(error) *error = err.code;
    return isSuccess;
}

bool shTryAddYearsToDtInPlace(SHDatetime *dt,int64_t years,TimeAdjustOptions options
  ,SHErrorCode *error){
    SHError err;
    shPrepareSHError(&err);
    bool isSuccess = shTryAddYearsToDtInPlace_m(dt,years,options,&err);
    if(error) *error = err.code;
    return isSuccess;
}

bool shTryDayStart(double timestamp,int timezoneOffset,double *ans,SHErrorCode *error){
    SHError err;
    shPrepareSHError(&err);
    bool isSuccess = shTryDayStart_m(timestamp,timezoneOffset,ans,&err);
    if(error) *error = err.code;
    return isSuccess;
}


int shCalcWeekdayIdx(SHDatetime *dt,SHErrorCode *error){
    SHError err;
    shPrepareSHError(&err);
    int ans = shCalcWeekdayIdx_m(dt,&err);
    if(error) *error = err.code;
    return ans;
}

int shCalcDayOfYear(SHDatetime *dt,SHErrorCode *error){
    SHError err;
    shPrepareSHError(&err);
    int ans = shCalcDayOfYear_m(dt,&err);
    if(error) *error = err.code;
    return ans;
}


int shCalcDayOfYearFromTimestamp(double timestamp,int timezoneOffset,SHErrorCode * error){
    SHError err;
    shPrepareSHError(&err);
    int ans = shCalcDayOfYearFromTimestamp_m(timestamp,timezoneOffset,&err);
    if(error) *error = err.code;
    return ans;
}


bool shTryDiffDateSecs(SHDatetime const *A,SHDatetime const *B,int64_t *ans,SHErrorCode *error){
    SHError err;
    shPrepareSHError(&err);
    bool isSuccess = shTryDiffDateSecs_m(A,B,ans,&err);
    if(error) *error = err.code;
    return isSuccess;
}

double shDateDiffSecs(SHDatetime const *A,SHDatetime const *B,SHErrorCode *error){
    SHError err;
    shPrepareSHError(&err);
    double ans = shDateDiffSecs_m(A,B,&err);
    if(error) *error = err.code;
    return ans;
}


int64_t shDateDiffDays(SHDatetime const *A,SHDatetime const *B,SHErrorCode *error){
    SHError err;
    shPrepareSHError(&err);
    int64_t ans = shDateDiffDays_m(A,B,&err);
    if(error) *error = err.code;
    return ans;
}


bool shTryDateDiffDays(SHDatetime const *A,SHDatetime const *B,int64_t *ans,SHErrorCode *error){
    SHError err;
    shPrepareSHError(&err);
    bool isSuccess = shTryDateDiffDays_m(A,B,ans,&err);
    if(error) *error = err.code;
    return isSuccess;
}


bool shInitDt(SHDatetime *dt){
  if(!dt) return false;
  dt->currentShiftIdx = -1;
  dt->day = 1;
  dt->hour = 0;
  dt->minute = 0;
  dt->month = 1;
  dt->second = 0;
  dt->milisecond = 0;
  dt->shiftLen = 0;
  dt->shifts = NULL;
  return true;
}


bool shInitTimeshift(SHTimeshift *shift){
  if(!shift) return false;
  shift->adjustment = 0;
  shift->day = 0;
  shift->hour = 0;
  shift->minute = 0;
  shift->month = 0;
  return true;
}

