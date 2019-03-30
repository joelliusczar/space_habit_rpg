//
//  SHDatetimeNoErr.c
//  SHDatetime
//
//  Created by Joel Pridgen on 9/26/18.
//  Copyright © 2018 Joel Gillette. All rights reserved.
//

#include "SHDatetimeNoErr.h"

SHError _shError;

void setSHError(SHError * err){
	if(!err){
		shDisposeSHError(&_shError);
		return;
	}
	_shError = *err;
}

SHError* getSHError(void){
	return &_shError;
}

double shCreateDateTime_s(int64_t year,int month,int day,int hour,int minute,int second,
  int timezoneOffset){
	SHError* err = getSHError();
	shPrepareSHError(err);
	return shCreateDateTime_m(year, month, day, hour, minute, second, timezoneOffset
      ,err);
}

double shCreateDate_s(int64_t year,int month,int day,int timezoneOffset){
	SHError* err = getSHError();
	shPrepareSHError(err);
	return shCreateDate_m(year, month, day, timezoneOffset, err);
}

double shCreateTime_s(int hour,int minute,int second){
	SHError* err = getSHError();
	shPrepareSHError(err);
	return shCreateTime_m(hour, minute, second, err);
}

double shExtractTime_s(SHDatetime *dt){
	SHError* err = getSHError();
	shPrepareSHError(err);
	return shExtractTime_m(dt, err);
}

void timestampToDt_s(double timestamp, int timezoneOffset,SHDatetime *dt){
	SHError* err = getSHError();
	shPrepareSHError(err);
	shTryTimestampToDt_m(timestamp, timezoneOffset, dt, err);
}

void shTimestampToDtUnitsOnly_s(double timestamp,SHDatetime *dt){
	SHError* err = getSHError();
	shPrepareSHError(err);
	shTimestampToDtUnitsOnly_m(timestamp, dt, err);
}

double shDtToTimestamp_s(SHDatetime const *dt){
	SHError* err = getSHError();
	shPrepareSHError(err);
	return shDtToTimestamp_m(dt, err);
}

void addYearsToDt_s(SHDatetime const *dt,int64_t years,TimeAdjustOptions options,
  SHDatetime *ans){
	SHError* err = getSHError();
	shPrepareSHError(err);
	shTryAddYearsToDt_m(dt, years, options, ans, err);
}

void addYearsToDtInPlace_s(SHDatetime *dt,int64_t years,TimeAdjustOptions options){
	SHError* err = getSHError();
	shPrepareSHError(err);
	shTryAddYearsToDtInPlace_m(dt, years, options, err);
}

double shAddYearsToTimestamp_s(double timestamp,int64_t years,int timezoneOffset,
  TimeAdjustOptions options){
	SHError* err = getSHError();
	shPrepareSHError(err);
	return shAddYearsToTimestamp_m(timestamp, years, timezoneOffset, options, err);
}

void addMonthsToDt_s(SHDatetime const *dt,int64_t months,TimeAdjustOptions options,
  SHDatetime *ans){
	SHError* err = getSHError();
	shPrepareSHError(err);
	shTryAddMonthsToDt_m(dt, months, options, ans, err);
}

void addMonthsToDtInPlace_s(SHDatetime *dt,int64_t months,TimeAdjustOptions options){
	SHError* err = getSHError();
	shPrepareSHError(err);
	shTryAddMonthsToDtInPlace_m(dt, months, options, err);
}

void addMonthsToTimestamp_s(double timestamp,int64_t months,int timezoneOffset,
  TimeAdjustOptions options,double *ans){
	SHError* err = getSHError();
	shPrepareSHError(err);
	shTryAddMonthsToTimestamp_m(timestamp, months, timezoneOffset, options, ans, err);
}

void addDaysToDt_s(SHDatetime const *dt,int64_t days,TimeAdjustOptions options,
  SHDatetime *ans){
	SHError* err = getSHError();
	shPrepareSHError(err);
	shTryAddDaysToDt_m(dt, days, options, ans, err);
}

void addDaysToDtInPlace_s(SHDatetime *dt,int64_t days,TimeAdjustOptions options){
	SHError* err = getSHError();
	shPrepareSHError(err);
	shTryAddDaysToDtInPlace_m(dt, days, options, err);
}

void addDaysToTimestamp_s(double timestamp,int64_t days,TimeAdjustOptions options,
  double *ans){
	SHError* err = getSHError();
	shPrepareSHError(err);
	shTryAddDaysToTimestamp_m(timestamp, days, options, ans, err);
}

double dayStart_s(double timestamp,int timezoneOffset){
	SHError* err = getSHError();
	shPrepareSHError(err);
	double ans;
	shTryDayStart_m(timestamp, timezoneOffset, &ans, err);
	return ans;
}

int shCalcWeekdayIdx_s(SHDatetime *dt){
	SHError* err = getSHError();
	shPrepareSHError(err);
	return shCalcWeekdayIdx_m(dt, err);
}

int shCalcDayOfYear_s(SHDatetime *dt){
	SHError* err = getSHError();
	shPrepareSHError(err);
	return shCalcDayOfYear_m(dt, err);
}

int shCalcDayOfYearFromTimestamp_s(double timestamp,int timezoneOffset){
	SHError* err = getSHError();
	shPrepareSHError(err);
	return shCalcDayOfYearFromTimestamp_m(timestamp, timezoneOffset, err);
}

int64_t shDateDiffDays_s(SHDatetime const *A,SHDatetime const *B){
	SHError* err = getSHError();
	shPrepareSHError(err);
	return shDateDiffDays_m(A, B, err);
}

double shDateDiffSecs_s(SHDatetime const *A,SHDatetime const *B){
	SHError* err = getSHError();
	shPrepareSHError(err);
	return shDateDiffSecs_m(A, B, err);
}
