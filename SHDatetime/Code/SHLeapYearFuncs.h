//
//  SHLeapYearFuncs.h
//  SHDatetime
//
//  Created by Joel Pridgen on 5/1/20.
//  Copyright © 2020 Joel Gillette. All rights reserved.
//

#ifndef SHLeapYearFuncs_h
#define SHLeapYearFuncs_h

#include "SHDatetime_struct.h"
#include <stdio.h>
#include <inttypes.h>
#include <stdbool.h>

/*
	this assumes that years starts at 0. So, don't send actual years to
 this. For actual years, using either _isLeapYearCorrected or
 _isLeapYearFromBaseYear (this one is based on the year 2000)
 */
bool SH_isOffsettedYearCountLeap(int64_t years);

bool SH_isRawYearCountLeap(int64_t years, bool isBeforeEpoch);

bool SH_isLeapYear(int64_t year);

bool SH_isFeb29(struct SHDatetime *dt);


#endif /* SHLeapYearFuncs_h */
