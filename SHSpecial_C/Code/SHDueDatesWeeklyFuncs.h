//
//	SHDaily_c.h
//	SHModels
//
//	Created by Joel Pridgen on 4/17/18.
//	Copyright © 2018 Joel Gillette. All rights reserved.
//

#ifndef SHDueDatesWeeklyFuncs_h
#define SHDueDatesWeeklyFuncs_h

#include <stdio.h>
#include <stdbool.h>
#include <inttypes.h>
#include "SHDatetimeFuncs.h"
#include "SHErrorHandling.h"
#include "SHWeekIntervalPoint_struct.h"
#include "SHDueDateWeeklyContext_struct.h"



void SH_fillWeek(int32_t *daysAheadCounts, int32_t *daysBeforeCounts,
	struct SHWeekIntervalPointList *intervalPoints);

void SH_refreshWeek(struct SHWeekIntervalPointList *intervalPoints, int32_t intervalSize);

SHErrorCode SH_previousDueDate_WEEKLY(struct SHDatetime *useDate, struct SHDueDateWeeklyContext *input,
	struct SHDatetime *ans);

SHErrorCode SH_bothWeeklyDueDatesFromLastDueDate(struct SHDatetime *useDate, struct SHDueDateWeeklyContext *input,
	struct SHDatetime **ans, int32_t *ansLen);

SHErrorCode SH_nextDueDate_WEEKLY(struct SHDatetime *useDate, struct SHDueDateWeeklyContext *input,
	struct SHDatetime *ans);

SHErrorCode SH_isDateADueDate_WEEKLY(struct SHDatetime *useDate, struct SHDueDateWeeklyContext *input,
	bool *ans);

int32_t SH_calcDaysAgoDayWasActive(int32_t weekdayIdx, int32_t intervalSize);

SHErrorCode SH_backupDateForReferenceDate(struct SHDatetime *useDate, struct SHDueDateWeeklyContext *input,
	struct SHDatetime *ans);

SHErrorCode SH_isWeekActiveForDate(struct SHDatetime *useDate, struct SHDueDateWeeklyContext *input,
	bool *ans);

SHErrorCode SH_findBackupDateForUseDate(struct SHDatetime *useDate, struct SHDueDateWeeklyContext *context,
	struct SHDatetime *ans);
/*
 activeDays: an array of exactly 7 elements.
 intervalSize: this is the frequency, ex: event happens every 3 weeks
 intervalPoints: this should be an array of 7 elements. Any values in this will get over written
 void buildWeek(bool *activeDays,int64_t scaler,RateValueItem *intervalPoints)
 */
#endif /* SHDueDatesWeeklyFuncs_h */
