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
	uint8_t yearIntervalHash[46];
	uint8_t yearSkipIntervalHash[46];
	uint64_t monthIntervalHash;
	uint64_t monthSkipIntervalHash;
	uint32_t dayIntevalSize;
	uint32_t daySkipIntevalSize;
	uint32_t weekIntervalSize;
	uint32_t weekSkipIntervalSize;
	uint32_t monthIntervalSize;
	uint32_t monthSkipIntervalSize;
	uint32_t yearIntervalSize;
	uint32_t yearSkipIntervalSize;
	uint8_t weekSkipIntervalHash;
	uint8_t weekIntervalHash;
	uint8_t intervalType;
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
