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
		disposeSHError(&_shError);
		return;
	}
	_shError = *err;
}

SHError* getSHError(void){
	return &_shError;
}

double createDateTime_s(int64_t year,int month,int day,int hour,int minute,int second,
  int timezoneOffset){
	SHError* err = getSHError();
	prepareSHError(err);
	return createDateTime_m(year, month, day, hour, minute, second, timezoneOffset
      ,err);
}

double createDate_s(int64_t year,int month,int day,int timezoneOffset){
	SHError* err = getSHError();
	prepareSHError(err);
	return createDate_m(year, month, day, timezoneOffset, err);
}

double createTime_s(int hour,int minute,int second){
	SHError* err = getSHError();
	prepareSHError(err);
	return createTime_m(hour, minute, second, err);
}

double extractTime_s(SHDatetime *dt){
	SHError* err = getSHError();
	prepareSHError(err);
	return extractTime_m(dt, err);
}

void timestampToDt_s(double timestamp, int timezoneOffset,SHDatetime *dt){
	SHError* err = getSHError();
	prepareSHError(err);
	tryTimestampToDt_m(timestamp, timezoneOffset, dt, err);
}

void timestampToDtUnitsOnly_s(double timestamp,SHDatetime *dt){
	SHError* err = getSHError();
	prepareSHError(err);
	timestampToDtUnitsOnly_m(timestamp, dt, err);
}

double dtToTimestamp_s(SHDatetime const *dt){
	SHError* err = getSHError();
	prepareSHError(err);
	return dtToTimestamp_m(dt, err);
}

void addYearsToDt_s(SHDatetime const *dt,int64_t years,TimeAdjustOptions options,
  SHDatetime *ans){
	SHError* err = getSHError();
	prepareSHError(err);
	tryAddYearsToDt_m(dt, years, options, ans, err);
}

void addYearsToDtInPlace_s(SHDatetime *dt,int64_t years,TimeAdjustOptions options){
	SHError* err = getSHError();
	prepareSHError(err);
	tryAddYearsToDtInPlace_m(dt, years, options, err);
}

double addYearsToTimestamp_s(double timestamp,int64_t years,int timezoneOffset,
  TimeAdjustOptions options){
	SHError* err = getSHError();
	prepareSHError(err);
	return addYearsToTimestamp_m(timestamp, years, timezoneOffset, options, err);
}

void addMonthsToDt_s(SHDatetime const *dt,int64_t months,TimeAdjustOptions options,
  SHDatetime *ans){
	SHError* err = getSHError();
	prepareSHError(err);
	tryAddMonthsToDt_m(dt, months, options, ans, err);
}

void addMonthsToDtInPlace_s(SHDatetime *dt,int64_t months,TimeAdjustOptions options){
	SHError* err = getSHError();
	prepareSHError(err);
	tryAddMonthsToDtInPlace_m(dt, months, options, err);
}

void addMonthsToTimestamp_s(double timestamp,int64_t months,int timezoneOffset,
  TimeAdjustOptions options,double *ans){
	SHError* err = getSHError();
	prepareSHError(err);
	tryAddMonthsToTimestamp_m(timestamp, months, timezoneOffset, options, ans, err);
}

void addDaysToDt_s(SHDatetime const *dt,int64_t days,TimeAdjustOptions options,
  SHDatetime *ans){
	SHError* err = getSHError();
	prepareSHError(err);
	tryAddDaysToDt_m(dt, days, options, ans, err);
}

void addDaysToDtInPlace_s(SHDatetime *dt,int64_t days,TimeAdjustOptions options){
	SHError* err = getSHError();
	prepareSHError(err);
	tryAddDaysToDtInPlace_m(dt, days, options, err);
}

void addDaysToTimestamp_s(double timestamp,int64_t days,TimeAdjustOptions options,
  double *ans){
	SHError* err = getSHError();
	prepareSHError(err);
	tryAddDaysToTimestamp_m(timestamp, days, options, ans, err);
}

double dayStart_s(double timestamp,int timezoneOffset){
	SHError* err = getSHError();
	prepareSHError(err);
	double ans;
	tryDayStart_m(timestamp, timezoneOffset, &ans, err);
	return ans;
}

int calcWeekdayIdx_s(SHDatetime *dt){
	SHError* err = getSHError();
	prepareSHError(err);
	return calcWeekdayIdx_m(dt, err);
}

int calcDayOfYear_s(SHDatetime *dt){
	SHError* err = getSHError();
	prepareSHError(err);
	return calcDayOfYear_m(dt, err);
}

int calcDayOfYearFromTimestamp_s(double timestamp,int timezoneOffset){
	SHError* err = getSHError();
	prepareSHError(err);
	return calcDayOfYearFromTimestamp_m(timestamp, timezoneOffset, err);
}

int64_t dateDiffDays_s(SHDatetime const *A,SHDatetime const *B){
	SHError* err = getSHError();
	prepareSHError(err);
	return dateDiffDays_m(A, B, err);
}

double dateDiffSecs_s(SHDatetime const *A,SHDatetime const *B){
	SHError* err = getSHError();
	prepareSHError(err);
	return dateDiffSecs_m(A, B, err);
}
