//
//  SHWeeklyIntervalItermFunctions.h
//  SHSpecial_C
//
//  Created by Joel Pridgen on 4/21/20.
//  Copyright © 2020 Joel Gillette. All rights reserved.
//

#ifndef SHWeeklyIntervalItemFuncs_h
#define SHWeeklyIntervalItemFuncs_h


#include <stdio.h>
#include <inttypes.h>
#include "SHWeekIntervalPoint.h"

int32_t SH_findPrevActiveDayIdx(SHWeekIntervalPoint const * intervalPoints, int32_t weekdayIdx);
int32_t SH_activeDaysCountInRange(SHWeekIntervalPoint const * intervalPoints, int32_t startIdx, int32_t len);
int32_t SH_formatStrIntervalPoint(SHWeekIntervalPoint const * intervalPoint, char *str);
#endif /* SHWeeklyIntervalItermFunctions_h */
