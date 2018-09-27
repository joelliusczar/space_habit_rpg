//
//  SHDatetimeNoErr.h
//  SHDatetime
//
//  Created by Joel Pridgen on 9/26/18.
//  Copyright © 2018 Joel Gillette. All rights reserved.
//
// This header is completely optional. It is purely wrapper methods.
//

#ifndef SHDatetimeNoErr_h
#define SHDatetimeNoErr_h

#include <stdio.h>
#include <stdbool.h>
#include <inttypes.h>
#include "SHDatetimeMod.h"

extern SHError _shError; //don't use this, use getter/setter

void setSHError(SHError * err);

SHError* getSHError(void);

double createDateTime_s(int64_t year,int month,int day,int hour,int minute,int second,
  int timezoneOffset);

double createDate_s(int64_t year,int month,int day,int timezoneOffset);

double createTime_s(int hour,int minute,int second);

double extractTime_s(SHDatetime *dt);

void timestampToDt_s(double timestamp, int timezoneOffset,SHDatetime *dt);

void timestampToDtUnitsOnly_s(double timestamp,SHDatetime *dt);

double dtToTimestamp_s(SHDatetime const *dt);

void addYearsToDt_s(SHDatetime const *dt,int64_t years,TimeAdjustOptions options,
  SHDatetime *ans);

void addYearsToDtInPlace_s(SHDatetime *dt,int64_t years,TimeAdjustOptions options);

double addYearsToTimestamp_s(double timestamp,int64_t years,int timezoneOffset,
  TimeAdjustOptions options);

void addMonthsToDt_s(SHDatetime const *dt,int64_t months,TimeAdjustOptions options,
  SHDatetime *ans);

void addMonthsToDtInPlace_s(SHDatetime *dt,int64_t months,TimeAdjustOptions options);

void addMonthsToTimestamp_s(double timestamp,int64_t months,int timezoneOffset,
  TimeAdjustOptions options,double *ans);

void addDaysToDt_m(SHDatetime const *dt,int64_t days,TimeAdjustOptions options,
  SHDatetime *ans);

void addDaysToDtInPlace_s(SHDatetime *dt,int64_t days,TimeAdjustOptions options);

void addDaysToTimestamp_s(double timestamp,int64_t days,TimeAdjustOptions options,
  double *ans);

double dayStart_s(double timestamp,int timezoneOffset);

int calcWeekdayIdx_s(SHDatetime *dt);

int calcDayOfYear_s(SHDatetime *dt);

int calcDayOfYearFromTimestamp_s(double timestamp,int timezoneOffset);

int64_t dateDiffDays_s(SHDatetime const *A,SHDatetime const *B);

double dateDiffSecs_s(SHDatetime const *A,SHDatetime const *B);

#endif /* SHDatetimeNoErr_h */
