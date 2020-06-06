//
//  SHActiveDaysValues.h
//  SHModels
//
//  Created by Joel Pridgen on 5/31/20.
//  Copyright © 2020 Joel Gillette. All rights reserved.
//

#ifndef SHActiveDaysValues_h
#define SHActiveDaysValues_h

#include "SHActiveDaysConstants.h"
#include <stdio.h>
#include <inttypes.h>
#include <stdbool.h>

struct SHActiveDaysValues {
	SHIntervalType intervalType;
	int32_t dayIntevalSize;
	int32_t weekIntervalHash;
	int32_t weekIntervalSize;
	int64_t monthIntervalHash;
	int32_t monthIntervalSize;
	char * yearIntervalHash;
	int32_t yearIntervalSize;
	int32_t daySkipIntevalSize;
	int32_t weekSkipIntervalHash;
	int32_t weekSkipIntervalSize;
	int64_t monthSkipIntervalHash;
	int32_t monthSkipIntervalSize;
	char * yearSkipIntervalHash;
	int32_t yearSkipIntervalSize;
};

int32_t SH_getCurrentIntervalSize(struct SHActiveDaysValues *activeDays);
int32_t SH_getIntervalSizeForType(struct SHActiveDaysValues *activeDays, SHIntervalType intervalType);
void SH_setCurrentIntervalSize(struct SHActiveDaysValues *activeDays, SHIntervalType intervalType, int32_t size);
void SH_freeActiveDaysValues(struct SHActiveDaysValues *activeDays);
void SH_setDayValue(struct SHActiveDaysValues *activeDays, int32_t idx,
	SHIntervalType intervalType, bool value);
bool SH_getDayValue(struct SHActiveDaysValues *activeDays, int32_t idx,
	SHIntervalType intervalType);

#endif /* SHActiveDaysValues_h */
