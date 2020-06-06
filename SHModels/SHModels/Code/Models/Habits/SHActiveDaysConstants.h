//
//  SHActiveDaysConstants.h
//  SHModels
//
//  Created by Joel Pridgen on 6/6/20.
//  Copyright © 2020 Joel Gillette. All rights reserved.
//

#ifndef SHActiveDaysConstants_h
#define SHActiveDaysConstants_h

#include <stdio.h>
#include <inttypes.h>

#define SH_INVERSE_INTERVAL_MODIFIER (1<<7)

typedef enum {
	SH_UNDETERMINED_INTERVAL = 0,
	SH_DAILY_INTERVAL = 1 << 0,
	SH_WEEKLY_INTERVAL = 1 << 1,
	SH_MONTHLY_INTERVAL = 1 << 2,
	SH_YEARLY_INTERVAL = 1 << 3,
	SH_DAILY_INTERVAL_INVERSE = SH_DAILY_INTERVAL | SH_INVERSE_INTERVAL_MODIFIER,
	SH_WEEKLY_INTERVAL_INVERSE = SH_WEEKLY_INTERVAL | SH_INVERSE_INTERVAL_MODIFIER,
	SH_MONTHLY_INTERVAL_INVERSE = SH_MONTHLY_INTERVAL | SH_INVERSE_INTERVAL_MODIFIER,
	SH_YEARLY_INTERVAL_INVERSE = SH_YEARLY_INTERVAL | SH_INVERSE_INTERVAL_MODIFIER,
} SHIntervalType;


extern const int32_t SH_FULL_WEEK_HASH;
extern const int64_t SH_FULL_MONTH_HASH;
extern const char * const SH_FULL_YEAR_HASH;

#endif /* SHActiveDaysConstants_h */
