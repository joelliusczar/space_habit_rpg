//
//	SHDateTime_struct.h
//	SHCommon
//
//	Created by Joel Pridgen on 4/14/18.
//	Copyright © 2018 Joel Gillette. All rights reserved.
//

#ifndef SHDatetime_struct_h
#define SHDatetime_struct_h

#include <inttypes.h>
#include <stdbool.h>

//prefer the macro over a method call, that way I'm not forcing the user
//to allocate memory on the heap, nor forcing them to do an extra copy
#define newDatetime_date(year,month,day) \
	{year,month,day,0,0,0,0,0,0,0,0,{0}}

#define newSHDatetime_datetime(year,month,day,hour,min,sec) \
	{year,month,day,hour,min,sec,0,0,0,0,0,{0}}

#define newSHDatetime_datetime2(year,month,day,hour,min,sec,millisec) \
	{year,month,day,hour,min,sec,millisec,0,0,0,0,{0}}



typedef struct{
	int32_t month;
	int32_t day;
	int32_t hour;
	int32_t minute;
	int32_t adjustment;
	uintptr_t filler[8];
}SHTimeshift;

typedef struct {
	int64_t year;
	int32_t month;
	int32_t day;
	int32_t hour;
	int32_t minute;
	int32_t second;
	int32_t milisecond;
	int32_t timezoneOffset;
	SHTimeshift *shifts;
	int32_t shiftLen;
	int32_t currentShiftIdx;
	double timestamp;
	double timeOfDay;
	bool isTimestampValid;
	uintptr_t filler[8];
} SHDatetime;


typedef enum {SH_TIME_ADJUST_NO_OPTION = 0,
	SH_TIME_ADJUST_SHIFT_FWD = 1,
	SH_TIME_ADJUST_SHIFT_BKD = 2,
	SH_TIME_ADJUST_ERROR = 3,
	SH_TIME_ADJUST_SIMPLE = 4,
} SHTimeAdjustOptions;


#endif /* SHDatetime_struct_h */
