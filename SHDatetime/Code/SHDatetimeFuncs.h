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
#include "SHDatetime_setters.h"


SHErrorCode SH_dtToTimeOfDay(struct SHDatetime * const dt, double *ans);

SHErrorCode SH_timestampToDt(double timestamp, int32_t timezoneOffset, struct SHDatetime *ans);

SHErrorCode SH_dtToTimestamp(struct SHDatetime *const dt,double *ans);

SHErrorCode SH_addYearsToDt(struct SHDatetime *dt, int64_t years, SHTimeAdjustOptions options);

SHErrorCode SH_addMonthsToDt(struct SHDatetime *dt, int64_t months, SHTimeAdjustOptions options);

SHErrorCode SH_addDaysToDt(struct SHDatetime *dt, int64_t days, SHTimeAdjustOptions options);

void SH_setToDayStart(struct SHDatetime *dt);

int32_t SH_weekdayIdx(struct SHDatetime * const dt, int32_t dayOffset);

int32_t SH_calcDayOfYear(struct SHDatetime *dt);

SHErrorCode SH_dateDiffSeconds(struct SHDatetime * const fromDt, struct SHDatetime * const toDt, double *ans);

SHErrorCode SH_dateDiffDays(struct SHDatetime * const fromDt,struct SHDatetime * const toDt, int64_t *ans);

SHErrorCode SH_dateDiffFullWeeks(struct SHDatetime * const fromDt, struct SHDatetime * const toDt,
	int32_t dayOffset, int64_t *ans);

void SH_DTToString(struct SHDatetime const *dt,char* str);

void SH_freeSHDatetime(struct SHDatetime *dtObj, int32_t len);

void SH_freeSHTimeshift(struct SHTimeshift *tsObj);

SHErrorCode SH_weekStart(struct SHDatetime *dt, int32_t dayOffset);

SHErrorCode SH_nextWeekStart(struct SHDatetime *dt, int32_t dayOffset);
	
SHErrorCode SH_areSameWeek(struct SHDatetime * const A, struct SHDatetime * const B,
	int32_t dayOffset, bool *ans);
	
 /* SHDatetimeFuncs_h */

#endif
