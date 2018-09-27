//
//  SHDatetimeMod.c
//  SHDatetime
//
//  Created by Joel Pridgen on 8/25/18.
//  Copyright © 2018 Joel Gillette. All rights reserved.
//

#include "SHDatetimeMod.h"
#include <limits.h>
#include <stdbool.h>
#include <stdlib.h>
#include <math.h>
#include "SHConstants.h"
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
    prepareSHError(error);
    if(timestamp < 0 && (YEAR_ZERO_FIRST_SEC - timestamp) > -1*timezoneOffset){
		return setErrorCode(OUT_OF_RANGE,&error->code);
	}
    if(timestamp > 0 && (LONG_MAX - timestamp) < timezoneOffset){
		return setErrorCode(OUT_OF_RANGE,&error->code);
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
    return _isLeapYearCorrected(year, BEST_LEAP_YEAR);
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
    int64_t dif = year - BEST_LEAP_YEAR + (year >= BEST_LEAP_YEAR?-1:0);
    int64_t ans = _calcNumLeapYearsExclusive(dif);
    /*We want to offset the leap to 2000 rather than 1972 since it will handle
     multiples of 100 and 400 better. Our little window shift creates some problems
     where the leap years between 1972 and 2000 don't align right.
     So, we just do that here.
     */
    if(year < FIRST_LEAP_YEAR || year > BEST_LEAP_YEAR || !_isLeapYear(dif)){
        ans += LEAP_COUNT_BETWEEN_1972_2000;
    }
    else{
        ans += (LEAP_COUNT_BETWEEN_1972_2000 -1);
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
    return _isLeapYearFromBaseYear(year) && (month > 2
             || (month == 2 && day > 28));
}


static int64_t _calcYearsFor20thCent(int64_t seconds,bool isBefore1970){
    if(seconds < 0) return -1;
    int64_t years = 0;
    int leapExcess = seconds % SECONDS_PER_4_YEARS;
    if(leapExcess >= 94694400){
        years = 3;
    }
    else if(leapExcess >= (isBefore1970?63158400:63072000)){
        years = 2;
    }
    else if(leapExcess >= 31536000){
        years = 1;
    }
    
    int64_t leapCycles = seconds / SECONDS_PER_4_YEARS;
    years +=  (leapCycles*YEARS_PER_LEAP_CYCLE_SM);
    return years;
}


static int _calcYearsBefore20thCent(int64_t seconds,bool isLeapCent){
    if(seconds < 0) return -1;
    int years = 0;
    (void)isLeapCent;
    int leapExcess = seconds % SECONDS_PER_4_YEARS;
    if(leapExcess >= (3*SECONDS_PER_YEAR)){
        years = 3;
    }
    else if(leapExcess >= (2*SECONDS_PER_YEAR)){
        years = 2;
    }
    else if(leapExcess >= SECONDS_PER_YEAR){
        years = 1;
    }
    int64_t leapCycles = seconds / SECONDS_PER_4_YEARS;
    years +=  (leapCycles*4);
    return years;
}

static int64_t _calcYearsAfter20thCent(int64_t seconds,bool isLeapCent){
    if(seconds < 0) return -1;
    int64_t years = 0;
    if(!isLeapCent){
        //turn of normal century does not include leap year
        if(seconds < (4*SECONDS_PER_YEAR)){
            for(int yearFactor = 3;yearFactor > 0;yearFactor--){
                if(seconds >= (yearFactor*SECONDS_PER_YEAR)){
                    years = yearFactor;
                    return years;
                }
            }
            return 0;
        }
        seconds -= 4*SECONDS_PER_YEAR; //shave off the non-leap year segment
        years += 4;
    }
    int leapExcess = seconds % SECONDS_PER_4_YEARS;
    if(leapExcess >= (2*SECONDS_PER_YEAR + SECONDS_PER_LEAP_YEAR)){
        years += 3;
    }
    else if(leapExcess >= (SECONDS_PER_YEAR + SECONDS_PER_LEAP_YEAR)){
        years += 2;
    }
    else if(leapExcess >= SECONDS_PER_LEAP_YEAR){
        years += 1;
    }
    
    int64_t leapCycles = seconds / SECONDS_PER_4_YEARS;
    years +=  (leapCycles*YEARS_PER_LEAP_CYCLE_SM);
    return years;
}

static int64_t _calcYearsPastPerQuadricentennial(int64_t seconds){
    if(seconds < 0) return -1;
    int64_t years = 0;
    int64_t leapExcess = 0;
    int64_t leapCycles = 0;
    if(seconds > SECONDS_PER_400_YEARS){
        leapCycles = seconds / SECONDS_PER_400_YEARS;
        seconds %= SECONDS_PER_400_YEARS;
        years += leapCycles * 400;
    }
    if(seconds > (3*SECONDS_PER_100_YEARS)){
        seconds -= (3*SECONDS_PER_100_YEARS);
        years += 300;
        return years + _calcYearsBefore20thCent(seconds,true);
    }
    leapExcess = seconds % SECONDS_PER_100_YEARS;
    leapCycles = seconds / SECONDS_PER_100_YEARS;
    
    years += _calcYearsBefore20thCent(leapExcess,false);
    
    years += leapCycles * 100;
    return years;
}

static int64_t _calcYearsPerQuadricentennial(int64_t seconds){
    int64_t years = 0;
    int64_t leapExcess = 0;
    int64_t leapCycles = 0;
    if(seconds > SECONDS_PER_400_YEARS){
        leapCycles = seconds / SECONDS_PER_400_YEARS;
        seconds %= SECONDS_PER_400_YEARS;
        years += leapCycles * 400;
    }
    
    if(seconds <= (SECONDS_PER_LEAP_CENT)){
        return years + _calcYearsAfter20thCent(seconds,true);
    }
    
    years += 100;
    seconds -= (SECONDS_PER_LEAP_CENT + 1);
    
    leapExcess = seconds % SECONDS_PER_100_YEARS;
    leapCycles = seconds / SECONDS_PER_100_YEARS;
    years += _calcYearsAfter20thCent(leapExcess,false);
    years += leapCycles * 100;
    return years;
}

static int64_t _calcYears(int64_t seconds){
    int64_t years = 0;
    seconds += (seconds < 0?1:0);
    if(seconds > SPAN_1970_2000){
        seconds -= SPAN_1970_2000;
        years = 30;
        return years + _calcYearsPerQuadricentennial(seconds);
    }
    else if(seconds <= SPAN_1970_1899){
        seconds -= SPAN_1970_1899;
        years = 70;
        
        if(seconds < -(2*SECONDS_PER_100_YEARS + SECONDS_PER_LEAP_CENT+1)){ //year before 1600
            years += 300;
            seconds +=(2*SECONDS_PER_100_YEARS + SECONDS_PER_LEAP_CENT+1);
            return years + _calcYearsPastPerQuadricentennial(-seconds);
        }
        //years between 1600 and 1700
        if(seconds <= -(2*SECONDS_PER_100_YEARS)){
            years += 2*100;
            seconds += (2*SECONDS_PER_100_YEARS);
            return years + _calcYearsBefore20thCent(-seconds,true);
        }
        
        for(int cents = 1;cents >= 0;cents--){
            if(seconds <= -cents*SECONDS_PER_100_YEARS){
                years += cents*100;
                seconds += (cents*SECONDS_PER_100_YEARS);
                return years + _calcYearsBefore20thCent(-seconds,false);
            }
        }
    }
    return _calcYearsFor20thCent(labs(seconds),seconds < 0);
}


static void _calcTimeFromTimestamp(int64_t timestamp,int minOffset,TimeCalcResult *result){
    result->totalMins = timestamp / MIN_IN_SECONDS;
    result->exSecs = timestamp % 60;
    result->totalMins += ((result->exSecs+minOffset) / 60);
    result->totalHours = result->totalMins/60;
    result->totalDays = result->totalHours / 24;
}

double createDateTime_m(int64_t year,int month,int day,int hour,int minute,int second
  ,int timezoneOffset,SHError *error){
    prepareSHError(error);
    double ans;
    tryCreateDateTime_m(year,month,day,hour,minute,second,timezoneOffset,&ans,error);
    return ans;
}

bool _areTimeComponentsValid(int64_t year,int month,int day,int hour,int minute,int second){
    bool isValid = year >= 0 && year <= 9999;
    isValid &= (hour >= 0 && hour < 24);
    isValid &= (minute >= 0 && minute < 60);
    isValid &= (second >= 0 && second < 60);
    isValid &= month > 0 && month < 13;
    
    bool isLeapYear = _isLeapYearFromBaseYear(year);
    isValid &= (day > 0 && day <= (_monthCount[month-1] + (isLeapYear&&month==2?1:0)));
    
    return isValid;
}


bool  tryCreateDateTime_m(int64_t year,int month,int day,int hour,int minute,int second
  ,int timezoneOffset,double *ans,SHError *error){
    prepareSHError(error);
    bool isValid = _areTimeComponentsValid(year,month,day,hour,minute,second);
    if(!isValid) return handleError(GEN_ERROR,"",error);
    double sum;
    int64_t leapYearCount = _calcNumLeapYearsBaseLeap(year);
    bool isLeapYear = _isLeapYearFromBaseYear(year);
    if(year >= BASE_YEAR){
        int64_t span = year - BASE_YEAR;
        int dayTotal = _monthSums[month-1];
        int64_t yearStart = span*DAY_IN_SECONDS*365 + DAY_IN_SECONDS*leapYearCount;
        dayTotal+=(day-1);
        int FEB_DAY_SUM = 59;
        int leapDayOffset = isLeapYear &&
        (dayTotal > FEB_DAY_SUM||(month==3&&dayTotal== FEB_DAY_SUM)) ?
        1:0;
        sum = yearStart + dayTotal*DAY_IN_SECONDS + leapDayOffset*DAY_IN_SECONDS;
        sum += (hour*HOUR_IN_SECONDS + minute*MIN_IN_SECONDS + second);
    }
    else{
        int64_t span = year - BASE_YEAR + 1;
        int dayTotal = _backwardMonthSums[month-1];
        int64_t yearStart = span*DAY_IN_SECONDS*NORMAL_YEAR_DAYS - DAY_IN_SECONDS*leapYearCount;
        day = day - _monthCount[month-1] - (isLeapYear&&dayTotal >= 306?1:0);
        dayTotal= day - dayTotal;
        sum = yearStart + dayTotal*DAY_IN_SECONDS;
        sum+=((hour-23)*HOUR_IN_SECONDS + (minute-59)*MIN_IN_SECONDS + (second -60));
    }
    sum -= timezoneOffset;
    *ans = sum;
    return true;
}

double createDate_m(int64_t year,int month,int day,int timezoneOffset,SHError *error){
    prepareSHError(error);
    double ans;
    tryCreateDate_m(year,month,day,timezoneOffset,&ans,error);
    return ans;
}

bool tryCreateDate_m(int64_t year,int month,int day,int timezoneOffset,double *ans,
  SHError *error){
    prepareSHError(error);
    return tryCreateDateTime_m(year,month,day,0,0,0,timezoneOffset,ans,error);
}

double createTime_m(int hour,int minute,int second,SHError *error){
    prepareSHError(error);
    double ans;
    tryCreateTime_m(hour,minute,second,&ans,error);
    return ans;
}

bool  tryCreateTime_m(int hour,int minute,int second,double *ans,SHError *error){
    prepareSHError(error);
    double tmpAns = *ans;
    bool result =  tryCreateDateTime_m(1970,1,1,hour,minute,second,0,&tmpAns,error);
    *ans = (int)tmpAns;
    return result;
}

bool _filDateTimeObj(int64_t year,int month,int day,int hour,int min,int sec,
  int timezoneOffset,SHDatetime *dt){
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
    timestamp += (isBeforeEpoch?SECONDS_PER_YEAR:0);
    _calcTimeFromTimestamp(timestamp,0,&result);
    int totalYears = (int)(result.totalDays/NORMAL_YEAR_DAYS);
    int exDays = (int)result.totalDays -totalYears*NORMAL_YEAR_DAYS + INCLUDE_TODAY;
    int month = _getMonthFromDaySum(exDays,false);
    exDays -= _monthSums[month -1];
    int exHours = result.totalHours % HOURS_PER_DAY;
    int exMin = result.totalMins % MIN_SEC_LEN;
    int year = isBeforeEpoch?BEFORE_EPOCH_BASE_YEAR:BASE_YEAR + totalYears;
    _filDateTimeObj(year,month,exDays,exHours,exMin,result.exSecs,0,dt);
}

int64_t _calcShiftedTimestamp(int64_t timestamp,int64_t years,int isBeforeEpoch){
    if(years > 1){
        return (timestamp % (years*SECONDS_PER_YEAR));
    }
    else if(years == 1){
        return timestamp + (isBeforeEpoch?SECONDS_PER_YEAR:-SECONDS_PER_YEAR);
    }
    return timestamp;
}


bool  tryTimestampToDt_m(double timestamp, int timezoneOffset,SHDatetime *dt,
  SHError *error){
    prepareSHError(error);
    if(!dt) return handleError(NULL_VALUES,"",error);
    if(!_isTimestampRangeInvalid(timestamp,timezoneOffset,error)) return false;
    FractSecs fractSec;
    _calcFractSecs(&fractSec, timestamp);
    _popDtWithFracSecs(dt,&fractSec);
    if(timestamp - timezoneOffset == 0){
        return _filDateTimeObj(BASE_YEAR,1,1,0,0,0,timezoneOffset,dt);
    }
    timestamp += timezoneOffset;
    bool isBeforeEpoch = timestamp < 0;
    int64_t totalYears = _calcYears(timestamp);
    int64_t yearCorrection = isBeforeEpoch?(1969 -2000):2000-1970;
    bool isLeapYear = _isLeapYearCorrected(totalYears,yearCorrection);
    int64_t shiftedTimestamp = _calcShiftedTimestamp(timestamp,totalYears
                                  ,isBeforeEpoch);
    totalYears *= (isBeforeEpoch?MIRROR_BEFORE_EPOCH:EPOCH_NEUTRAL);
    int baseYear = isBeforeEpoch?1969:1970;
    if(shiftedTimestamp == YEAR_CUSP){
        return _filDateTimeObj(baseYear + totalYears,1,1,0,0,0,timezoneOffset,dt);
    }
    
    int64_t leapCount = _calcNumLeapYearsBaseLeap(totalYears+baseYear);
    if(isBeforeEpoch){
        int64_t complimentYear = (isLeapYear?SPECIAL_TIMESTAMP:SECONDS_PER_YEAR)
        + leapCount*DAY_IN_SECONDS;
        shiftedTimestamp = (complimentYear + shiftedTimestamp);
    }
    TimeCalcResult result;
    _calcTimeFromTimestamp(shiftedTimestamp,0,&result);
    int exDays = (int)result.totalDays + INCLUDE_TODAY;
    exDays -= (!isBeforeEpoch?leapCount:0);
    int month = _getMonthFromDaySum(exDays,isLeapYear);
    int currentLeapOffset = (isLeapYear&&exDays > LEAP_FEB_SUM?1:0);
    exDays -= currentLeapOffset;
    exDays -= _monthSums[month-1];
    int exHours = result.totalHours % HOURS_PER_DAY;
    int exMins = result.totalMins % MIN_SEC_LEN;
    
    return _filDateTimeObj(totalYears+baseYear,month,exDays,exHours,exMins,result.exSecs
             ,timezoneOffset,dt);
}

bool  timestampToDtUnitsOnly_m(double timestamp,SHDatetime *dt,SHError *error){
    prepareSHError(error);
    Timeshift *shifts = dt->shifts;
    int shiftLen = dt->shiftLen;
    int shiftIdx = dt->currentShiftIdx;
    if(! tryTimestampToDt_m(timestamp,dt->timezoneOffset,dt,error)){
        return handleError(error->code,"",error);;
    }
    dt->shifts = shifts;
    dt->shiftLen = shiftLen;
    dt->currentShiftIdx = shiftIdx;
    return true;
}

bool tryDtToTimestamp_m(SHDatetime const *dt,double *ans,SHError *error){
    prepareSHError(error);
    if(!dt) return handleError(NULL_VALUES,"",error);
    double fraction = 0.0;
    bool isSuccess = _calcFractFromParts(dt->milisecond,&fraction, error);
    if(!isSuccess) return false;
    isSuccess = tryCreateDateTime_m(dt->year,dt->month,dt->day,dt->hour,dt->minute
                                  ,dt->second,dt->timezoneOffset,ans,error);
    *ans += fraction*(dt->year < 1970 ? -1:1);
    return isSuccess;
}

double dtToTimestamp_m(SHDatetime const *dt,SHError *error){
    prepareSHError(error);
    if(!dt) return handleError(NULL_VALUES,"",error);
    double ans;
    tryDtToTimestamp_m(dt,&ans,error);
    return ans;
}


bool tryExtractTime_m(SHDatetime *dt,double *ans,SHError *error){
    prepareSHError(error);
    if(!dt) return handleError(NULL_VALUES,"",error);
    double fraction = 0.0;
    bool isSuccess = _calcFractFromParts(dt->milisecond,&fraction,error);
    if(!isSuccess) return false;
    isSuccess = tryCreateTime_m(dt->hour,dt->minute,dt->second,ans,error);
    return isSuccess;
}


double extractTime_m(SHDatetime *dt,SHError *error){
    prepareSHError(error);
    if(!dt) return handleError(NULL_VALUES,"",error);
    double ans;
    tryExtractTime_m(dt,&ans,error);
    return ans;
}


bool tryAddDaysToDtInPlace_m(SHDatetime *dt,int64_t days,TimeAdjustOptions options,
  SHError *error){
    (void)options;
    prepareSHError(error);
    if(!dt) return handleError(NULL_VALUES,"",error);
    double converted;
    if(!tryDtToTimestamp_m(dt,&converted,error)) return false;
    double ans;
    if(!tryAddDaysToTimestamp_m(converted,days,0,&ans,error)) return false;
    if(!timestampToDtUnitsOnly_m(ans,dt,error))return false;
    return updateTimezoneForShifts_m(dt,error);
}


bool tryAddDaysToDt_m(SHDatetime const *dt,int64_t days,TimeAdjustOptions options
  ,SHDatetime *ans,SHError *error){
    prepareSHError(error);
    if(!dt) return handleError(NULL_VALUES,"",error);
    *ans = *dt;
    return tryAddDaysToDtInPlace_m(ans,days,options,error);
    
}

#pragma GCC diagnostic push
#pragma GCC diagnostic ignored "-Wunused-parameter"

bool tryAddDaysToTimestamp_m(double timestamp,int64_t days, TimeAdjustOptions options,
  double *ans,SHError *error){
    (void)options;
    prepareSHError(error);
    timestamp += (days*DAY_IN_SECONDS);
    *ans = timestamp;
    return true;
}

#pragma GCC diagnostic pop

bool tryAddMonthsToDt_m(SHDatetime const *dt,int64_t months,TimeAdjustOptions options
  ,SHDatetime *ans,SHError *error){
    prepareSHError(error);
    if(!dt) return handleError(NULL_VALUES,"",error);
    *ans = *dt;
    return tryAddMonthsToDtInPlace_m(ans,months,options,error);
}

bool tryAddMonthsToDtInPlace_m(SHDatetime *dt,int64_t months,TimeAdjustOptions options
  ,SHError *error){
    prepareSHError(error);
    if(!dt) return handleError(NULL_VALUES,"",error);
    if(months == 0) return true;
    if(options == NO_OPTION) options = SHIFT_BKD;
    int64_t totalMonths = months + dt->month;
    int exMonths = totalMonths % YEAR_IN_MONTHS;
    int64_t years = totalMonths / YEAR_IN_MONTHS;
    dt->month = exMonths;
    dt->year += years;
    int monthLastDay = _monthCount[dt->month -1]
    + (_isLeapYear(dt->year)&&dt->month == FEB?1:0);
    if(dt->day > monthLastDay){
        if(options == SHIFT_BKD){
            dt->day = monthLastDay;
        }
        else if(options == SHIFT_FWD){
            dt->day = 1;
            dt->month++;
        }
    }
    updateTimezoneForShifts_m(dt,error);
    return true;
}

bool tryAddMonthsToTimestamp_m(double timestamp,int64_t months,int timezoneOffset,
  TimeAdjustOptions options,double *ans,SHError *error){
    prepareSHError(error);
    SHDatetime dt;
    if(!tryTimestampToDt_m(timestamp,timezoneOffset,&dt,error)) return false;
    if(!tryAddMonthsToDtInPlace_m(&dt,months,options,error)) return false;
    return tryDtToTimestamp_m(&dt,ans,error);
}

static bool _addYears_SHIFT(SHDatetime *dt,int64_t years, TimeAdjustOptions options,
  SHError *error) {
    prepareSHError(error);
    int64_t yearSum = years + dt->year;
    options = options == NO_OPTION?SHIFT_BKD:options;
    if(options & ERROR){
        if(!_isLeapYearFromBaseYear(yearSum)&&_isLeapDayCusp(dt)){
            return handleError(GEN_ERROR,"",error);
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
    return handleError(GEN_ERROR,"",error);
}

double addYearsToTimestamp_m(double timestamp,int64_t years,int timezoneOffset,
  TimeAdjustOptions options,SHError *error){
    prepareSHError(error);
    double ans;
    tryAddYearsToTimestamp_m(timestamp,years,timezoneOffset,options,&ans,error);
    return ans;
}

bool tryAddYearsToTimestamp_m(double timestamp,int64_t years,int timezoneOffset
  ,TimeAdjustOptions options,double *ans,SHError *error){
    prepareSHError(error);
    SHDatetime dt;
    if(!tryTimestampToDt_m(timestamp,timezoneOffset,&dt,error)) return false;
    if(!tryAddYearsToDtInPlace_m(&dt,years,options,error)) return false;
    return tryDtToTimestamp_m(&dt,ans,error);
}

bool tryAddYearsToDt_m(SHDatetime const *dt,int64_t years,TimeAdjustOptions options
  ,SHDatetime *ans,SHError *error){
    prepareSHError(error);
    if(!dt) return handleError(NULL_VALUES,"",error);
    *ans = *dt;
    return tryAddYearsToDtInPlace_m(ans,years,options,error);
}

bool tryAddYearsToDtInPlace_m(SHDatetime *dt,int64_t years,TimeAdjustOptions options
  ,SHError *error){
    prepareSHError(error);
    if(!dt) return handleError(NULL_VALUES,"",error);
    if(years == 0) return true;
    
    if((options &(SHIFT_BKD|SHIFT_FWD))||options == NO_OPTION){
        return _addYears_SHIFT(dt,years, options,error);
    }
    if(options & SIMPLE){
        double timestamp;
        if(!tryDtToTimestamp_m(dt,&timestamp,error)) return false;
        timestamp += years*SECONDS_PER_YEAR;
        if(!tryTimestampToDt_m(timestamp,dt->timezoneOffset,dt,error)) return false;
        return true;
    }
    return false;
}

bool tryDayStart_m(double timestamp,int timezoneOffset,double *ans,SHError *error){
    prepareSHError(error);
    SHDatetime dt;
    if(!tryTimestampToDt_m(timestamp,timezoneOffset,&dt,error)) return false;
    dayStart(&dt);
    return tryDtToTimestamp_m(&dt,ans,error);
}


SHDatetime* dayStart(SHDatetime *dt){
  if(!dt){
    return dt;
  }
  dt->hour = 0;
  dt->minute = 0;
  dt->second = 0;
  dt->milisecond = 0;
  return dt;
}


int calcWeekdayIdx_m(SHDatetime *dt,SHError *error){
    double timestamp;
    prepareSHError(error);
    if(!tryDtToTimestamp_m(dt,&timestamp,error)) return NOT_FOUND;
    int ans;
    timestamp += dt->timezoneOffset;
    bool isAfterEpoch = dt->year >= BASE_YEAR;
    if(isAfterEpoch){
        int64_t totalDays = timestamp/DAY_IN_SECONDS;
        //if within the first week
        if(totalDays < WEEK_START_DAYS_AFTER){
            return (int)totalDays + EPOCH_WEEK_CORRECTION;
        }
        totalDays = totalDays - WEEK_START_DAYS_AFTER;
        ans = totalDays % 7;
        return ans;
    }
    int64_t totalDays = (timestamp/DAY_IN_SECONDS);
    
    totalDays = totalDays -3;
    ans = (((totalDays % 7) + 7) % 7);
    return ans;
}

int calcDayOfYear_m(SHDatetime *dt,SHError *error){
    if(!isValidSHDateTime_m(dt)) return setIndexErrorCode(GEN_ERROR,&error->code);
    bool shouldAddLeapDay = _shouldAddLeapDay(dt->year,dt->month,dt->day);
    int days = _monthSums[dt->month -1];
    days += (shouldAddLeapDay && !(dt->month == 2 && dt->day == 29)  ? 1 : 0);
    days += dt->day;
    return days;
}


int calcDayOfYearFromTimestamp_m(double timestamp,int timezoneOffset,SHError * error){
    SHDatetime dt;
    if(!tryTimestampToDt_m(timestamp,timezoneOffset,&dt,error)) return NOT_FOUND;
    return calcDayOfYear_m(&dt,error);
}


bool tryDiffDateSecs_m(SHDatetime const *A,SHDatetime const *B,int64_t *ans,SHError *error){
    prepareSHError(error);
    if(!isValidSHDateTime_m(A)) return handleError(GEN_ERROR,"",error);
    if(!isValidSHDateTime_m(B)) return handleError(GEN_ERROR,"",error);
    SHError errorA,errorB;
    prepareSHError(&errorA);
    prepareSHError(&errorB);
    *ans = dtToTimestamp_m(A,&errorA) - dtToTimestamp_m(B,&errorB);
    if(errorA.code | errorB.code) return false;
    return true;
}

double dateDiffSecs_m(SHDatetime const *A,SHDatetime const *B,SHError *error){
    prepareSHError(error);
    if(!A||!B) return handleError(NULL_VALUES,"",error);
    int64_t ans;
    tryDiffDateSecs_m(A,B,&ans,error);
    return ans;
}


int64_t dateDiffDays_m(SHDatetime const *A,SHDatetime const *B,SHError *error){
    prepareSHError(error);
    if(!A||!B) return handleError(NULL_VALUES,"",error);
    int64_t ans;
    tryDateDiffDays_m(A,B,&ans,error);
    return ans;
}


bool tryDateDiffDays_m(SHDatetime const *A,SHDatetime const *B,int64_t *ans,SHError *error){
    prepareSHError(error);
    if(!A||!B) return handleError(NULL_VALUES,"",error);
    *ans = dateDiffSecs_m(A,B,error);
    *ans /= DAY_IN_SECONDS;
    if(error->code) return handleError(error->code,"",error);;
    return true;
}

bool isValidSHDateTime_m(SHDatetime const *dt){
    return dt && _areTimeComponentsValid(dt->year,dt->month,dt->day,dt->hour,dt->minute
     ,dt->second);
}


static bool _calcFractSecs(FractSecs *fractSecs,double timestamp){
    double fraction = timestamp - (int64_t)timestamp;
    fractSecs->milisecond = (int)(fraction*1000);
    fraction -= ((double)fractSecs->milisecond/1000.0);
    return true;
}

static bool _calcFractFromParts(double miliseconds,double* ans,SHError *error){
    prepareSHError(error);
    if(miliseconds > 1000) return setErrorCode(OUT_OF_RANGE,&error->code);
    *ans = miliseconds/1000.0;
    return true;
}

static void _popDtWithFracSecs(SHDatetime* dt,FractSecs* fractSecs){
    dt->milisecond = fractSecs->milisecond;
}
