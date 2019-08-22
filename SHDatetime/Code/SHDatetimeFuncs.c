//
//	SHDatetimeFuncs.c
//	SHDatetime
//
//	Created by Joel Pridgen on 8/25/18.
//	Copyright © 2018 Joel Gillette. All rights reserved.
//

#include "SHDatetimeFuncs.h"
#include <limits.h>
#include <stdbool.h>
#include <stdlib.h>
#include <math.h>
#include "SHUtilConstants.h"
#include "SHGenAlgos.h"

static int _monthSums[12] = {0,31,59,90,120,151,181,212,243,273,304,334};
static int _backwardMonthSums[12] = {334,306,275,245,214,184,153,122,92,61,31,0};
static int _monthCount[12] = {31,28,31,30,31,30,31,31,30,31,30,31};

typedef struct{
	int64_t totalMins;
	int exSecs;
	int64_t totalHours;
	int64_t totalDays;
} TimeCalcResult;

typedef struct{
	double fraction;
	int milisecond;
	int microsecond;
} FractSecs;

static bool _calcFractSecs(FractSecs *fractSecs,double timestamp);
static bool _calcFractFromParts(double miliseconds,double* ans,SHError *error);
static void _popDtWithFracSecs(SHDatetime* dt,FractSecs* fractSecs);
static bool _shouldAddLeapDay(int64_t year,int month,int day);


/*
 want to calculate the month based on how many days have passed
 in the year already.
 */
static int _getMonthFromDaySum(int daySum, bool isLeapYear){
	if(daySum < 1 || daySum > (366 + (isLeapYear?1:0))) return -1;
	if(daySum <= 31) return 1;
	if(daySum <= (59 + (isLeapYear?1:0))) return 2;
	if(daySum <= (90 + (isLeapYear?1:0))) return 3;
	if(daySum <= (120 + (isLeapYear?1:0))) return 4;
	if(daySum <= (151 + (isLeapYear?1:0))) return 5;
	if(daySum <= (181 + (isLeapYear?1:0))) return 6;
	if(daySum <= (212 + (isLeapYear?1:0))) return 7;
	if(daySum <= (243 + (isLeapYear?1:0))) return 8;
	if(daySum <= (273 + (isLeapYear?1:0))) return 9;
	if(daySum <= (304 + (isLeapYear?1:0))) return 10;
	if(daySum <= (334 + (isLeapYear?1:0))) return 11;
	return 12;
}


/*
 	this is an error checking method
 */
static int _isTimestampRangeInvalid(int64_t timestamp,int timezoneOffset,SHError *error){
	shPrepareSHError(error);
	if(timestamp < 0 && (SH_YEAR_ZERO_FIRST_SEC - timestamp) > -1*timezoneOffset){
		return shHandleError(OUT_OF_RANGE,"timestamp is earlier than earliest date",error);
}
	if(timestamp > 0 && (LONG_MAX - timestamp) < timezoneOffset){
		return shHandleError(OUT_OF_RANGE,"timestamp is later than max date",error);
}
	return true;
}


/*
	this assumes that years starts at 0. So, don't send actual years to
 this. For actual years, using either _isLeapYearCorrected or
 _isLeapYearFromBaseYear (this one is based on the year 2000)
 */
static bool _isLeapYear(int64_t years){
	return (years % 4 == 0)&&((years % 100 !=0)||(years % 400 == 0));
}

static bool _isLeapYearCorrected(int64_t years,int64_t correction){
	return _isLeapYear(years - correction);
}

static bool _isLeapYearFromBaseYear(int64_t year){
	return _isLeapYearCorrected(year, SH_BEST_LEAP_YEAR);
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
	int64_t ans = _calcNumLeapYearsWithCycleLen(year,4) -
		_calcNumLeapYearsWithCycleLen(year,100) +
		_calcNumLeapYearsWithCycleLen(year,400);
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
	if(year < SH_FIRST_LEAP_YEAR || year > SH_BEST_LEAP_YEAR || !_isLeapYear(dif)){
		ans += SH_LEAP_COUNT_BETWEEN_1972_2000;
	}
	else{
		ans += (SH_LEAP_COUNT_BETWEEN_1972_2000 -1);
	}
	return ans < 0?-ans:ans;
}

/*
 	checks if the day is feb 29th
 */
static bool _isLeapDayCusp(SHDatetime *dt){
	return dt->month == 2 && dt->day == 29;
}

/*
 	checks if year is a leap year and the date is after feb 28th
 */
static bool _shouldAddLeapDay(int64_t year,int month,int day){
	return _isLeapYearFromBaseYear(year) && (month > 2 || (month == 2 && day > 28));
}


static int64_t _calcYearsFor20thCent(int64_t seconds,bool isBefore1970){
	if(seconds < 0) return -1;
	int64_t years = 0;
	int leapExcess = seconds % SH_SECONDS_PER_4_YEARS;
	if(leapExcess >= 94694400){
		years = 3;
	}
	else if(leapExcess >= (isBefore1970?63158400:63072000)){
		years = 2;
	}
	else if(leapExcess >= 31536000){
		years = 1;
	}
	
	int64_t leapCycles = seconds / SH_SECONDS_PER_4_YEARS;
	years += (leapCycles*SH_YEARS_PER_LEAP_CYCLE_SM);
	return years;
}


static int _calcYearsBefore20thCent(int64_t seconds,bool isLeapCent){
	if(seconds < 0) return -1;
	int years = 0;
	(void)isLeapCent;
	int leapExcess = seconds % SH_SECONDS_PER_4_YEARS;
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
			for(int yearFactor = 3;yearFactor > 0;yearFactor--){
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
	int leapExcess = seconds % SH_SECONDS_PER_4_YEARS;
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
	if(seconds < 0) return -1;
	int64_t years = 0;
	int64_t leapExcess = 0;
	int64_t leapCycles = 0;
	if(seconds > SH_SECONDS_PER_400_YEARS){
		leapCycles = seconds / SH_SECONDS_PER_400_YEARS;
		seconds %= SH_SECONDS_PER_400_YEARS;
		years += leapCycles * 400;
	}
	if(seconds > (3*SH_SECONDS_PER_100_YEARS)){
		seconds -= (3*SH_SECONDS_PER_100_YEARS);
		years += 300;
		return years + _calcYearsBefore20thCent(seconds,true);
	}
	leapExcess = seconds % SH_SECONDS_PER_100_YEARS;
	leapCycles = seconds / SH_SECONDS_PER_100_YEARS;
	
	years += _calcYearsBefore20thCent(leapExcess,false);
	
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
	seconds += (seconds < 0?1:0);
	if(seconds > SH_SPAN_1970_2000){
		seconds -= SH_SPAN_1970_2000;
		years = 30;
		return years + _calcYearsPerQuadricentennial(seconds);
	}
	else if(seconds <= SH_SPAN_1970_1899){
		seconds -= SH_SPAN_1970_1899;
		years = 70;
	
		if(seconds < -(2*SH_SECONDS_PER_100_YEARS + SH_SECONDS_PER_LEAP_CENT+1)){ //year before 1600
			years += 300;
			seconds +=(2*SH_SECONDS_PER_100_YEARS + SH_SECONDS_PER_LEAP_CENT+1);
			return years + _calcYearsPastPerQuadricentennial(-seconds);
		}
		//years between 1600 and 1700
		if(seconds <= -(2*SH_SECONDS_PER_100_YEARS)){
			years += 2*100;
			seconds += (2*SH_SECONDS_PER_100_YEARS);
			return years + _calcYearsBefore20thCent(-seconds,true);
		}
	
		for(int cents = 1;cents >= 0;cents--){
			if(seconds <= -cents*SH_SECONDS_PER_100_YEARS){
					years += cents*100;
					seconds += (cents*SH_SECONDS_PER_100_YEARS);
					return years + _calcYearsBefore20thCent(-seconds,false);
			}
		}
	}
	return _calcYearsFor20thCent(labs(seconds),seconds < 0);
}


static void _calcTimeFromTimestamp(int64_t timestamp,int minOffset,TimeCalcResult *result){
	result->totalMins = timestamp / SH_MIN_IN_SECONDS;
	result->exSecs = timestamp % 60;
	result->totalMins += ((result->exSecs+minOffset) / 60);
	result->totalHours = result->totalMins/60;
	result->totalDays = result->totalHours / 24;
}


double shCreateDateTime(int64_t year,int month,int day,int hour,int minute,int second,int timezoneOffset
,SHError *error){
	shPrepareSHError(error);
	double ans;
	shTryCreateDateTime(year,month,day,hour,minute,second,timezoneOffset,&ans,error);
	return ans;
}

bool _areTimeComponentsValid(int64_t year,int month,int day,int hour,int minute,int second){
	shLog("_areTimeComponentsValid 3");
	bool isValid = (year >= 0 && year <= 9999);
	isValid &= (hour >= 0 && hour < 24);
	isValid &= (minute >= 0 && minute < 60);
	isValid &= (second >= 0 && second < 60);
	isValid &= (month > 0 && month < 13);
	if(!isValid) return isValid;
	bool isLeapYear = _isLeapYearFromBaseYear(year);
	isValid &= (day > 0 && day <= (_monthCount[month-1] + (isLeapYear&&month==2?1:0)));
	shLog("leaving _areTimeComponentsValid");
	return isValid;
}


bool shTryCreateDateTime(int64_t year,int month,int day,int hour,int minute,int second,int timezoneOffset
,double *ans,SHError *error){
	shLog("shTryCreateDateTime");
	shPrepareSHError(error);
	if(!ans) return shHandleError(NULL_VALUES,"Null inputs",error);
	bool isValid = _areTimeComponentsValid(year,month,day,hour,minute,second);
	if(!isValid){
		return shHandleError(OUT_OF_RANGE,"Date components are out of range",error);
	}
	double sum;
	int64_t leapYearCount = _calcNumLeapYearsBaseLeap(year);
	bool isLeapYear = _isLeapYearFromBaseYear(year);
	if(year >= SH_BASE_YEAR){
		int64_t span = year - SH_BASE_YEAR;
		int dayTotal = _monthSums[month-1];
		int64_t yearStart = span*SH_DAY_IN_SECONDS*365 + SH_DAY_IN_SECONDS*leapYearCount;
		dayTotal+=(day-1);
		int FEB_DAY_SUM = 59;
		int leapDayOffset = isLeapYear &&
		(dayTotal > FEB_DAY_SUM||(month==3&&dayTotal== FEB_DAY_SUM)) ?
		1:0;
		sum = yearStart + dayTotal*SH_DAY_IN_SECONDS + leapDayOffset*SH_DAY_IN_SECONDS;
		sum += (hour*SH_HOUR_IN_SECONDS + minute*SH_MIN_IN_SECONDS + second);
	}
	else{
		int64_t span = year - SH_BASE_YEAR + 1;
		int dayTotal = _backwardMonthSums[month-1];
		int64_t yearStart = span*SH_DAY_IN_SECONDS*SH_NORMAL_YEAR_DAYS - SH_DAY_IN_SECONDS*leapYearCount;
		day = day - _monthCount[month-1] - (isLeapYear&&dayTotal >= 306?1:0);
		dayTotal= day - dayTotal;
		sum = yearStart + dayTotal*SH_DAY_IN_SECONDS;
		sum+=((hour-23)*SH_HOUR_IN_SECONDS + (minute-59)*SH_MIN_IN_SECONDS + (second -60));
	}
	sum -= timezoneOffset;
	*ans = sum;
	shLog("leaving shTryCreateDateTime");
	return true;
}


double shCreateDate(int64_t year,int month,int day,int timezoneOffset,SHError *error){
	shPrepareSHError(error);
	double ans;
	shTryCreateDate(year,month,day,timezoneOffset,&ans,error);
	return ans;
}


bool shTryCreateDate(int64_t year,int month,int day,int timezoneOffset,double *ans,SHError *error){
	shPrepareSHError(error);
	return shTryCreateDateTime(year,month,day,0,0,0,timezoneOffset,ans,error);
}


double shCreateTime(int hour,int minute,int second,SHError *error){
	shPrepareSHError(error);
	double ans = 0;
	shTryCreateTime(hour,minute,second,&ans,error);
	return ans;
}


bool shTryCreateTime(int hour,int minute,int second,double *ans,SHError *error){
	shPrepareSHError(error);
	if(!ans) return shHandleError(NULL_VALUES,"Null inputs",error);
	double tmpAns = *ans;
	bool result = shTryCreateDateTime(1970,1,1,hour,minute,second,0,&tmpAns,error);
	*ans = tmpAns;
	return result;
}


bool _filDateTimeObj(int64_t year,int month,int day,int hour,int min,int sec,int timezoneOffset
,SHDatetime *dt){
	dt->year = year;
	dt->month = month;
	dt->day = day;
	dt->hour = hour;
	dt->minute = min;
	dt->second = sec;
	dt->timezoneOffset = timezoneOffset;
	dt->shifts = NULL;
	dt->shiftLen = 0;
	dt->currentShiftIdx = NOT_FOUND;
	return true;
}


void _timestampShortToDateObj(int timestamp,SHDatetime *dt){
	TimeCalcResult result;
	int isBeforeEpoch = timestamp < 0;
	timestamp += (isBeforeEpoch?SH_SECONDS_PER_YEAR:0);
	_calcTimeFromTimestamp(timestamp,0,&result);
	int totalYears = (int)(result.totalDays/SH_NORMAL_YEAR_DAYS);
	int exDays = (int)result.totalDays -totalYears*SH_NORMAL_YEAR_DAYS + SH_INCLUDE_TODAY;
	int month = _getMonthFromDaySum(exDays,false);
	exDays -= _monthSums[month -1];
	int exHours = result.totalHours % SH_HOURS_PER_DAY;
	int exMin = result.totalMins % SH_MIN_SEC_LEN;
	int year = isBeforeEpoch?SH_BEFORE_EPOCH_BASE_YEAR:SH_BASE_YEAR + totalYears;
	_filDateTimeObj(year,month,exDays,exHours,exMin,result.exSecs,0,dt);
}


int64_t _calcShiftedTimestamp(int64_t timestamp,int64_t years,int isBeforeEpoch){
	if(years > 1){
		return (timestamp % (years*SH_SECONDS_PER_YEAR));
	}
	else if(years == 1){
		return timestamp + (isBeforeEpoch?SH_SECONDS_PER_YEAR:-SH_SECONDS_PER_YEAR);
	}
	return timestamp;
}


bool shTryTimestampToDt(double timestamp, int timezoneOffset,SHDatetime *dt,SHError *error){
	shPrepareSHError(error);
	if(!dt) return shHandleError(NULL_VALUES,"Null Datetime obj",error);
	if(!_isTimestampRangeInvalid(timestamp,timezoneOffset,error)) return false;
	FractSecs fractSec;
	_calcFractSecs(&fractSec, timestamp);
	_popDtWithFracSecs(dt,&fractSec);
	if(timestamp - timezoneOffset == 0){
		return _filDateTimeObj(SH_BASE_YEAR,1,1,0,0,0,timezoneOffset,dt);
	}
	timestamp += timezoneOffset;
	bool isBeforeEpoch = timestamp < 0;
	int64_t totalYears = _calcYears(timestamp);
	int64_t yearCorrection = isBeforeEpoch?(1969 -2000):2000-1970;
	bool isLeapYear = _isLeapYearCorrected(totalYears,yearCorrection);
	int64_t shiftedTimestamp = _calcShiftedTimestamp(timestamp,totalYears,isBeforeEpoch);
	totalYears *= (isBeforeEpoch?SH_MIRROR_BEFORE_EPOCH:SH_EPOCH_NEUTRAL);
	int baseYear = isBeforeEpoch?1969:1970;
	if(shiftedTimestamp == SH_YEAR_CUSP){
		return _filDateTimeObj(baseYear + totalYears,1,1,0,0,0,timezoneOffset,dt);
	}
	
	int64_t leapCount = _calcNumLeapYearsBaseLeap(totalYears+baseYear);
	if(isBeforeEpoch){
		int64_t complimentYear = (isLeapYear?SH_SPECIAL_TIMESTAMP:SH_SECONDS_PER_YEAR)
		+ leapCount*SH_DAY_IN_SECONDS;
		shiftedTimestamp = (complimentYear + shiftedTimestamp);
	}
	TimeCalcResult result;
	_calcTimeFromTimestamp(shiftedTimestamp,0,&result);
	int exDays = (int)result.totalDays + SH_INCLUDE_TODAY;
	exDays -= (!isBeforeEpoch?leapCount:0);
	int month = _getMonthFromDaySum(exDays,isLeapYear);
	int currentLeapOffset = (isLeapYear&&exDays > SH_LEAP_FEB_SUM?1:0);
	exDays -= currentLeapOffset;
	exDays -= _monthSums[month-1];
	int exHours = result.totalHours % SH_HOURS_PER_DAY;
	int exMins = result.totalMins % SH_MIN_SEC_LEN;
	return _filDateTimeObj(totalYears+baseYear,month,exDays,exHours,exMins,result.exSecs,timezoneOffset,dt);
}

bool	shTimestampToDtUnitsOnly(double timestamp,SHDatetime *dt,SHError *error){
	shLog("shTimestampToDtUnitsOnly");
	shPrepareSHError(error);
	SHTimeshift *shifts = dt->shifts;
	int shiftLen = dt->shiftLen;
	int shiftIdx = dt->currentShiftIdx;
	if(!shTryTimestampToDt(timestamp,dt->timezoneOffset,dt,error)){
		return shHandleError(error ? error->code:GEN_ERROR,
			"There was an error converting timestamp to datetime obj",error);
	}
	dt->shifts = shifts;
	dt->shiftLen = shiftLen;
	dt->currentShiftIdx = shiftIdx;
	shLog("leaving shTimestampToDtUnitsOnly");
	return true;
}

bool shTryDtToTimestamp(SHDatetime const *dt,double *ans,SHError *error){
	shLog("shTryDtToTimestamp");
	shPrepareSHError(error);
	if(!(dt&&ans)) return shHandleError(NULL_VALUES,"Null inputs",error);
	double fraction = 0.0;
	bool isSuccess = _calcFractFromParts(dt->milisecond,&fraction, error);
	if(!isSuccess) return false;
	isSuccess = shTryCreateDateTime(dt->year,dt->month,dt->day,dt->hour,dt->minute,dt->second
								,dt->timezoneOffset,ans,error);
	*ans += fraction*(dt->year < 1970 ? -1:1);
	shLog("leaving shTryDtToTimestamp");
	return isSuccess;
}

double shDtToTimestamp(SHDatetime const *dt,SHError *error){
	shLog("shDtToTimestamp");
	shPrepareSHError(error);
	if(!dt) return shHandleError(NULL_VALUES,"Null Datetime obj",error);
	double ans;
	shTryDtToTimestamp(dt,&ans,error);
	shLog("leaving shDtToTimestamp");
	return ans;
}


bool shTryExtractTime(SHDatetime *dt,double *ans,SHError *error){
	shPrepareSHError(error);
	if(!(dt&&ans)) return shHandleError(NULL_VALUES,"Null inputs",error);
	double fraction = 0.0;
	bool isSuccess = _calcFractFromParts(dt->milisecond,&fraction,error);
	if(!isSuccess) return false;
	isSuccess = shTryCreateTime(dt->hour,dt->minute,dt->second,ans,error);
	return isSuccess;
}


double shExtractTime(SHDatetime *dt,SHError *error){
	shPrepareSHError(error);
	if(NULL == dt) return shHandleError(NULL_VALUES,"Null Datetime obj",error);
	double ans = 0;
	shTryExtractTime(dt,&ans,error);
	return ans;
}


bool shTryAddDaysToDtInPlace(SHDatetime *dt,int64_t days,TimeAdjustOptions options,SHError *error){
	shLog("shTryAddDaysToDtInPlace");
	(void)options;
	shPrepareSHError(error);
	if(!dt) return shHandleError(NULL_VALUES,"Null Datetime obj",error);
	double converted;
	if(!shTryDtToTimestamp(dt,&converted,error)) return false;
	double ans;
	if(!shTryAddDaysToTimestamp(converted,days,0,&ans,error)) return false;
	if(!shTimestampToDtUnitsOnly(ans,dt,error))return false;
	shLog("almost leaving shTryAddDaysToDtInPlace");
	return shUpdateTimezoneForShifts(dt,error);
}


bool shTryAddDaysToDt(SHDatetime const *dt,int64_t days,TimeAdjustOptions options,SHDatetime *ans
,SHError *error){
	shLog("shTryAddDaysToDt");
	shPrepareSHError(error);
	if(!(dt&&ans)) return shHandleError(NULL_VALUES,"Null inputs",error);
	*ans = *dt;
	bool isSuccess = shTryAddDaysToDtInPlace(ans,days,options,error);
	shLog("leaving shTryAddDaysToDt");
	return isSuccess;
}

#pragma GCC diagnostic push
#pragma GCC diagnostic ignored "-Wunused-parameter"

bool shTryAddDaysToTimestamp(double timestamp,int64_t days, TimeAdjustOptions options,double *ans
,SHError *error){
	shLog("shTryAddDaysToTimestamp");
	if(!ans) return shHandleError(NULL_VALUES,"Null inputs",error);
	(void)options;
	shPrepareSHError(error);
	timestamp += (days*SH_DAY_IN_SECONDS);
	*ans = timestamp;
	shLog("leaving shTryAddDaysToTimestamp");
	return true;
}

#pragma GCC diagnostic pop

bool shTryAddMonthsToDt(SHDatetime const *dt,int64_t months,TimeAdjustOptions options,SHDatetime *ans
,SHError *error){
	shPrepareSHError(error);
	if(!(dt&&ans)) return shHandleError(NULL_VALUES,"Null inputs",error);
	*ans = *dt;
	return shTryAddMonthsToDtInPlace(ans,months,options,error);
}

bool shTryAddMonthsToDtInPlace(SHDatetime *dt,int64_t months,TimeAdjustOptions options,SHError *error){
	shPrepareSHError(error);
	if(!dt) return shHandleError(NULL_VALUES,"Null Datetime obj",error);
	if(months == 0) return true;
	if(options == NO_OPTION) options = SHIFT_BKD;
	int64_t totalMonths = months + dt->month;
	int exMonths = totalMonths % SH_YEAR_IN_MONTHS;
	int64_t years = totalMonths / SH_YEAR_IN_MONTHS;
	dt->month = exMonths;
	dt->year += years;
	int monthLastDay = _monthCount[dt->month -1]
	+ (_isLeapYear(dt->year)&&dt->month == SH_FEB?1:0);
	if(dt->day > monthLastDay){
		if(options == SHIFT_BKD){
			dt->day = monthLastDay;
		}
		else if(options == SHIFT_FWD){
			dt->day = 1;
			dt->month++;
		}
	}
	shUpdateTimezoneForShifts(dt,error);
	return true;
}


bool shTryAddMonthsToTimestamp(double timestamp,int64_t months,int timezoneOffset,TimeAdjustOptions options
,double *ans,SHError *error){
	shPrepareSHError(error);
	SHDatetime dt;
	if(!shTryTimestampToDt(timestamp,timezoneOffset,&dt,error)) return false;
	if(!shTryAddMonthsToDtInPlace(&dt,months,options,error)) return false;
	return shTryDtToTimestamp(&dt,ans,error);
}


static bool _addYears_SHIFT(SHDatetime *dt,int64_t years, TimeAdjustOptions options,SHError *error) {
	shPrepareSHError(error);
	int64_t yearSum = years + dt->year;
	options = options == NO_OPTION?SHIFT_BKD:options;
	if(options & ERROR){
		if(!_isLeapYearFromBaseYear(yearSum)&&_isLeapDayCusp(dt)){
			return shHandleError(GEN_ERROR,"Date addition caused Feb 29 to happen on non leap year"
								,error);
		}
		dt->year = yearSum;
		return true;
	}
	if((options & SHIFT_BKD) || (options & SHIFT_FWD)){
		if(!_isLeapYearFromBaseYear(yearSum)&&_isLeapDayCusp(dt)){
			if(options & SHIFT_BKD) dt->day = 28;
			else if(options & SHIFT_FWD){
				dt->day = 1;
				dt->month = 3;
			}
		}
		dt->year = yearSum;
		return true;
	}
	return shHandleError(GEN_ERROR,"Invalid options",error);
}


double shAddYearsToTimestamp(double timestamp,int64_t years,int timezoneOffset,TimeAdjustOptions options
,SHError *error){
	shPrepareSHError(error);
	double ans = 0;
	shTryAddYearsToTimestamp(timestamp,years,timezoneOffset,options,&ans,error);
	return ans;
}


bool shTryAddYearsToTimestamp(double timestamp,int64_t years,int timezoneOffset,TimeAdjustOptions options
,double *ans,SHError *error){
	shPrepareSHError(error);
	SHDatetime dt;
	if(!shTryTimestampToDt(timestamp,timezoneOffset,&dt,error)) return false;
	if(!shTryAddYearsToDtInPlace(&dt,years,options,error)) return false;
	return shTryDtToTimestamp(&dt,ans,error);
}


bool shTryAddYearsToDt(SHDatetime const *dt,int64_t years,TimeAdjustOptions options,SHDatetime *ans
,SHError *error){
	shPrepareSHError(error);
	if(!(dt&&ans)) return shHandleError(NULL_VALUES,"Null inputs",error);
	*ans = *dt;
	return shTryAddYearsToDtInPlace(ans,years,options,error);
}


bool shTryAddYearsToDtInPlace(SHDatetime *dt,int64_t years,TimeAdjustOptions options,SHError *error){
	shPrepareSHError(error);
	if(!dt) return shHandleError(NULL_VALUES,"Null Datetime obj",error);
	if(years == 0) return true;
	if((options &(SHIFT_BKD|SHIFT_FWD))||options == NO_OPTION){
			return _addYears_SHIFT(dt,years, options,error);
	}
	if(options & SIMPLE){
		double timestamp;
		if(!shTryDtToTimestamp(dt,&timestamp,error)) return false;
		timestamp += years*SH_SECONDS_PER_YEAR;
		if(!shTryTimestampToDt(timestamp,dt->timezoneOffset,dt,error)) return false;
		return true;
	}
	return false;
}


bool shTryDayStart(double timestamp,int timezoneOffset,double *ans,SHError *error){
	shPrepareSHError(error);
	SHDatetime dt;
	if(!shTryTimestampToDt(timestamp,timezoneOffset,&dt,error)) return false;
	shDayStartInPlace(&dt);
	return shTryDtToTimestamp(&dt,ans,error);
}


SHDatetime* shDayStartInPlace(SHDatetime *dt){
	shLog("shDayStartInPlace");
	if(!dt){
		shLog("leaving empty shDayStartInPlace");
		return dt;
	}
	dt->hour = 0;
	dt->minute = 0;
	dt->second = 0;
	dt->milisecond = 0;
	shLog("leaving shDayStartInPlace");
	return dt;
}


int shCalcWeekdayIdx(SHDatetime *dt,SHError *error){
	double timestamp = 0;
	shPrepareSHError(error);
	if(!shTryDtToTimestamp(dt,&timestamp,error)) return NOT_FOUND;
	int ans = 0;
	timestamp += dt->timezoneOffset;
	bool isAfterEpoch = dt->year >= SH_BASE_YEAR;
	if(isAfterEpoch){
		int64_t totalDays = timestamp/SH_DAY_IN_SECONDS;
		//if within the first week
		if(totalDays < SH_WEEK_START_DAYS_AFTER){
				return (int)totalDays + SH_EPOCH_WEEK_CORRECTION;
		}
		totalDays = totalDays - SH_WEEK_START_DAYS_AFTER;
		ans = totalDays % 7;
		return ans;
	}
	int64_t totalDays = (timestamp/SH_DAY_IN_SECONDS);
	
	totalDays = totalDays -3;
	ans = (((totalDays % 7) + 7) % 7);
	return ans;
}


int shCalcDayOfYear(SHDatetime *dt,SHError *error){
	if(!shIsValidSHDateTime(dt)){
		return shHandleErrorRetNotFound(GEN_ERROR,"Date components are out of range",error);
	}
	bool shouldAddLeapDay = _shouldAddLeapDay(dt->year,dt->month,dt->day);
	int days = _monthSums[dt->month -1];
	days += (shouldAddLeapDay && !(dt->month == 2 && dt->day == 29)	? 1 : 0);
	days += dt->day;
	return days;
}


int shCalcDayOfYearFromTimestamp(double timestamp,int timezoneOffset,SHError * error){
	SHDatetime dt;
	if(!shTryTimestampToDt(timestamp,timezoneOffset,&dt,error)) return NOT_FOUND;
	return shCalcDayOfYear(&dt,error);
}


bool shTryDiffDateSecs(SHDatetime const *A,SHDatetime const *B,int64_t *ans,SHError *error){
	shPrepareSHError(error);
	if(!ans) return shHandleError(NULL_VALUES,"Null inputs",error);
	if(!shIsValidSHDateTime(A)){
		return shHandleError(GEN_ERROR,"Date components are out of range",error);
	}
	if(!shIsValidSHDateTime(B)){
		return shHandleError(GEN_ERROR,"Date components are out of range",error);
	}
	SHError errorA,errorB;
	shPrepareSHError(&errorA);
	shPrepareSHError(&errorB);
	*ans = shDtToTimestamp(A,&errorA) - shDtToTimestamp(B,&errorB);
	if(errorA.code | errorB.code) return false;
	return true;
}


double shDateDiffSecs(SHDatetime const *A,SHDatetime const *B,SHError *error){
	shPrepareSHError(error);
	if(!A||!B) return shHandleError(NULL_VALUES,"Null Datetime obj",error);
	int64_t ans = 0;
	shTryDiffDateSecs(A,B,&ans,error);
	return ans;
}


int64_t shDateDiffDays(SHDatetime const *A,SHDatetime const *B,SHError *error){
	shPrepareSHError(error);
	if(!A||!B) return shHandleError(NULL_VALUES,"Null Datetime obj",error);
	int64_t ans;
	shTryDateDiffDays(A,B,&ans,error);
	return ans;
}


bool shTryDateDiffDays(SHDatetime const *A,SHDatetime const *B,int64_t *ans,SHError *error){
	shPrepareSHError(error);
	if(!ans) return shHandleError(NULL_VALUES,"Null inputs",error);
	if(!A||!B) return shHandleError(NULL_VALUES,"Null Datetime obj",error);
	*ans = shDateDiffSecs(A,B,error);
	*ans /= SH_DAY_IN_SECONDS;
	if(error && error->code != NO_ERROR){
		return shHandleError(error->code,"Error calculating day diff",error);
	}
	return true;
}

bool shIsValidSHDateTime(SHDatetime const *dt){
	return dt && _areTimeComponentsValid(dt->year,dt->month,dt->day,dt->hour,dt->minute,dt->second);
}


static bool _calcFractSecs(FractSecs *fractSecs,double timestamp){
	double fraction = timestamp - (int64_t)timestamp;
	fractSecs->milisecond = (int)(fraction*1000);
	return true;
}

static bool _calcFractFromParts(double miliseconds,double* ans,SHError *error){
	shLog("_calcFractFromParts");
	shPrepareSHError(error);
	if(!ans) return shHandleError(NULL_VALUES,"Null inputs",error);
	if(miliseconds > 1000) return shHandleError(OUT_OF_RANGE,"invalid milliseconds",error);
	*ans = miliseconds/1000.0;
	shLog("leaving _calcFractFromParts");
	return true;
}

static void _popDtWithFracSecs(SHDatetime* dt,FractSecs* fractSecs){
	dt->milisecond = fractSecs->milisecond;
}


void shFreeSHTimeshift(SHTimeshift *tsObj){
	if(!tsObj) return;
	free(tsObj);
}


void shFreeSHDatetime(SHDatetime *dtObj){
	shFreeSHTimeshift(dtObj->shifts);
	free(dtObj);
}


void shDTToString(SHDatetime const *dt,char* str){
	sprintf(str, "%"PRId64"-%d-%d %d:%d:%d",dt->year,dt->month,dt->day,dt->hour,dt->minute,dt->second);
}

