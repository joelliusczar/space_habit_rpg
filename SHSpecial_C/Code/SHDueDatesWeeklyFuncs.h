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

SHErrorCode SH_previousDueDate_WEEKLY(struct SHDatetime *useDate, struct SHDueDateWeeklyContext *context,
	struct SHDatetime *ans);

SHErrorCode SH_bothWeeklyDueDatesFromLastDueDate(struct SHDatetime *useDate, struct SHDueDateWeeklyContext *context,
	struct SHDatetime **ans, int32_t *ansLen);

SHErrorCode SH_nextDueDate_WEEKLY(struct SHDatetime *useDate, struct SHDueDateWeeklyContext *context,
	struct SHDatetime *ans);

SHErrorCode SH_isDateADueDate_WEEKLY(struct SHDatetime *useDate, struct SHDueDateWeeklyContext *context,
	bool *ans);

SHErrorCode SH_isWeekActiveForDate(struct SHDatetime *useDate, struct SHDueDateWeeklyContext *context,
	bool *ans);

SHErrorCode SH_setUseDateToLastActive(struct SHDatetime *useDate, struct SHDueDateWeeklyContext *context);

SHErrorCode SH_missedDays_WEEKLY(struct SHDatetime *useDate, struct SHDueDateWeeklyContext *context, int64_t *ans);

#endif /* SHDueDatesWeeklyFuncs_h */
