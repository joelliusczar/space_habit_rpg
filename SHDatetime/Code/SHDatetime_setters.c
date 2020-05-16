//
//  SHDatetime_setters.c
//  SHDatetime
//
//  Created by Joel Pridgen on 5/1/20.
//  Copyright © 2020 Joel Gillette. All rights reserved.
//

#include "SHDatetime_setters.h"
#include "SHDatetime_boundsChecking.h"
#include "SHDTConstants.h"
#include <assert.h>


void SH_dtSetTimezoneOffset(struct SHDatetime *dt, int32_t timezoneOffset) {
	assert(dt);
	dt->timezoneOffset = timezoneOffset;
	dt->isTimestampValid = false;
}


void SH_dtSetYear(struct SHDatetime *dt, int32_t year) {
	assert(dt);
	dt->year = year;
	dt->isTimestampValid = false;
}


void SH_dtSetMonth(struct SHDatetime *dt, int32_t month) {
	assert(dt);
	assert(month < 13 && month > 0);
	dt->month = month;
	dt->isTimestampValid = false;
}


void SH_dtSetDay(struct SHDatetime *dt, int32_t day) {
	assert(dt);
	dt->day = day;
	dt->isTimestampValid = false;
	assert(SH_areTimeComponentsValid(dt));
}


void SH_dtSetHour(struct SHDatetime *dt, int32_t hour) {
	assert(dt);
	assert(hour >= 0 && hour < 24);
	dt->hour = hour;
	dt->isTimestampValid = false;
}


void SH_dtSetMinute(struct SHDatetime *dt, int32_t minute) {
	assert(dt);
	assert(minute >= 0 && minute < 60);
	dt->minute = minute;
	dt->isTimestampValid = false;
}


void SH_dtSetSecond(struct SHDatetime *dt, int32_t second) {
	assert(dt);
	assert(second >= 0 && second < 60);
	dt->second = second;
	dt->isTimestampValid = false;
}


void SH_dtSetMilisecond(struct SHDatetime *dt, int32_t milisecond) {
	assert(dt);
	dt->milisecond = milisecond;
	dt->isTimestampValid = false;
}


void SH_dtSetToTimeOfDay(struct SHDatetime *dt, int32_t timeOfDay){
	shLog("SH_dtSetToTimeOfDay");
	assert(dt);
	assert(timeOfDay >= 0 && timeOfDay < SH_DAY_IN_SECONDS);
	dt->hour = (timeOfDay / SH_HOUR_IN_SECONDS);
	dt->minute = (timeOfDay % SH_HOUR_IN_SECONDS) / SH_MIN_IN_SECONDS;
	dt->second = ((timeOfDay % SH_HOUR_IN_SECONDS) % SH_MIN_IN_SECONDS);
	dt->milisecond = 0;
	dt->isTimestampValid = false;
	shLog("leaving SH_dtSetToTimeOfDay");
}
