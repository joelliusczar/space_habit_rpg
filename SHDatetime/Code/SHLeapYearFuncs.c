//
//  SHLeapYearFuncs.c
//  SHDatetime
//
//  Created by Joel Pridgen on 5/1/20.
//  Copyright © 2020 Joel Gillette. All rights reserved.
//

#include "SHLeapYearFuncs.h"
#include "SHDTConstants.h"

bool SH_isOffsettedYearCountLeap(int64_t years){
	return (years % 4 == 0) && ((years % 100 != 0) || (years % 400 == 0));
}


bool SH_isRawYearCountLeap(int64_t years, bool isBeforeEpoch){
	int32_t correction = isBeforeEpoch ? (1969 - 2000) : 2000 - 1970;
	return SH_isOffsettedYearCountLeap(years - correction);
}


bool SH_isLeapYear(int64_t year){
	return SH_isOffsettedYearCountLeap(year - SH_BEST_LEAP_YEAR);
}
