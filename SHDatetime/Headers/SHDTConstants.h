//
//	DTConstants.h
//	SHCommon
//
//	Created by Joel Pridgen on 4/1/18.
//	Copyright © 2018 Joel Gillette. All rights reserved.
//

#ifndef SHDTConstants_h
#define SHDTConstants_h

#include <stdio.h>
#include <inttypes.h>

#define SH_WEEKLEN 7
extern const int32_t SH_DAYS_IN_WEEK;
extern const int32_t SH_BASE_YEAR;
extern const int32_t SH_FIRST_LEAP_YEAR;
extern const int32_t SH_BEFORE_EPOCH_BASE_YEAR;
extern const int32_t SH_YEAR_IN_MONTHS;
extern const int32_t SH_MIN_IN_SECONDS;
extern const int32_t SH_HOUR_IN_SECONDS;
extern const int32_t SH_DAY_IN_SECONDS;
extern const int32_t SH_SECONDS_PER_LEAP_YEAR;
extern const int32_t SH_SECONDS_PER_YEAR;
extern const int32_t SH_SECONDS_PER_4_YEARS;
extern const int64_t SH_SECONDS_PER_100_YEARS;
extern const int64_t SH_SECONDS_PER_LEAP_CENT;
extern const int64_t SH_SECONDS_PER_400_YEARS;
/*
 SH_SPECIAL_TIMESTAMP is meant to compliment one negative year
 and one negative month. It also has an effect on even non-leap years
 */
extern const int32_t SH_SPECIAL_TIMESTAMP;
extern const int32_t SH_WEEK_START_DAYS_AFTER;
extern const int32_t SH_EPOCH_WEEK_CORRECTION;
extern const int32_t SH_YEARS_PER_LEAP_CYCLE_SM;
extern const int32_t SH_LEAP_FEB_SUM;
extern const int32_t SH_MIN_SEC_LEN;
extern const int32_t SH_HOURS_PER_DAY;
extern const int32_t SH_EPOCH_NEUTRAL;
extern const int32_t SH_MIRROR_BEFORE_EPOCH;
extern const int32_t SH_INCLUDE_TODAY;
extern const int32_t SH_YEAR_CUSP;
extern const int32_t SH_NORMAL_YEAR_DAYS;
extern const int64_t SH_YEAR_ZERO_FIRST_SEC;
extern const int32_t SH_FEB;
extern const int32_t SH_BEST_LEAP_YEAR;
extern const int32_t SH_LEAP_COUNT_BETWEEN_1972_2000;
extern const int32_t SH_SPAN_1970_2000;
extern const int64_t SH_SPAN_1970_1899;
extern const char * const SH_WEEKDAYS[SH_WEEKLEN];

#endif /* SHDTConstants_h */
