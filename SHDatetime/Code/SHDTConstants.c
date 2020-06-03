//
//	DTConstants.c
//	SHDatetime
//
//	Created by Joel Pridgen on 4/1/18.
//	Copyright © 2018 Joel Gillette. All rights reserved.
//

#include "SHDTConstants.h"

const int32_t SH_DAYS_IN_WEEK = SH_WEEKLEN;
const int32_t SH_BASE_YEAR = 1970;
const int32_t SH_BEFORE_EPOCH_BASE_YEAR = 1969;
const int32_t SH_FIRST_LEAP_YEAR = 1972;
const int32_t SH_YEAR_IN_MONTHS = SH_MONTHCOUNT;
const int32_t SH_MIN_IN_SECONDS = 60;
const int32_t SH_HOUR_IN_SECONDS = 3600;
const int32_t SH_DAY_IN_SECONDS = 86400;
const int32_t SH_SECONDS_PER_YEAR = 31536000;
const int32_t SH_SECONDS_PER_LEAP_YEAR = 31622400;
const int32_t SH_SECONDS_PER_4_YEARS = 126230400;
const int64_t SH_SECONDS_PER_100_YEARS = 3155673600;
const int64_t SH_SECONDS_PER_LEAP_CENT = 3155759999;
const int64_t SH_SECONDS_PER_400_YEARS = 12622780800;
const int32_t SH_SPECIAL_TIMESTAMP = 31622400;
const int32_t SH_WEEK_START_DAYS_AFTER = 3;
const int32_t SH_EPOCH_WEEK_CORRECTION = 4;
const int32_t SH_YEARS_PER_LEAP_CYCLE_SM = 4;
const int32_t SH_LEAP_FEB_SUM = 60;
const int32_t SH_MIN_SEC_LEN = 60;
const int32_t SH_HOURS_PER_DAY = 24;
const int32_t SH_EPOCH_NEUTRAL = 1;
const int32_t SH_MIRROR_BEFORE_EPOCH = -1;
const int32_t SH_INCLUDE_TODAY = 1;
const int32_t SH_YEAR_CUSP = 0;
const int32_t SH_NORMAL_YEAR_DAYS = 365;
const int64_t SH_YEAR_ZERO_FIRST_SEC = -62168515200;
const int32_t SH_FEB = 2;
const int32_t SH_BEST_LEAP_YEAR = 2000;
const int32_t SH_LEAP_COUNT_BETWEEN_1972_2000 = 7;
const int32_t SH_SPAN_1970_2000 = 946684800;
const int64_t SH_SPAN_1970_1899 = -2208988800;
const char * const SH_WEEKDAYS[SH_WEEKLEN] = {"SUN","MON","TUE","WED","THR","FRI","SAT"};
const char * const SH_WEEKDAYS_FULLNAMES[SH_WEEKLEN] = {
	"Sunday",
	"Monday",
	"Tuesday",
	"Wednesday",
	"Thursday",
	"Friday",
	"Saturday"};

