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
#include <stdio.h>

struct SHDaily {
	struct SHHabitBase base;
	double *activeFromDateTime;
	double *activeToDateTime;
	double *lastActivationDateTime;
	double *lastUpdateDateTime;
	bool activeFromHasPriority;
	bool isEnabled;
	bool lastUpdateHasPriority;
	unsigned char * activeDays;
	unsigned char * note;
	int32_t dailyLvl;
	int32_t dailyXp;
	int32_t customUseOrder;
	int32_t dayStartTime;
	int32_t difficulty;
	int32_t urgency;
	int32_t intervalType;
	int32_t lastUpdateTzOffset;
	int32_t streakLength;
	int32_t tzOffsetLastActivationDateTime;
	int32_t tzOffsetLastUpdateDateTime;
	int32_t pk;
};

#endif /* SHDaily_struct_h */
