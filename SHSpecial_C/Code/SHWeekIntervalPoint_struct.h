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

#include "SHDTConstants.h"
#include <inttypes.h>
#include <stdbool.h>

struct SHWeekIntervalPoint {
	int32_t backrange;
	int32_t forrange;
	bool isDayActive;
	uint8_t padding[7];
};


struct SHWeekIntervalPointList {
	struct SHWeekIntervalPoint days[SH_WEEKLEN];
};


#endif /* SHWeekIntervalPoint_struct_h */
