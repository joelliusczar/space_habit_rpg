//
//  DTConstants.h
//  SHCommon
//
//  Created by Joel Pridgen on 4/1/18.
//  Copyright © 2018 Joel Gillette. All rights reserved.
//

#ifndef DTConstants_h
#define DTConstants_h

#include <stdio.h>
#include <inttypes.h>

#define WEEKLEN 7
extern const int32_t DAYS_IN_WEEK;
extern const int32_t BASE_YEAR;
extern const int32_t BEFORE_EPOCH_BASE_YEAR;
extern const int32_t FIRST_LEAP_YEAR;
extern const int32_t LEAP_YEAR_BEFORE_EPOCH;
extern const int32_t YEAR_IN_MONTHS;
extern const int32_t MIN_IN_SECONDS;
extern const int32_t HOUR_IN_SECONDS;
extern const int32_t DAY_IN_SECONDS;
extern const int32_t SECONDS_PER_LEAP_YEAR;
extern const int32_t SECONDS_PER_YEAR;
extern const int32_t SECONDS_PER_4_YEARS;
extern const int64_t SECONDS_PER_100_YEARS;
extern const int64_t SECONDS_PER_LEAP_CENT;
extern const int64_t SECONDS_PER_400_YEARS;
/*
 SPECIAL_TIMESTAMP is meant to compliment one negative year
 and one negative month. It also has an effect on even non-leap years
 */
extern const int32_t SPECIAL_TIMESTAMP;
extern const int32_t WEEK_START_DAYS_AFTER;
extern const int32_t EPOCH_WEEK_CORRECTION;
extern const int32_t YEARS_PER_LEAP_CYCLE_SM;
extern const int32_t LEAP_FEB_SUM;
extern const int32_t MIN_SEC_LEN;
extern const int32_t HOURS_PER_DAY;
extern const int32_t EPOCH_NEUTRAL;
extern const int32_t MIRROR_BEFORE_EPOCH;
extern const int32_t INCLUDE_TODAY;
extern const int32_t YEAR_CUSP;
extern const int32_t NORMAL_YEAR_DAYS;
extern const int64_t YEAR_ZERO_FIRST_SEC;
extern const int32_t FEB;
extern const int32_t BEST_LEAP_YEAR;
extern const int32_t LEAP_COUNT_BETWEEN_1972_2000;
extern const int32_t SPAN_1970_2000;
extern const int64_t SPAN_1970_1899;
extern const char * const WEEKDAYS[WEEKLEN];
#endif /* DTConstants_h */
