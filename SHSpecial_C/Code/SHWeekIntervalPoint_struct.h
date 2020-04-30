//
//	RateValueItem.h
//	SH_C
//
//	Created by Joel Pridgen on 1/27/19.
//	Copyright © 2019 Joel Gillette. All rights reserved.
//

#ifndef SHWeekIntervalPoint_struct_h
#define SHWeekIntervalPoint_struct_h

#define shFreeSHWeekIntervalPoint(intervalPoints) free(intervalPoints)

#include <inttypes.h>
#include <stdbool.h>
#include "SHDTConstants.h"

struct SHWeekIntervalPoint {
	bool isDayActive;
	int32_t backrange;
	int32_t forrange;
	uintptr_t filler[4];
};


struct SHWeekIntervalPointList {
	struct SHWeekIntervalPoint days[SH_WEEKLEN];
};


#endif /* SHWeekIntervalPoint_struct_h */
