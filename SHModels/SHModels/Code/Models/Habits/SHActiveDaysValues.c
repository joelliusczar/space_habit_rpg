//
//  SHActiveDaysValues.c
//  SHModels
//
//  Created by Joel Pridgen on 5/31/20.
//  Copyright © 2020 Joel Gillette. All rights reserved.
//

#include "SHActiveDaysValues.h"
#include <SHUtils_C/SHUtilConstants.h>
#include <stdlib.h>


int32_t SH_getIntervalSizeForType(struct SHActiveDaysValues *activeDays, SHIntervalType intervalType) {
	switch (intervalType) {
		case SH_DAILY_INTERVAL: return activeDays->dayIntevalSize;
		case SH_WEEKLY_INTERVAL: return activeDays->weekIntervalSize;
		case SH_MONTHLY_INTERVAL: return activeDays->monthIntervalSize;
		case SH_YEARLY_INTERVAL: return activeDays->yearIntervalSize;
		case SH_DAILY_INTERVAL_INVERSE: return activeDays->daySkipIntevalSize;
		case SH_WEEKLY_INTERVAL_INVERSE: return activeDays->weekSkipIntervalSize;
		case SH_MONTHLY_INTERVAL_INVERSE: return activeDays->monthSkipIntervalSize;
		case SH_YEARLY_INTERVAL_INVERSE: return activeDays->yearSkipIntervalSize;
		case SH_UNDETERMINED_INTERVAL: return SH_NOT_FOUND;
	}
	return SH_NOT_FOUND;
}


int32_t SH_getCurrentIntervalSize(struct SHActiveDaysValues *activeDays) {
	return SH_getIntervalSizeForType(activeDays, activeDays->intervalType);
}


void SH_setCurrentIntervalSize(struct SHActiveDaysValues *activeDays,
	SHIntervalType intervalType, int32_t size)
{
	switch (intervalType) {
		case SH_DAILY_INTERVAL:
			activeDays->dayIntevalSize = size;
			return;
		case SH_WEEKLY_INTERVAL:
			activeDays->weekIntervalSize = size;
			return;
		case SH_MONTHLY_INTERVAL:
			activeDays->monthIntervalSize = size;
			return;
		case SH_YEARLY_INTERVAL:
			activeDays->yearIntervalSize = size;
			return;
		case SH_DAILY_INTERVAL_INVERSE:
			activeDays->daySkipIntevalSize = size;
			return;
		case SH_WEEKLY_INTERVAL_INVERSE:
			activeDays->weekSkipIntervalSize = size;
			return;
		case SH_MONTHLY_INTERVAL_INVERSE:
			activeDays->monthSkipIntervalSize = size;
			return;
		case SH_YEARLY_INTERVAL_INVERSE:
			activeDays->yearSkipIntervalSize = size;
			return;
		case SH_UNDETERMINED_INTERVAL:
			return;
	}
}



void SH_setDayValue(struct SHActiveDaysValues *activeDays, int32_t idx,
	SHIntervalType intervalType, bool value)
{
	int32_t flipBit = (value ? 1 : 0) << idx;
	switch (intervalType) {
		case SH_DAILY_INTERVAL:
			return;
		case SH_WEEKLY_INTERVAL:
			activeDays->weekIntervalHash ^= flipBit;
			return;
		case SH_MONTHLY_INTERVAL:
	
			return;
		case SH_YEARLY_INTERVAL:
	
			return;
		case SH_DAILY_INTERVAL_INVERSE:
	
			return;
		case SH_WEEKLY_INTERVAL_INVERSE:
			activeDays->weekIntervalHash ^= flipBit;
			return;
		case SH_MONTHLY_INTERVAL_INVERSE:
	
			return;
		case SH_YEARLY_INTERVAL_INVERSE:
	
			return;
		case SH_UNDETERMINED_INTERVAL:
			return;
	}
}


bool SH_getDayValue(struct SHActiveDaysValues *activeDays, int32_t idx,
	SHIntervalType intervalType)
{
	
	switch (intervalType) {
		case SH_DAILY_INTERVAL: return true;
		case SH_WEEKLY_INTERVAL:
		{
			int32_t bitMask = 1 << idx;
			return activeDays->weekIntervalHash & bitMask > 0;
		}
		case SH_MONTHLY_INTERVAL: return false;
		case SH_YEARLY_INTERVAL: return false;
		case SH_DAILY_INTERVAL_INVERSE: return false;
		case SH_WEEKLY_INTERVAL_INVERSE:
		{
			int32_t bitMask = 1 << idx;
			return activeDays->weekSkipIntervalHash & bitMask > 0;
		}
		case SH_MONTHLY_INTERVAL_INVERSE: return false;
		case SH_YEARLY_INTERVAL_INVERSE: return false;
		case SH_UNDETERMINED_INTERVAL: return false;
	}
	return false;
}


void SH_freeActiveDaysValues(struct SHActiveDaysValues *activeDays) {
	free(activeDays->yearIntervalHash);
	free(activeDays->yearSkipIntervalHash);
	free(activeDays);
}


