//
//	SHDatetimeFuncs.c
//	SHDatetime
//
//	Created by Joel Pridgen on 8/25/18.
//	Copyright © 2018 Joel Gillette. All rights reserved.
//

#include "SHDatetimeFuncs.h"
#include "SHUtilConstants.h"
#include "SHGenAlgos.h"
#include "SHDatetime_boundsChecking.h"
#include "SHDayCounts.h"
#include "SHLeapYearFuncs.h"
#include "SHDatetime_addition.h"
#include <limits.h>
#include <stdbool.h>
#include <stdlib.h>
#include <math.h>
#include <assert.h>
#include <float.h>


typedef struct{
	int64_t totalMins;
	int32_t exSecs;
	int64_t totalHours;
	int64_t totalDays;
} TimeCalcResult;

typedef struct{
	double fraction;
	int32_t milisecond;
	int32_t microsecond;
} FractSecs;

static void _calcFractSecs(FractSecs *fractSecs, double timestamp);
static SHErrorCode _calcFractFromParts(double miliseconds,double* ans);
static bool _shouldAddLeapDay(int64_t year, int32_t month, int32_t day);


/*
 want to calculate the month based on how many days have passed
 in the year already.
 */
static int32_t _getMonthFromDaySum(int32_t daySum, bool isLeapYear){
	if(daySum < 1 || daySum > (366 + (isLeapYear?1:0))) return -1;
	if(daySum <= 31) return 1;
	if(daySum <= (59 + (isLeapYear ? 1 : 0))) return 2;
	if(daySum <= (90 + (isLeapYear ? 1 : 0))) return 3;
	if(daySum <= (120 + (isLeapYear ? 1 : 0))) return 4;
	if(daySum <= (151 + (isLeapYear ? 1 :0))) return 5;
	if(daySum <= (181 + (isLeapYear ? 1 :0))) return 6;
	if(daySum <= (212 + (isLeapYear ? 1 :0))) return 7;
	if(daySum <= (243 + (isLeapYear ? 1 :0))) return 8;
	if(daySum <= (273 + (isLeapYear ? 1 :0))) return 9;
	if(daySum <= (304 + (isLeapYear ? 1 :0))) return 10;
	if(daySum <= (334 + (isLeapYear ? 1 :0))) return 11;
	return 12;
}



static int64_t _calcNumLeapYearsWithCycleLen(int64_t year,int64_t cycleLen){
	/*There might be a simpler way to do determine this,
	 but I promise you, it's a bigger pain in the ass to get this
	 right than you might expect.
	 negative leap years are num of leap years before 2000,
	 pos are after. Either way, we get absolute value 2000 is just a convinient date
	 Leap leaps do not count themselves, that's one of the reasons why we don't
	 simply divide by 4(cycleLen) because we want 4/4 = 0, not 4/4 = 1, and
	 part of the reason we want that is because the 0-leap year:
	 2000 would be 0/4 = 0, so we want to maintain that pattern with the other
	 leap years.
	 Examples:
	 year = -6 -> mod= -6-(4*-6)=-6+24=18,-> (-6+4) -(18%4) = -2 -2=-4,->-4/4=-1
	 year = -5 -> mod= -5-(4*-5)=-5+20=15,-> (-5+4) -(15%4) = -1-3=-4,->-4/4=-1
	 year = -4 -> mod= -4-(4*-4)=-4+16=12,-> (-4+4) -(12%4) = 0-0=0,->0/4 =0;
	 year = -3 -> mod= -3-(4*-3)=-3+12=9, -> (-3+4) -(9%4)=1-1=0,-> 0/4 =0;
	 year = -2 -> mod= -2 -(4*-2)=-2+8=6, -> (-2+4) -(6%4)= 2-2 = 0,-> 0/4 = 0;
	 year = -1 -> mod= -1 -(4*-1) = -1+4=3, -> (-1+4) -(3%4)= 3-3 =0,-> 0/4 = 0;
	 (2001)year = 0 -> mod= 0 - (4*0)=0, -> (0+4) - (0%4) -> 4-0 -> 4 -> 4/4 = 1;
	 year=1 ->mod=1, -> (1+4) -(1%4)=5-1=0 -> 4/4 = 1;
	 year=2 -> mod=2, -> (2+4)-(2%4)=6-2=4 -> 4/4 = 1;
	 year=3 -> mod=3,-> (3+4)-(3%4)=7-3=4 -> 4/4 = 1;
	 year=4 -> mod=4,-> (4+4)-(4%4)=8-0=8-> 8/4 = 2
	 */
	int64_t mod = year > 0?year:year - (cycleLen*year); //
	int64_t multipleOfCycleLen = year + cycleLen - (mod % cycleLen);
	int64_t ans = (multipleOfCycleLen)/cycleLen;
	return ans;
	/*
	 for neg years, factor was abitrary. Can be any multiple of cycleLen
	 This is best explained with examples
	 for positive years: year = mod, so you can think of the operation
	 as shaving off the remainder so that it's a multiple of cycleLen
	 for negative years:
	 */
}

static int64_t _calcNumLeapYearsExclusive(int64_t year) {
	int64_t ans = _calcNumLeapYearsWithCycleLen(year, 4) -
		_calcNumLeapYearsWithCycleLen(year, 100) +
		_calcNumLeapYearsWithCycleLen(year, 400);
	return ans;
}

static int64_t _calcNumLeapYearsBaseLeap(int64_t year){
	/*
	 If year is greater than or equal to 2000 offset it by one
	 because even though 2000 is a leap year, we don't want to say
	 there's been 1 leap year in 2000. Besides, we already have an
	 offset for when the year itself is a leap year.
	 */
	int64_t dif = year - SH_BEST_LEAP_YEAR + (year >= SH_BEST_LEAP_YEAR?-1:0);
	int64_t ans = _calcNumLeapYearsExclusive(dif);
	/*We want to offset the leap to 2000 rather than 1972 since it will handle
	 multiples of 100 and 400 better. Our little window shift creates some problems
	 where the leap years between 1972 and 2000 don't align right.
	 So, we just do that here.
	 */
	if(year < SH_FIRST_LEAP_YEAR || year > SH_BEST_LEAP_YEAR || !SH_isOffsettedYearCountLeap(dif)){
		ans += SH_LEAP_COUNT_BETWEEN_1972_2000;
	}
	else{
		ans += (SH_LEAP_COUNT_BETWEEN_1972_2000 -1);
	}
	return ans < 0?-ans:ans;
}


/*
 	checks if year is a leap year and the date is after feb 28th
 */
static bool _shouldAddLeapDay(int64_t year, int32_t month, int32_t day){
	return SH_isLeapYear(year) && (month > 2 || (month == 2 && day > 28));
}


static int64_t _calcYearsFor20thCent(uint64_t seconds, bool isBefore1970){
	int64_t years = 0;
	int32_t leapExcess = seconds % SH_SECONDS_PER_4_YEARS;
	if(leapExcess >= 94694400){
		years = 3;
	}
	else if(leapExcess >= (isBefore1970 ? 63158400 : 63072000)){
		years = 2;
	}
	else if(leapExcess >= 31536000){
		years = 1;
	}
	
	int64_t leapCycles = seconds / SH_SECONDS_PER_4_YEARS;
	years += (leapCycles * SH_YEARS_PER_LEAP_CYCLE_SM);
	return years;
}


static int32_t _calcYearsBefore20thCent(int64_t seconds,bool isLeapCent){
	if(seconds < 0) return -1;
	int32_t years = 0;
	(void)isLeapCent;
	int32_t leapExcess = seconds % SH_SECONDS_PER_4_YEARS;
	if(leapExcess >= (3*SH_SECONDS_PER_YEAR)){
		years = 3;
	}
	else if(leapExcess >= (2*SH_SECONDS_PER_YEAR)){
		years = 2;
	}
	else if(leapExcess >= SH_SECONDS_PER_YEAR){
		years = 1;
	}
	int64_t leapCycles = seconds / SH_SECONDS_PER_4_YEARS;
	years += (leapCycles*4);
	return years;
}


static int64_t _calcYearsAfter20thCent(int64_t seconds,bool isLeapCent){
	if(seconds < 0) return -1;
	int64_t years = 0;
	if(!isLeapCent){
		//turn of normal century does not include leap year
		if(seconds < (4*SH_SECONDS_PER_YEAR)){
			for(int32_t yearFactor = 3;yearFactor > 0;yearFactor--){
				if(seconds >= (yearFactor*SH_SECONDS_PER_YEAR)){
						years = yearFactor;
						return years;
				}
			}
			return 0;
		}
		seconds -= 4*SH_SECONDS_PER_YEAR; //shave off the non-leap year segment
		years += 4;
	}
	int32_t leapExcess = seconds % SH_SECONDS_PER_4_YEARS;
	if(leapExcess >= (2*SH_SECONDS_PER_YEAR + SH_SECONDS_PER_LEAP_YEAR)){
		years += 3;
	}
	else if(leapExcess >= (SH_SECONDS_PER_YEAR + SH_SECONDS_PER_LEAP_YEAR)){
		years += 2;
	}
	else if(leapExcess >= SH_SECONDS_PER_LEAP_YEAR){
		years += 1;
	}
	
	int64_t leapCycles = seconds / SH_SECONDS_PER_4_YEARS;
	years += (leapCycles*SH_YEARS_PER_LEAP_CYCLE_SM);
	return years;
}

static int64_t _calcYearsPastPerQuadricentennial(int64_t seconds){
	int64_t years = 0;
	int64_t leapExcess = 0;
	int64_t leapCycles = 0;
	if(seconds > SH_SECONDS_PER_400_YEARS){
		leapCycles = seconds / SH_SECONDS_PER_400_YEARS;
		seconds %= SH_SECONDS_PER_400_YEARS;
		years += leapCycles * 400;
	}
	if(seconds > (3 * SH_SECONDS_PER_100_YEARS)){
		seconds -= (3 * SH_SECONDS_PER_100_YEARS);
		years += 300;
		return years + _calcYearsBefore20thCent(seconds, true);
	}
	leapExcess = seconds % SH_SECONDS_PER_100_YEARS;
	leapCycles = seconds / SH_SECONDS_PER_100_YEARS;
	
	years += _calcYearsBefore20thCent(leapExcess, false);
	
	years += leapCycles * 100;
	return years;
}


static int64_t _calcYearsPerQuadricentennial(int64_t seconds){
	int64_t years = 0;
	int64_t leapExcess = 0;
	int64_t leapCycles = 0;
	if(seconds > SH_SECONDS_PER_400_YEARS){
		leapCycles = seconds / SH_SECONDS_PER_400_YEARS;
		seconds %= SH_SECONDS_PER_400_YEARS;
		years += leapCycles * 400;
	}
	
	if(seconds <= (SH_SECONDS_PER_LEAP_CENT)){
		return years + _calcYearsAfter20thCent(seconds,true);
	}
	
	years += 100;
	seconds -= (SH_SECONDS_PER_LEAP_CENT + 1);
	
	leapExcess = seconds % SH_SECONDS_PER_100_YEARS;
	leapCycles = seconds / SH_SECONDS_PER_100_YEARS;
	years += _calcYearsAfter20thCent(leapExcess,false);
	years += leapCycles * 100;
	return years;
}


static int64_t _calcYears(int64_t seconds){
	int64_t years = 0;
	seconds += (seconds < 0 ? 1 : 0);
	if(seconds > SH_SPAN_1970_2000){
		seconds -= SH_SPAN_1970_2000;
		years = 30;
		return years + _calcYearsPerQuadricentennial(seconds);
	}
	else if(seconds <= SH_SPAN_1970_1899){
		seconds -= SH_SPAN_1970_1899;
		years = 70;
	
		if(seconds < -(2 * SH_SECONDS_PER_100_YEARS + SH_SECONDS_PER_LEAP_CENT + 1)){ //year before 1600
			years += 300;
			seconds +=(2 * SH_SECONDS_PER_100_YEARS + SH_SECONDS_PER_LEAP_CENT + 1);
			return years + _calcYearsPastPerQuadricentennial(-seconds);
		}
		//years between 1600 and 1700
		if(seconds <= -(2 * SH_SECONDS_PER_100_YEARS)){
			years += 2 * 100;
			seconds += (2 * SH_SECONDS_PER_100_YEARS);
			return years + _calcYearsBefore20thCent(-seconds, true);
		}
	
		for(int32_t cents = 1;cents >= 0;cents--){
			if(seconds <= -cents * SH_SECONDS_PER_100_YEARS){
					years += cents * 100;
					seconds += (cents * SH_SECONDS_PER_100_YEARS);
					return years + _calcYearsBefore20thCent(-seconds, false);
			}
		}
	}
	return _calcYearsFor20thCent(labs(seconds), seconds < 0);
}


static void _setTimeFromTimeCalcResult(int64_t timestamp, int32_t minOffset, TimeCalcResult *result){
	result->totalMins = timestamp / SH_MIN_IN_SECONDS;
	result->exSecs = timestamp % 60;
	result->totalMins += ((result->exSecs + minOffset) / 60);
	result->totalHours = result->totalMins / 60;
	result->totalDays = result->totalHours / 24;
}


static void _filDateTimeObj(int64_t year, int32_t month, int32_t day, int32_t hour,
	int32_t min, int32_t sec, double milisecs, struct SHDatetime *dt) {
	dt->year = year;
	dt->month = month;
	dt->day = day;
	dt->hour = hour;
	dt->minute = min;
	dt->second = sec;
	dt->milisecond = milisecs;
	dt->shifts = NULL;
	dt->shiftLen = 0;
	dt->timeOfDay = (hour * SH_HOUR_IN_SECONDS + min * SH_MIN_IN_SECONDS + sec + milisecs);
	dt->isTimestampValid = true;
	dt->currentShiftIdx = SH_NOT_FOUND;
}


static int64_t _calcSecondsPassedInYear(int64_t timestamp, int64_t years, bool isBeforeEpoch){
	if(years > 1){
		return (timestamp % (years * SH_SECONDS_PER_YEAR));
	}
	else if(years == 1){
		return timestamp + (isBeforeEpoch ? SH_SECONDS_PER_YEAR : -SH_SECONDS_PER_YEAR);
	}
	/*
		year is 0, so 1970 or 1969
	*/
	return timestamp;
}


SHErrorCode SH_timestampToDt(double timestamp, int32_t timezoneOffset, struct SHDatetime *ans){
	assert(ans);
	SHErrorCode status;
	if((status = SH_isTimestampRangeInvalid(timestamp,timezoneOffset)) != SH_NO_ERROR) {
		SH_notifyOfError(status,"Could not convert timestamp to datetime obj");
		goto cleanup;
	}
	ans->timestamp = timestamp;
	FractSecs fractSec;
	_calcFractSecs(&fractSec, timestamp);
	if(timestamp - timezoneOffset == 0){
		_filDateTimeObj(SH_BASE_YEAR ,1, 1, 0, 0, 0, fractSec.milisecond ,ans);
		goto success;
	}
	timestamp += timezoneOffset;
	bool isBeforeEpoch = timestamp < 0;
	int64_t totalYears = _calcYears(timestamp);
	bool isLeapYear = SH_isRawYearCountLeap(totalYears, isBeforeEpoch);
	int64_t secondsPassedInYear = _calcSecondsPassedInYear(timestamp, totalYears, isBeforeEpoch);
	totalYears *= (isBeforeEpoch ? SH_MIRROR_BEFORE_EPOCH : SH_EPOCH_NEUTRAL);
	int32_t baseYear = isBeforeEpoch ? 1969 : 1970;
	if(secondsPassedInYear == SH_YEAR_CUSP){
		_filDateTimeObj(baseYear + totalYears, 1, 1, 0, 0, 0, fractSec.milisecond, ans);
		goto success;
	}
	int64_t leapCount = _calcNumLeapYearsBaseLeap(totalYears+baseYear);
	if(isBeforeEpoch){
		int64_t complimentYear = (isLeapYear ? SH_SPECIAL_TIMESTAMP : SH_SECONDS_PER_YEAR)
			+ leapCount * SH_DAY_IN_SECONDS;
		secondsPassedInYear = (complimentYear + secondsPassedInYear);
	}
	TimeCalcResult result;
	_setTimeFromTimeCalcResult(secondsPassedInYear, 0, &result);
	int32_t exDays = (int32_t)result.totalDays + SH_INCLUDE_TODAY;
	exDays -= (!isBeforeEpoch ? leapCount : 0);
	int32_t month = _getMonthFromDaySum(exDays, isLeapYear);
	int32_t currentLeapOffset = (isLeapYear && exDays > SH_LEAP_FEB_SUM ? 1 : 0);
	exDays -= currentLeapOffset;
	exDays -= SH_monthSums[month-1];
	int32_t exHours = result.totalHours % SH_HOURS_PER_DAY;
	int32_t exMins = result.totalMins % SH_MIN_SEC_LEN;
	_filDateTimeObj(totalYears+baseYear, month, exDays, exHours, exMins,
		result.exSecs, fractSec.milisecond, ans);
	success:
	cleanup:
		return status;
}


static double _dtToTimestamp1970AndAfter(struct SHDatetime * const dt) {
	double sum = 0;
	int64_t leapYearCount = _calcNumLeapYearsBaseLeap(dt->year);
	bool isLeapYear = SH_isLeapYear(dt->year);
	int64_t span = dt->year - SH_BASE_YEAR;
	int32_t dayTotal = SH_monthSums[dt->month - 1];
	int64_t yearStart = span * SH_DAY_IN_SECONDS * 365 + SH_DAY_IN_SECONDS * leapYearCount;
	dayTotal += (dt->day-1);
	int32_t FEB_DAY_SUM = 59;
	int32_t leapDayOffset = isLeapYear &&
	(dayTotal > FEB_DAY_SUM || (dt->month == 3 && dayTotal == FEB_DAY_SUM)) ? 1 : 0;
	sum = yearStart + dayTotal * SH_DAY_IN_SECONDS + leapDayOffset * SH_DAY_IN_SECONDS;
	int32_t timeOfDay = (dt->hour * SH_HOUR_IN_SECONDS + dt->minute * SH_MIN_IN_SECONDS + dt->second);
	dt->timeOfDay = timeOfDay;
	sum += timeOfDay;
	return sum;
}


static double _dtToTimestampBefore1970(struct SHDatetime * const dt) {
	double sum = 0;
	int64_t leapYearCount = _calcNumLeapYearsBaseLeap(dt->year);
	bool isLeapYear = SH_isLeapYear(dt->year);
	int64_t span = dt->year - SH_BASE_YEAR + 1;
	int32_t dayTotal = SH_backwardMonthSums[dt->month-1];
	int64_t yearStart = span * SH_DAY_IN_SECONDS * SH_NORMAL_YEAR_DAYS - SH_DAY_IN_SECONDS * leapYearCount;
	dt->day = dt->day - SH_monthCount[dt->month - 1] - (isLeapYear && dayTotal >= 306 ? 1 : 0);
	dayTotal= dt->day - dayTotal;
	sum = yearStart + dayTotal * SH_DAY_IN_SECONDS;
	int32_t timeOfDay = ((dt->hour - 23) * SH_HOUR_IN_SECONDS + (dt->minute - 59) * SH_MIN_IN_SECONDS +
		(dt->second - 60));
	dt->timeOfDay = timeOfDay;
	sum += timeOfDay;
	return sum;
}


SHErrorCode SH_dtToTimestamp(struct SHDatetime * const dt,double *ans){
	shLog("SH_dtToTimestamp");
	SHErrorCode status = SH_NO_ERROR;
	assert(dt);
	assert(ans);
	if(dt->isTimestampValid) {
		*ans = dt->timestamp;
		goto success;
	}
	double fraction = 0.0;
	if((status = _calcFractFromParts(dt->milisecond, &fraction)) != SH_NO_ERROR) {
		goto cleanup;
	}
	/*
		even though this is only a utility function, and doesn't touch the file system,
		int overflow is possible so I'm doing a range check to protect against that
	*/
	if(!SH_areTimeComponentsValid(dt)) {
		SH_notifyOfError(SH_CORRUPT_STRUCT,"Date components are out of range");
		status = SH_CORRUPT_STRUCT;
		goto cleanup;
	}
	double sum = 0;
	if(dt->year >= SH_BASE_YEAR){
		sum = _dtToTimestamp1970AndAfter(dt);
	}
	else{
		sum = _dtToTimestampBefore1970(dt);
	}
	sum -= dt->timezoneOffset;
	sum += fraction * (dt->year < 1970 ? -1 : 1);
	*ans = sum;
	dt->timestamp = sum;
	dt->timeOfDay += fraction;
	dt->isTimestampValid = true;
	shLog("leaving SH_dtToTimestamp");
	success:
	cleanup:
		return status;
}

/*
	time of day is timezone relative, so this is not some sort of standardized time of day
*/
SHErrorCode SH_dtToTimeOfDay(struct SHDatetime *const dt, double *ans) {
	shLog("SH_dtToTimeOfDay");
	SHErrorCode status = SH_NO_ERROR;
	assert(dt);
	assert(ans);
	if(dt->isTimestampValid) {
		*ans = dt->timeOfDay;
		goto success;
	}
	double fraction = 0.0;
	if((status = _calcFractFromParts(dt->milisecond, &fraction)) != SH_NO_ERROR) {
		goto cleanup;
	}
	/*
		even though this is only a utility function, and doesn't touch the file system,
		int overflow is possible so I'm doing a range check to protect against that
	*/
	if(!SH_areTimeComponentsValid(dt)) {
		SH_notifyOfError(SH_CORRUPT_STRUCT,"Date components are out of range");
		status = SH_CORRUPT_STRUCT;
		goto cleanup;
	}
	if(dt->year >= SH_BASE_YEAR){
		int32_t timeOfDay = (dt->hour * SH_HOUR_IN_SECONDS + dt->minute * SH_MIN_IN_SECONDS + dt->second);
		*ans = timeOfDay;
	}
	else {
		int32_t timeOfDay = ((dt->hour - 23) * SH_HOUR_IN_SECONDS + (dt->minute - 59) * SH_MIN_IN_SECONDS +
			(dt->second - 60));
		*ans = timeOfDay;
	}
	success:
	cleanup:
		return status;
}



static int32_t _calcWeekdayIdx(struct SHDatetime * const dt){
	double timestamp = 0;
	if(SH_dtToTimestamp(dt, &timestamp) != SH_NO_ERROR) {
		SH_notifyOfError(SH_INPUT_BAD_RESULTS,"Could not determine weekday idx");
		return SH_NOT_FOUND;
	}
	int32_t ans = 0;
	timestamp += dt->timezoneOffset;
	bool isAfterEpoch = dt->year >= SH_BASE_YEAR;
	if(isAfterEpoch){
		int64_t totalDays = timestamp / SH_DAY_IN_SECONDS;
		//if within the first week
		if(totalDays < SH_WEEK_START_DAYS_AFTER){
				return (int32_t)totalDays + SH_EPOCH_WEEK_CORRECTION;
		}
		int64_t totalDaysOffset = totalDays - SH_WEEK_START_DAYS_AFTER;
		ans = totalDaysOffset % SH_DAYS_IN_WEEK;
		return ans;
	}
	int64_t totalDays = (timestamp / SH_DAY_IN_SECONDS);
	
	int64_t totalDaysOffset = totalDays - SH_WEEK_START_DAYS_AFTER;
	ans = (((totalDaysOffset % 7) + 7) % 7);
	return ans;
}


int32_t SH_weekdayIdx(struct SHDatetime * const dt, int32_t dayOffset) {
	int32_t weekdayIdx = SH_NOT_FOUND;
	if((weekdayIdx = _calcWeekdayIdx(dt)) == SH_NOT_FOUND) {
		return weekdayIdx;
	}
	int32_t result = (weekdayIdx + SH_DAYS_IN_WEEK - dayOffset) % SH_DAYS_IN_WEEK;
	return result;
}


int32_t SH_calcDayOfYear(struct SHDatetime *dt){
	if(!SH_areTimeComponentsValid(dt)){
		SH_notifyOfError(SH_OUT_OF_RANGE,"Date components are out of range");
		return SH_NOT_FOUND;
	}
	bool shouldAddLeapDay = _shouldAddLeapDay(dt->year,dt->month,dt->day);
	int32_t days = SH_monthSums[dt->month -1];
	days += (shouldAddLeapDay && !(dt->month == 2 && dt->day == 29) ? 1 : 0);
	days += dt->day;
	return days;
}


SHErrorCode SH_dateDiffSeconds(struct SHDatetime * const fromDt, struct SHDatetime * const toDt, double *ans){
	assert(fromDt);
	assert(toDt);
	assert(ans);
	double timestampFrom = 0;
	double timestampTo = 0;
	SHErrorCode status = SH_NO_ERROR;
	if((status = SH_dtToTimestamp(fromDt, &timestampFrom)) != SH_NO_ERROR) {
		goto cleanup;
	}
	if((status = SH_dtToTimestamp(toDt, &timestampTo)) != SH_NO_ERROR) {
		goto cleanup;
	}
	*ans = timestampTo - timestampFrom;
	cleanup:
		return status;
}


SHErrorCode SH_dateDiffDays(struct SHDatetime * const fromDt,struct SHDatetime * const toDt,int64_t *ans){
	assert(fromDt);
	assert(toDt);
	assert(ans);
	double secondsDiff = 0;
	SHErrorCode status = SH_NO_ERROR;
	if((status = SH_dateDiffSeconds(fromDt, toDt, &secondsDiff)) != SH_NO_ERROR) {
		goto cleanup;
	}

	*ans = (int64_t)(secondsDiff / SH_DAY_IN_SECONDS);

	cleanup:
		return status;
}


SHErrorCode SH_dateDiffFullWeeks(struct SHDatetime * const fromDt, struct SHDatetime * const toDt,
	int32_t dayOffset, int64_t *ans)
{
	SHErrorCode status = SH_NO_ERROR;
	struct SHDatetime firstFullWeek;
	*ans = SH_NOT_FOUND;
	bool areSameWeek = false;
	;
	if((status = SH_areSameWeek(fromDt, toDt, dayOffset, &areSameWeek)) != SH_NO_ERROR) {
		goto fnExit;
	}
	if(areSameWeek) {
		*ans = 0;
		goto fnExit;
	}
	firstFullWeek = *fromDt;
	if((status = SH_nextWeekStart(&firstFullWeek, dayOffset)) != SH_NO_ERROR) {
		goto fnExit;
	}
	struct SHDatetime lastFullWeek = *toDt;
	if((status = SH_weekStart(&lastFullWeek, dayOffset)) != SH_NO_ERROR) {
		goto fnExit;
	}
	double diff = SH_NOT_FOUND;
	SH_dateDiffSeconds(&firstFullWeek, &lastFullWeek, &diff);
	*ans = llabs(((int64_t)diff) / (SH_DAYS_IN_WEEK * SH_DAY_IN_SECONDS));
	fnExit:
		return status;
}


static void _calcFractSecs(FractSecs *fractSecs, double timestamp){
	double fraction = timestamp - (int64_t)timestamp;
	fractSecs->milisecond = (int32_t)(fraction*1000);
}

static SHErrorCode _calcFractFromParts(double miliseconds,double* ans){
	shLog("_calcFractFromParts");
	
	if(!ans) {
		SH_notifyOfError(SH_NULL_VALUES,"Null inputs");
		return SH_NULL_VALUES;
	}
	if(miliseconds > 1000 || miliseconds < 0) {
		SH_notifyOfError(SH_OUT_OF_RANGE,"invalid milliseconds");
		return SH_OUT_OF_RANGE;
	}
	*ans = miliseconds/1000.0;
	shLog("leaving _calcFractFromParts");
	return SH_NO_ERROR;
}


SHErrorCode SH_weekStart(struct SHDatetime *dt, int32_t dayOffset) {
	int32_t weekdayIdx = SH_NOT_FOUND;
	SHErrorCode status = SH_NO_ERROR;
	if((weekdayIdx = SH_weekdayIdx(dt, dayOffset)) == SH_NOT_FOUND) {
		status = SH_INPUT_BAD_RESULTS;
		goto cleanup;
	}
	if((status = SH_addDaysToDt(dt, - weekdayIdx, SH_TIME_ADJUST_NO_OPTION)) != SH_NO_ERROR) {
		SH_notifyOfError(SH_INPUT_BAD_RESULTS,"Could not calc week start");
		goto cleanup;
	}
	SH_dtSetToTimeOfDay(dt, 0);
	cleanup:
		return status;
}


SHErrorCode SH_nextWeekStart(struct SHDatetime *dt, int32_t dayOffset) {
	int32_t weekdayIdx = SH_NOT_FOUND;
	SHErrorCode status = SH_NO_ERROR;
	if((weekdayIdx = SH_weekdayIdx(dt, dayOffset)) == SH_NOT_FOUND) {
		status = SH_INPUT_BAD_RESULTS;
		goto cleanup;
	}
	if((status = SH_addDaysToDt(dt, SH_DAYS_IN_WEEK - weekdayIdx, SH_TIME_ADJUST_NO_OPTION)) != SH_NO_ERROR) {
		SH_notifyOfError(SH_INPUT_BAD_RESULTS,"Could not calc next week start");
		goto cleanup;
	}
	SH_dtSetToTimeOfDay(dt, 0);
	cleanup:
		return status;
}


SHErrorCode SH_areSameWeek(struct SHDatetime * const A, struct SHDatetime * const B,
	int32_t dayOffset, bool *ans)
{
	SHErrorCode status = SH_NO_ERROR;
	struct SHDatetime weekStart = *A;
	struct SHDatetime nextWeekStart = *A;
	if((status = SH_weekStart(&weekStart, dayOffset)) != SH_NO_ERROR) {
		goto cleanup;
	}
	if((status = SH_nextWeekStart(&nextWeekStart, dayOffset)) != SH_NO_ERROR) {
		goto cleanup;
	}
	double weekstartTimestamp = 0;
	double nextWeekStartTimestamp = 0;
	double bTimestamp = 0;
	if((status = SH_dtToTimestamp(&weekStart, &weekstartTimestamp)) != SH_NO_ERROR) {
		goto cleanup;
	}
	if((status = SH_dtToTimestamp(&nextWeekStart, &nextWeekStartTimestamp)) != SH_NO_ERROR) {
		goto cleanup;
	}
	if((status = SH_dtToTimestamp(B, &bTimestamp)) != SH_NO_ERROR) {
		goto cleanup;
	}
	*ans = weekstartTimestamp <= bTimestamp && bTimestamp < nextWeekStartTimestamp;
	cleanup:
		return status;
}


void SH_freeSHTimeshift(struct SHTimeshift *tsObj){
	if(!tsObj) return;
	free(tsObj);
}


void SH_freeSHDatetime(struct SHDatetime *dtObj, int32_t len){
	if(!dtObj) return;
	for(int32_t i = 0; i < len; i++){
		SH_freeSHTimeshift(dtObj[i].shifts);
	}
	free(dtObj);
}


void SH_DTToString(struct SHDatetime const *dt,char* str){
	sprintf(str, "%"PRId64"-%d-%d %d:%d:%d",dt->year,dt->month,dt->day,dt->hour,dt->minute,dt->second);
}


