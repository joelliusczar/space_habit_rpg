//
//	SHDateTime_struct.h
//	SHDatetime
//
//	Created by Joel Pridgen on 4/14/18.
//	Copyright © 2018 Joel Gillette. All rights reserved.
//

#ifndef SHDatetime_struct_h
#define SHDatetime_struct_h

#include <inttypes.h>
#include <stdbool.h>


struct SHTimeshift{
	int32_t month;
	int32_t day;
	int32_t hour;
	int32_t minute;
	int32_t adjustment;
	uintptr_t filler[8];
};

struct SHDatetime {
	int64_t year;
	double timestamp;
	double timeOfDay;
	struct SHTimeshift *shifts;
	int32_t month;
	int32_t day;
	int32_t hour;
	int32_t minute;
	int32_t second;
	int32_t milisecond;
	int32_t timezoneOffset;
	int32_t shiftLen;
	int32_t currentShiftIdx;
	bool isTimestampValid;
	uintptr_t filler[8];
};


typedef enum {SH_TIME_ADJUST_NO_OPTION = 0,
	SH_TIME_ADJUST_SHIFT_FWD = 1,
	SH_TIME_ADJUST_SHIFT_BKD = 2,
	SH_TIME_ADJUST_ERROR = 3,
	SH_TIME_ADJUST_SIMPLE = 4,
} SHTimeAdjustOptions;


#endif /* SHDatetime_struct_h */
