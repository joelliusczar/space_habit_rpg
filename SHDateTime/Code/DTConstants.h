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

#define WEEKLEN 7
extern const int BASE_YEAR;
extern const int BEFORE_EPOCH_BASE_YEAR;
extern const int FIRST_LEAP_YEAR;
extern const int LEAP_YEAR_BEFORE_EPOCH;
extern const int YEAR_IN_MONTHS;
extern const int MIN_IN_SECONDS;
extern const int HOUR_IN_SECONDS;
extern const int DAY_IN_SECONDS;
extern const int LAST_SECOND_OF_DAY;
extern const int SECONDS_PER_LEAP_YEAR;
extern const int SECONDS_PER_YEAR;
extern const int SECONDS_PER_4_YEARS;
extern const long SECONDS_PER_100_YEARS;
extern const long SECONDS_PER_LEAP_CENT;
extern const long SECONDS_PER_400_YEARS;
/*
 SPECIAL_TIMESTAMP is meant to compliment one negative year
 and one negative month. It also has an effect on even non-leap years
 */
extern const int SPECIAL_TIMESTAMP;
extern const int LAST_SECOND_OF_REGULAR_YEAR;
extern const int WEEK_START_DAYS_BEFORE;
extern const int WEEK_START_DAYS_AFTER;
extern const int EPOCH_WEEK_CORRECTION;
extern const int TIMESTAMP_BEGIN_1972;
extern const int TIMESTAMP_END_1968;
extern const int YEARS_PER_LEAP_CYCLE_SM;
extern const int DAYS_PER_LEAP_CYCLE_SM;
extern const int OFFSET_LEAP_YEAR;
extern const int LEAP_FEB_SUM;
extern const int MIN_SEC_LEN;
extern const int HOURS_PER_DAY;
extern const int EPOCH_NEUTRAL;
extern const int MIRROR_BEFORE_EPOCH;
extern const int INCLUDE_TODAY;
extern const int YEAR_CUSP;
extern const int NORMAL_YEAR_DAYS;
extern const int DAYS_PER_LEAP_YEAR;
extern const long YEAR_ZERO_FIRST_SEC;
extern const int FEB;
extern const int BEST_LEAP_YEAR;
extern const int LEAP_COUNT_BETWEEN_1972_2000;
extern const int SPAN_1970_2000;
extern const long SPAN_1970_1899;
extern const double MILLION;
extern const double BILLION;
extern const char * const WEEKDAYS[WEEKLEN];
#endif /* DTConstants_h */
