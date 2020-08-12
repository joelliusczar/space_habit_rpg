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
#include <SHDatetime/SHDatetime.h>
#include "SHDBDueDateConstants.h"
#include <stdio.h>
#include <stdbool.h>

struct SHDaily {
	struct SHHabitBase base; //+ 32 bytes
	struct SHActiveDaysValues activeDays; // + 18 = 50
	double *activeFromDateTime;
	double *activeToDateTime;
	char * note; //= 55
	int32_t customUseOrder;
	int32_t dayStartTime;
	int32_t difficulty;
	int32_t urgency;
	int32_t stepCountMax;
	int32_t streakLength;
	bool activeFromHasPriority;
	bool isEnabled;
	bool lastUpdateHasPriority;
	uint8_t padding[1];
};


struct SHTableDaily {
	int64_t pk;
	char *name;
	int32_t maxStreak;
	int32_t dailyLvl;
	int32_t dailyXp;
	int32_t customUseOrder;
	int32_t streakLength;
	int32_t stepCountMax;
	int32_t stepCount;
	struct SHDatetime *savedUseDate;
	struct SHDatetime *nextDueDate;
	struct SHDatetime *stepLastActivationDateTime;
	struct SHDatetime *fullLastActivationDateTime;
	SHDueDateStatus dueStatus;
};

void SH_cleanupTableDaily(struct SHTableDaily *tableDaily);
void SH_cleanupTableDailyProps(struct SHTableDaily *tableDaily);
void SH_freeDaily(struct SHDaily *daily);
void SH_freeDailyProps(struct SHDaily *daily);

#endif /* SHDaily_struct_h */
