//
//	SHDatetimeFuncs.h
//	SHDatetime
//
//	Created by Joel Pridgen on 8/25/18.
//	Copyright © 2018 Joel Gillette. All rights reserved.
//

#ifndef SHDatetimeFuncs_h
#define SHDatetimeFuncs_h

#include <stdio.h>
#include <stdbool.h>
#include <inttypes.h>
#include "SHErrorHandling.h"
#include "SHDTConstants.h"
#include "SHTimeZone.h"

void SH_dtSetTimezoneOffset(SHDatetime *dt, int32_t timezoneOffset);

SHErrorCode SH_dtToTimeOfDay(SHDatetime * const dt, double *ans);

SHErrorCode SH_timestampToDt(double timestamp, int32_t timezoneOffset, SHDatetime *ans);

SHErrorCode SH_dtToTimestamp(SHDatetime *const dt,double *ans);

SHErrorCode SH_addYearsToDt(SHDatetime *dt, int64_t years, SHTimeAdjustOptions options);

SHErrorCode SH_addMonthsToDt(SHDatetime *dt, int64_t months, SHTimeAdjustOptions options);

SHErrorCode SH_addDaysToDt(SHDatetime *dt, int64_t days, SHTimeAdjustOptions options);

void SH_setToDayStart(SHDatetime *dt);

int32_t SH_weekdayIdx(SHDatetime * const dt, int32_t dayOffset);

int32_t SH_calcDayOfYear(SHDatetime *dt);

SHErrorCode SH_dateDiffSeconds(SHDatetime * const A, SHDatetime * const B, double *ans);

SHErrorCode SH_dateDiffDays(SHDatetime * const A,SHDatetime * const B, int64_t *ans);

SHErrorCode SH_dateDiffFullWeeks(SHDatetime * const A, SHDatetime * const B, int32_t dayOffset, int64_t *ans);

void SH_DTToString(SHDatetime const *dt,char* str);

void shFreeSHDatetime(SHDatetime *dtObj,int32_t timeshiftLen);

void shFreeSHTimeshift(SHTimeshift *tsObj);

SHErrorCode SH_weekStart(SHDatetime * const dt, int32_t dayOffset, SHDatetime *ans);

SHErrorCode SH_nextWeekStart(SHDatetime * const dt, int32_t dayOffset, SHDatetime *ans);
	
SHErrorCode SH_areSameWeekWithDayOffset(SHDatetime * const A, SHDatetime * const B, int32_t dayOffset, bool *ans);

 /* SHDatetimeFuncs_h */

#endif
