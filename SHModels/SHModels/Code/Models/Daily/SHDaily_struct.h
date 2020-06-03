//
//  SHDaily_struct.h
//  SHData
//
//  Created by Joel Pridgen on 5/20/20.
//  Copyright © 2020 Joel Gillette. All rights reserved.
//

#ifndef SHDaily_struct_h
#define SHDaily_struct_h

#include "SHHabitBase.h"
#include "SHDBDueDateConstants.h"
#include "SHActiveDaysValues.h"
#include <stdio.h>
#include <stdbool.h>

struct SHDaily {
	struct SHHabitBase base;
	struct SHActiveDaysValues activeDays;
	double *activeFromDateTime;
	double *activeToDateTime;
	double *lastActivationDateTime;
	int32_t maxStreak;
	bool activeFromHasPriority;
	bool isEnabled;
	bool lastUpdateHasPriority;
	int32_t weekIntervalHash;
	char * note;
	int32_t dailyLvl;
	int32_t dailyXp;
	int32_t customUseOrder;
	int32_t dayStartTime;
	int32_t difficulty;
	int32_t urgency;
	int32_t streakLength;
	int32_t tzOffsetLastActivationDateTime;
};

void SH_freeDaily(struct SHDaily *daily);
void SH_freeDailyProps(struct SHDaily *daily);

#endif /* SHDaily_struct_h */
