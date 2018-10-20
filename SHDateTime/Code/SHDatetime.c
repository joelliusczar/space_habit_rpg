 //
//  c_datetime.c
//  SHCommon
//
//  Created by Joel Pridgen on 3/10/18.
//  Copyright © 2018 Joel Gillette. All rights reserved.
//


#include "SHDatetime.h"
#include "SHDatetimeMod.h"


double createDateTime(int64_t year,int month,int day,int hour,int minute,int second
  ,int timezoneOffset,SHErrorCode *error){
    SHError err;
    prepareSHError(&err);
    double ans = createDateTime_m(year,month,day,hour,minute,second,timezoneOffset,&err);
    if(error) *error = err.code;
    return ans;
}


int isValidSHDateTime(SHDatetime const *dt){
    return isValidSHDateTime_m(dt);
}

bool tryCreateDateTime(int64_t year,int month,int day,int hour,int minute,int second
  ,int timezoneOffset,double *ans,SHErrorCode *error){
    SHError err;
    prepareSHError(&err);
    bool isSuccess = tryCreateDateTime_m(year, month, day, hour, minute, second,
      timezoneOffset, ans, &err);
    if(error) *error = err.code;
    return isSuccess;
}

double createDate(int64_t year,int month,int day,int timezoneOffset,SHErrorCode *error){
    SHError err;
    prepareSHError(&err);
    double ans = createDate_m(year,month,day,timezoneOffset,&err);
    if(error) *error = err.code;
    return ans;
}

bool tryCreateDate(int64_t year,int month,int day,int timezoneOffset,double *ans,
    SHErrorCode *error){
    SHError err;
    prepareSHError(&err);
    bool isSuccess = tryCreateDate_m(year,month,day,timezoneOffset,ans,&err);
    if(error) *error = err.code;
    return isSuccess;
}

double createTime(int hour,int minute,int second,SHErrorCode *error){
    SHError err;
    prepareSHError(&err);
    double ans = createTime_m(hour,minute,second,&err);
    if(error) *error = err.code;
    return ans;
}

bool tryCreateTime(int hour,int minute,int second,double *ans,SHErrorCode *error){
    SHError err;
    prepareSHError(&err);
    bool isSuccess = tryCreateTime_m(hour,minute,second,ans,&err);
    if(error) *error = err.code;
    return isSuccess;
}


bool tryTimestampToDt(double timestamp, int timezoneOffset,SHDatetime *dt,
  SHErrorCode *error){
    SHError err;
    prepareSHError(&err);
    bool isSuccess = tryTimestampToDt_m(timestamp,timezoneOffset,dt,&err);
    if(error) *error = err.code;
    return isSuccess;
}

bool timestampToDtUnitsOnly(double timestamp,SHDatetime *dt,SHErrorCode *error){
    SHError err;
    prepareSHError(&err);
    bool isSuccess = timestampToDtUnitsOnly_m(timestamp,dt,&err);
    if(error) *error = err.code;
    return isSuccess;
}

bool tryDtToTimestamp(SHDatetime const *dt,double *ans,SHErrorCode *error){
    SHLog("tryDtToTimestamp");
    SHError err;
    prepareSHError(&err);
    bool isSuccess = tryDtToTimestamp_m(dt,ans,&err);
    if(error) *error = err.code;
    SHLog("leaving tryDtToTimestamp");
    return isSuccess;
}

double dtToTimestamp(SHDatetime const *dt,SHErrorCode *error){
    SHLog("dtToTimestamp");
    SHError err;
    prepareSHError(&err);
    double ans = dtToTimestamp_m(dt,&err);
    if(error) *error = err.code;
    SHLog("leaving dtToTimestamp");
    return ans;
}


bool tryExtractTime(SHDatetime *dt,double *ans,SHErrorCode *error){
    SHError err;
    prepareSHError(&err);
    bool isSuccess = tryExtractTime_m(dt,ans,&err);
    if(error) *error = err.code;
    return isSuccess;
}


double extractTime(SHDatetime *dt,SHErrorCode *error){
    SHError err;
    prepareSHError(&err);
    double ans = extractTime_m(dt,&err);
    if(error) *error = err.code;
    return ans;
}


bool tryAddDaysToDtInPlace(SHDatetime *dt,int64_t days,TimeAdjustOptions options,
  SHErrorCode *error){
    SHError err;
    prepareSHError(&err);
    bool isSuccess = tryAddDaysToDtInPlace_m(dt,days,options,&err);
    if(error) *error = err.code;
    return isSuccess;
}


bool tryAddDaysToDt(SHDatetime const *dt,int64_t days,TimeAdjustOptions options
  ,SHDatetime *ans,SHErrorCode *error){
    SHLog("tryAddDaysToDt");
    SHError err;
    prepareSHError(&err);
    bool isSuccess = tryAddDaysToDt_m(dt,days,options,ans,&err);
    if(error) *error = err.code;
    SHLog("leaving tryAddDaysToDt");
    return isSuccess;
}

#pragma GCC diagnostic push
#pragma GCC diagnostic ignored "-Wunused-parameter"

bool tryAddDaysToTimestamp(double timestamp,int64_t days, TimeAdjustOptions options,
   double *ans,SHErrorCode *error){
    SHError err;
    prepareSHError(&err);
    bool isSuccess = tryAddDaysToTimestamp_m(timestamp,days,options,ans,&err);
    if(error) *error = err.code;
    return isSuccess;
}

#pragma GCC diagnostic pop

bool tryAddMonthsToDt(SHDatetime const *dt,int64_t months,TimeAdjustOptions options
  ,SHDatetime *ans,SHErrorCode *error){
    SHError err;
    prepareSHError(&err);
    bool isSuccess = tryAddMonthsToDt_m(dt,months,options,ans,&err);
    if(error) *error = err.code;
    return isSuccess;
}

bool tryAddMonthsToDtInPlace(SHDatetime *dt,int64_t months,TimeAdjustOptions options,
  SHErrorCode *error){
    SHError err;
    prepareSHError(&err);
    bool isSuccess = tryAddMonthsToDtInPlace_m(dt,months,options,&err);
    if(error) *error = err.code;
    return isSuccess;
}

bool tryAddMonthsToTimestamp(double timestamp,int64_t months,int timezoneOffset,
  TimeAdjustOptions options,double *ans,SHErrorCode *error){
    SHError err;
    prepareSHError(&err);
    bool isSuccess = tryAddMonthsToTimestamp_m(timestamp,months,timezoneOffset,options,
      ans,&err);
    if(error) *error = err.code;
    return isSuccess;
}


double addYearsToTimestamp(double timestamp,int64_t years,int timezoneOffset,
  TimeAdjustOptions options,SHErrorCode *error){
    SHError err;
    prepareSHError(&err);
    double ans = addYearsToTimestamp_m(timestamp,years,timezoneOffset,options,&err);
    if(error) *error = err.code;
    return ans;
}

bool tryAddYearsToTimestamp(double timestamp,int64_t years,int timezoneOffset,
  TimeAdjustOptions options,double *ans,SHErrorCode *error){
    SHError err;
    prepareSHError(&err);
    bool isSuccess = tryAddYearsToTimestamp_m(timestamp,years,timezoneOffset,options,
      ans,&err);
    if(error) *error = err.code;
    return isSuccess;
}

bool tryAddYearsToDt(SHDatetime const *dt,int64_t years,TimeAdjustOptions options
  ,SHDatetime *ans,SHErrorCode *error){
    SHError err;
    prepareSHError(&err);
    bool isSuccess = tryAddYearsToDt_m(dt,years,options,ans,&err);
    if(error) *error = err.code;
    return isSuccess;
}

bool tryAddYearsToDtInPlace(SHDatetime *dt,int64_t years,TimeAdjustOptions options
  ,SHErrorCode *error){
    SHError err;
    prepareSHError(&err);
    bool isSuccess = tryAddYearsToDtInPlace_m(dt,years,options,&err);
    if(error) *error = err.code;
    return isSuccess;
}

bool tryDayStart(double timestamp,int timezoneOffset,double *ans,SHErrorCode *error){
    SHError err;
    prepareSHError(&err);
    bool isSuccess = tryDayStart_m(timestamp,timezoneOffset,ans,&err);
    if(error) *error = err.code;
    return isSuccess;
}


int calcWeekdayIdx(SHDatetime *dt,SHErrorCode *error){
    SHError err;
    prepareSHError(&err);
    int ans = calcWeekdayIdx_m(dt,&err);
    if(error) *error = err.code;
    return ans;
}

int calcDayOfYear(SHDatetime *dt,SHErrorCode *error){
    SHError err;
    prepareSHError(&err);
    int ans = calcDayOfYear_m(dt,&err);
    if(error) *error = err.code;
    return ans;
}


int calcDayOfYearFromTimestamp(double timestamp,int timezoneOffset,SHErrorCode * error){
    SHError err;
    prepareSHError(&err);
    int ans = calcDayOfYearFromTimestamp_m(timestamp,timezoneOffset,&err);
    if(error) *error = err.code;
    return ans;
}


bool tryDiffDateSecs(SHDatetime const *A,SHDatetime const *B,int64_t *ans,SHErrorCode *error){
    SHError err;
    prepareSHError(&err);
    bool isSuccess = tryDiffDateSecs_m(A,B,ans,&err);
    if(error) *error = err.code;
    return isSuccess;
}

double dateDiffSecs(SHDatetime const *A,SHDatetime const *B,SHErrorCode *error){
    SHError err;
    prepareSHError(&err);
    double ans = dateDiffSecs_m(A,B,&err);
    if(error) *error = err.code;
    return ans;
}


int64_t dateDiffDays(SHDatetime const *A,SHDatetime const *B,SHErrorCode *error){
    SHError err;
    prepareSHError(&err);
    int64_t ans = dateDiffDays_m(A,B,&err);
    if(error) *error = err.code;
    return ans;
}


bool tryDateDiffDays(SHDatetime const *A,SHDatetime const *B,int64_t *ans,SHErrorCode *error){
    SHError err;
    prepareSHError(&err);
    bool isSuccess = tryDateDiffDays_m(A,B,ans,&err);
    if(error) *error = err.code;
    return isSuccess;
}


bool initDt(SHDatetime *dt){
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


bool initTimeshift(Timeshift *shift){
  if(!shift) return false;
  shift->adjustment = 0;
  shift->day = 0;
  shift->hour = 0;
  shift->minute = 0;
  shift->month = 0;
  return true;
}

