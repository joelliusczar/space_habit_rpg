 //
//  c_datetime.c
//  SHCommon
//
//  Created by Joel Pridgen on 3/10/18.
//  Copyright © 2018 Joel Gillette. All rights reserved.
//


#include <limits.h>
#include <stdbool.h>
#include <stdlib.h>
#include <math.h>
#include "SHDatetime.h"
#include "SHConstants.h"
#include "ErrorHandling.h"

static int _monthSums[12] = {0,31,59,90,120,151,181,212,243,273,304,334};
static int _backwardMonthSums[12] = {334,306,275,245,214,184,153,122,92,61,31,0};
static int _monthCount[12] = {31,28,31,30,31,30,31,31,30,31,30,31};

typedef struct{
    long totalMins;
    int exSecs;
    long totalHours;
    long totalDays;
    
} TimeCalcResult;

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

static int _isTimestampRangeInvalid(long timestamp,int timezoneOffset,int *error){
    *error = NO_ERROR;
    if(timestamp < 0 && (YEAR_ZERO_FIRST_SEC - timestamp) > -1*timezoneOffset) return setErrorCode(OUT_OF_RANGE,error);
    if(timestamp > 0 && (LONG_MAX - timestamp) < timezoneOffset) return setErrorCode(OUT_OF_RANGE,error);
    return true;
}

static bool _isLeapYear(long years){
    return (years % 4 == 0)&&((years % 100 !=0)||(years % 400 == 0));
}

static bool _isLeapYearCorrected(long years,long correction){
    return _isLeapYear(years -correction);
}

static bool _isLeapYearFromBaseYear(long year){
    return _isLeapYearCorrected(year, BEST_LEAP_YEAR);
}

static long _calcNumLeapYearsWithCycleLen(long year,long cycleLen){
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
    long mod = year > 0?year:year - (cycleLen*year); //
    long multipleOfCycleLen = year + cycleLen - (mod % cycleLen);
    long ans = (multipleOfCycleLen)/cycleLen;
    return ans;
    /*
     for neg years, factor was abitrary. Can be any multiple of cycleLen
     This is best explained with examples
     for positive years: year = mod, so you can think of the operation
     as shaving off the remainder so that it's a multiple of cycleLen
     for negative years:
      */
}

static long _calcNumLeapYearsExclusive(long year) {
    long ans = _calcNumLeapYearsWithCycleLen(year,4) -
      _calcNumLeapYearsWithCycleLen(year,100) +
      _calcNumLeapYearsWithCycleLen(year,400);
    return ans;
}

static long _calcNumLeapYearsBaseLeap(long year){
    /*
     If year is greater than or equal to 2000 offset it by one
     because even though 2000 is a leap year, we don't want to say
     there's been 1 leap year in 2000. Besides, we already have an
     offset for when the year itself is a leap year.
     */
    long dif = year - BEST_LEAP_YEAR + (year >= BEST_LEAP_YEAR?-1:0);
    long ans = _calcNumLeapYearsExclusive(dif);
    /*We want to offset the leap to 2000 rather than 1972 since it will handle
     multiples of 100 and 400 better. Our little window shift creates some problems
     where the leap years between 1972 and 2000 don't align right.
     So, we just that here.
     */
    if(year < FIRST_LEAP_YEAR || year > BEST_LEAP_YEAR || !_isLeapYear(dif)){
        ans += LEAP_COUNT_BETWEEN_1972_2000;
    }
    else{
        ans += (LEAP_COUNT_BETWEEN_1972_2000 -1);
    }
    return ans < 0?-ans:ans;
}


static bool _isLeapDayCusp(SHDatetime *dt){
    return dt->month == 2 && dt->day == 29;
}


static long _calcYearsFor20thCent(long seconds,bool isBefore1970){
    if(seconds < 0) return -1;
    long years = 0;
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
    
    long leapCycles = seconds / SECONDS_PER_4_YEARS;
    years +=  (leapCycles*YEARS_PER_LEAP_CYCLE_SM);
    return years;
}


static int _calcYearsBefore20thCent(long seconds){
    if(seconds < 0) return -1;
    int years = 0;
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
    long leapCycles = seconds / SECONDS_PER_4_YEARS;
    years +=  (leapCycles*4);
    return years;
}

static long _calcYearsAfter20thCent(long seconds,bool isLeapCent){
    if(seconds < 0) return -1;
    long years = 0;
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
        years = 3;
    }
    else if(leapExcess >= (SECONDS_PER_YEAR + SECONDS_PER_LEAP_YEAR)){
        years = 2;
    }
    else if(leapExcess >= SECONDS_PER_LEAP_YEAR){
        years = 1;
    }
    
    long leapCycles = seconds / SECONDS_PER_4_YEARS;
    years +=  (leapCycles*YEARS_PER_LEAP_CYCLE_SM);
    return years;
}

static long _calcYearsPerQuadricentennial(long seconds,bool isPast){
    long years = 0;
    long leapExcess = 0;
    long leapCycles = 0;
    if(seconds > SECONDS_PER_400_YEARS){
        leapCycles = seconds / SECONDS_PER_400_YEARS;
        seconds %= SECONDS_PER_400_YEARS;
        years += leapCycles * 400;
    }
    
    //example years 1200-1300, year 1200 is a leap year due to 400 year rule
    if(isPast && seconds > (3*SECONDS_PER_100_YEARS)){
        return years + _calcYearsBefore20thCent(seconds);
    }
    else if(seconds <= (SECONDS_PER_LEAP_CENT)){
        return years + _calcYearsAfter20thCent(seconds,true);
    }
    
    if(!isPast){
        years += 100;
        seconds -= (SECONDS_PER_LEAP_CENT + 1);
    }
    
    leapExcess = seconds % SECONDS_PER_100_YEARS;
    leapCycles = seconds / SECONDS_PER_100_YEARS;
    if(isPast){
        years += _calcYearsBefore20thCent(seconds);
    }
    else{
        years += _calcYearsAfter20thCent(leapExcess,false);
    }
    years += leapCycles * 100;
    return years;
}

static long _calcYears(long seconds){
    long years = 0;
    seconds += (seconds < 0?1:0);
    if(seconds > SPAN_1970_2000){
        seconds -= SPAN_1970_2000;
        years = 30;
        return years + _calcYearsPerQuadricentennial(seconds,false);
    }
    else if(seconds <= SPAN_1970_1899){
        seconds -= SPAN_1970_1899;
        years = 70;
        
        if(seconds < -3*SECONDS_PER_100_YEARS){ //year before 1600
            years += 300;
            seconds +=(3*SECONDS_PER_100_YEARS);
            return years + _calcYearsPerQuadricentennial(-seconds,true);
        }
        //years between 1600 and 1700
        if(seconds < -2*SECONDS_PER_100_YEARS + LAST_SECOND_OF_DAY){
            years += 2*100;
            seconds += (2*SECONDS_PER_100_YEARS);
            return years + _calcYearsBefore20thCent(-seconds);
        }
        
        for(int cents = 1;cents >= 0;cents--){
            if(seconds <= -cents*SECONDS_PER_100_YEARS){
                years += cents*100;
                seconds += (cents*SECONDS_PER_100_YEARS);
                return years + _calcYearsBefore20thCent(-seconds);
            }
        }
    }
    return _calcYearsFor20thCent(labs(seconds),seconds < 0);
}


static void _calcTimeFromTimestamp(long timestamp,int minOffset,TimeCalcResult *result){
    result->totalMins = timestamp / MIN_IN_SECONDS;
    result->exSecs = timestamp % 60;
    result->totalMins += ((result->exSecs+minOffset) / 60);
    result->totalHours = result->totalMins/60;
    result->totalDays = result->totalHours / 24;
}

double createDateTime(long year,int month,int day,int hour,int minute,int second
  ,int timezoneOffset,int *error){
    *error = NO_ERROR;
    double ans;
    tryCreateDateTime(year,month,day,hour,minute,second,timezoneOffset,&ans,error);
    return ans;
}

bool _areTimeComponentsValid(long year,int month,int day,int hour,int minute,int second){
    bool isValid = year >= 0 && year <= 9999;
    isValid &= (hour >= 0 && hour < 24);
    isValid &= (minute >= 0 && minute < 60);
    isValid &= (second >= 0 && second < 60);
    isValid &= month > 0 && month < 13;
    
    bool isLeapYear = _isLeapYearFromBaseYear(year);
    isValid &= (day > 0 && day <= (_monthCount[month-1] + (isLeapYear&&month==2?1:0)));
    
    return isValid;
}

int isValidSHDateTime(SHDatetime const *dt){
    return dt && _areTimeComponentsValid(dt->year,dt->month,dt->day,dt->hour,dt->minute
      ,dt->second);
}

bool tryCreateDateTime(long year,int month,int day,int hour,int minute,int second
  ,int timezoneOffset,double *ans,int *error){
    *error = NO_ERROR;
    bool isValid = _areTimeComponentsValid(year,month,day,hour,minute,second);
    if(!isValid) return setErrorCode(GEN_ERROR,error);
    double sum;
    long leapYearCount = _calcNumLeapYearsBaseLeap(year);
    bool isLeapYear = _isLeapYearFromBaseYear(year);
    if(year >= BASE_YEAR){
        long span = year - BASE_YEAR;
        int dayTotal = _monthSums[month-1];
        long yearStart = span*DAY_IN_SECONDS*365 + DAY_IN_SECONDS*leapYearCount;
        dayTotal+=(day-1);
        int FEB_DAY_SUM = 59;
        int leapDayOffset = isLeapYear &&
          (dayTotal > FEB_DAY_SUM||(month==3&&dayTotal== FEB_DAY_SUM)) ?
          1:0;
        sum = yearStart + dayTotal*DAY_IN_SECONDS + leapDayOffset*DAY_IN_SECONDS;
        sum += (hour*HOUR_IN_SECONDS + minute*MIN_IN_SECONDS + second);
    }
    else{
        long span = year - BASE_YEAR + 1;
        int dayTotal = _backwardMonthSums[month-1];
        long yearStart = span*DAY_IN_SECONDS*NORMAL_YEAR_DAYS - DAY_IN_SECONDS*leapYearCount;
        day = day - _monthCount[month-1] - (isLeapYear&&dayTotal >= 306?1:0);
        dayTotal= day - dayTotal;
        sum = yearStart + dayTotal*DAY_IN_SECONDS;
        sum+=((hour-23)*HOUR_IN_SECONDS + (minute-59)*MIN_IN_SECONDS + (second -60));
    }
    sum -= timezoneOffset;
    *ans = sum;
    return true;
}

double createDate(long year,int month,int day,int timezoneOffset,int *error){
    *error = NO_ERROR;
    double ans;
    tryCreateDate(year,month,day,timezoneOffset,&ans,error);
    return ans;
}

bool tryCreateDate(long year,int month,int day,int timezoneOffset,double *ans,
    int *error){
    *error = NO_ERROR;
    return tryCreateDateTime(year,month,day,0,0,0,timezoneOffset,ans,error);
}

double createTime(int hour,int minute,int second,int *error){
    *error = NO_ERROR;
    double ans;
    tryCreateTime(hour,minute,second,&ans,error);
    return ans;
}

bool tryCreateTime(int hour,int minute,int second,double *ans,int *error){
    *error = NO_ERROR;
    double tmpAns = *ans;
    bool result = tryCreateDateTime(1970,1,1,hour,minute,second,0,&tmpAns,error);
    *ans = (int)tmpAns;
    return result;
}

bool _filDateTimeObj(long year,int month,int day,int hour,int min,int sec,
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

long _calcShiftedTimestamp(long timestamp,long years,int isBeforeEpoch){
    if(years > 1){
        return (timestamp % (years*SECONDS_PER_YEAR));
    }
    else if(years == 1){
        return timestamp + (isBeforeEpoch?SECONDS_PER_YEAR:-SECONDS_PER_YEAR);
    }
    return timestamp;
}


bool tryTimestampToDt(double timestamp, int timezoneOffset,SHDatetime *dt,int *error){
    *error = NO_ERROR;
    if(!dt) return setErrorCode(NULL_VALUES,error);
    if(!_isTimestampRangeInvalid(timestamp,timezoneOffset,error)) return false;
    if(timestamp - timezoneOffset == 0){
        return _filDateTimeObj(BASE_YEAR,1,1,0,0,0,timezoneOffset,dt);
    }
    timestamp += timezoneOffset;
    bool isBeforeEpoch = timestamp < 0;
    long totalYears = _calcYears(timestamp);
    long yearCorrection = isBeforeEpoch?(1969 -2000):2000-1970;
    bool isLeapYear = _isLeapYearCorrected(totalYears,yearCorrection);
    long shiftedTimestamp = _calcShiftedTimestamp(timestamp,totalYears
                              ,isBeforeEpoch);
    totalYears *= (isBeforeEpoch?MIRROR_BEFORE_EPOCH:EPOCH_NEUTRAL);
    int baseYear = isBeforeEpoch?1969:1970;
    if(shiftedTimestamp == YEAR_CUSP){
      return _filDateTimeObj(baseYear + totalYears,1,1,0,0,0,timezoneOffset,dt);
    }
    
    long leapCount = _calcNumLeapYearsBaseLeap(totalYears+baseYear);
    if(isBeforeEpoch){
        long complimentYear = (isLeapYear?SPECIAL_TIMESTAMP:SECONDS_PER_YEAR)
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

bool timestampToDtUnitsOnly(double timestamp,SHDatetime *dt,int *error){
    *error = NO_ERROR;
    Timeshift *shifts = dt->shifts;
    int shiftLen = dt->shiftLen;
    int shiftIdx = dt->currentShiftIdx;
    if(!tryTimestampToDt(timestamp,dt->timezoneOffset,dt,error)){
        return setErrorCode(*error,error);
    }
    dt->shifts = shifts;
    dt->shiftLen = shiftLen;
    dt->currentShiftIdx = shiftIdx;
    return true;
}

bool tryDtToTimestamp(SHDatetime const *dt,double *ans,int *error){
    *error = NO_ERROR;
    if(!dt) return setErrorCode(NULL_VALUES,error);
    return tryCreateDateTime(dt->year,dt->month,dt->day,dt->hour,dt->minute,dt->second,
      dt->timezoneOffset,ans,error);
}

double dtToTimestamp(SHDatetime const *dt,int *error){
    *error = NO_ERROR;
    if(!dt) return setErrorCode(NULL_VALUES,error);
    double ans;
    tryDtToTimestamp(dt,&ans,error);
    return ans;
}


bool tryExtractTime(SHDatetime *dt,double *ans,int *error){
    *error = NO_ERROR;
    if(!dt) return setErrorCode(NULL_VALUES,error);
    return tryCreateTime(dt->hour,dt->minute,dt->second,ans,error);
}


double extractTime(SHDatetime *dt,int *error){
    *error = NO_ERROR;
    if(!dt) return setErrorCode(NULL_VALUES,error);
    double ans;
    tryExtractTime(dt,&ans,error);
    return ans;
}



bool tryAddDaysToDtInPlace(SHDatetime *dt,long days,TimeAdjustOptions options,int *error){
    (void)options;
    *error = NO_ERROR;
    if(!dt) return setErrorCode(NULL_VALUES,error);
    double converted;
    if(!tryDtToTimestamp(dt,&converted,error)) return false;
    double ans;
    if(!tryAddDaysToTimestamp(converted,days,0,&ans,error)) return false;
    if(!timestampToDtUnitsOnly(ans,dt,error))return false;
    return updateTimezoneForShifts(dt,error);
}


bool tryAddDaysToDt(SHDatetime const *dt,long days,TimeAdjustOptions options
  ,SHDatetime *ans,int *error){
    *error = NO_ERROR;
    if(!dt) return setErrorCode(NULL_VALUES,error);
    *ans = *dt;
    return tryAddDaysToDtInPlace(ans,days,options,error);

}

#pragma GCC diagnostic push
#pragma GCC diagnostic ignored "-Wunused-parameter"

bool tryAddDaysToTimestamp(double timestamp,long days, TimeAdjustOptions options,
   double *ans,int *error){
    (void)options;
    *error = NO_ERROR;
    timestamp += (days*DAY_IN_SECONDS);
    *ans = timestamp;
    return true;
}

#pragma GCC diagnostic pop

bool tryAddMonthsToDt(SHDatetime const *dt,long months,TimeAdjustOptions options
  ,SHDatetime *ans,int *error){
    *error = NO_ERROR;
    if(!dt) return setErrorCode(NULL_VALUES,error);
    *ans = *dt;
    return tryAddMonthsToDtInPlace(ans,months,options,error);
}

bool tryAddMonthsToDtInPlace(SHDatetime *dt,long months,TimeAdjustOptions options
  ,int *error){
    *error = NO_ERROR;
    if(!dt) return setErrorCode(NULL_VALUES,error);
    if(months == 0) return true;
    if(options == NO_OPTION) options = SHIFT_BKD;
    long totalMonths = months + dt->month;
    int exMonths = totalMonths % YEAR_IN_MONTHS;
    long years = totalMonths / YEAR_IN_MONTHS;
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
    updateTimezoneForShifts(dt,error);
    return true;
}

bool tryAddMonthsToTimestamp(double timestamp,long months,int timezoneOffset,
  TimeAdjustOptions options,double *ans,int *error){
    *error = NO_ERROR;
    SHDatetime dt;
    if(!tryTimestampToDt(timestamp,timezoneOffset,&dt,error)) return false;
    if(!tryAddMonthsToDtInPlace(&dt,months,options,error)) return false;
    return tryDtToTimestamp(&dt,ans,error);
}

static bool _addYears_SHIFT(SHDatetime *dt,long years, TimeAdjustOptions options
  ,int *error) {
    *error = NO_ERROR;
    long yearSum = years + dt->year;
    options = options == NO_OPTION?SHIFT_BKD:options;
    if(options & ERROR){
        if(!_isLeapYearFromBaseYear(yearSum)&&_isLeapDayCusp(dt)){
            return setErrorCode(GEN_ERROR,error);
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
    return setErrorCode(GEN_ERROR,error);
}

double addYearsToTimestamp(double timestamp,long years,int timezoneOffset,
  TimeAdjustOptions options,int *error){
    *error = NO_ERROR;
    double ans;
    tryAddYearsToTimestamp(timestamp,years,timezoneOffset,options,&ans,error);
    return ans;
}

bool tryAddYearsToTimestamp(double timestamp,long years,int timezoneOffset,
  TimeAdjustOptions options,double *ans,int *error){
    *error = NO_ERROR;
    SHDatetime dt;
    if(!tryTimestampToDt(timestamp,timezoneOffset,&dt,error)) return false;
    if(!tryAddYearsToDtInPlace(&dt,years,options,error)) return false;
    return tryDtToTimestamp(&dt,ans,error);
}

bool tryAddYearsToDt(SHDatetime const *dt,long years,TimeAdjustOptions options
  ,SHDatetime *ans,int *error){
    *error = NO_ERROR;
    if(!dt) return setErrorCode(NULL_VALUES,error);
    *ans = *dt;
    return tryAddYearsToDtInPlace(ans,years,options,error);
}

bool tryAddYearsToDtInPlace(SHDatetime *dt,long years,TimeAdjustOptions options
  ,int *error){
    *error = NO_ERROR;
    if(!dt) return setErrorCode(NULL_VALUES,error);
    if(years == 0) return true;
    
    if((options &(SHIFT_BKD|SHIFT_FWD))||options == NO_OPTION){
        return _addYears_SHIFT(dt,years, options,error);
    }
    if(options & SIMPLE){
        double timestamp;
        if(!tryDtToTimestamp(dt,&timestamp,error)) return false;
        timestamp += years*SECONDS_PER_YEAR;
        if(!tryTimestampToDt(timestamp,dt->timezoneOffset,dt,error)) return false;
        return true;
    }
    return false;
}

bool tryDayStart(double timestamp,int timezoneOffset,double *ans,int *error){
    *error = NO_ERROR;
    SHDatetime dt;
    if(!tryTimestampToDt(timestamp,timezoneOffset,&dt,error)) return false;
    dt.hour = 0;
    dt.minute = 0;
    dt.second = 0;
    return tryDtToTimestamp(&dt,ans,error);
}


int calcWeekdayIdx(SHDatetime *dt,int *error){
    double timestamp;
    *error = NO_ERROR;
    if(!tryDtToTimestamp(dt,&timestamp,error)) return NOT_FOUND;
    int ans;
    timestamp += dt->timezoneOffset;
    bool isAfterEpoch = dt->year >= BASE_YEAR;
    if(isAfterEpoch){
        long totalDays = timestamp/DAY_IN_SECONDS;
        //if within the first week
        if(totalDays < WEEK_START_DAYS_AFTER){
            return (int)totalDays + EPOCH_WEEK_CORRECTION;
        }
        totalDays = totalDays - WEEK_START_DAYS_AFTER;
        ans = totalDays % 7;
        return ans;
    }
    long totalDays = (timestamp/DAY_IN_SECONDS);

    totalDays = totalDays -3;
    ans = (((totalDays % 7) + 7) % 7);
    return ans;
}


bool tryDiffDateSecs(SHDatetime const *A,SHDatetime const *B,long *ans,int *error){
    *error = NO_ERROR;
    if(!isValidSHDateTime(A)) return setErrorCode(GEN_ERROR,error);
    if(!isValidSHDateTime(B)) return setErrorCode(GEN_ERROR,error);
    int errorA,errorB;
    errorA = errorB = 0;
    *ans = dtToTimestamp(A,&errorA) - dtToTimestamp(B,&errorB);
    if(errorA | errorB) return errorA | errorB;
    return true;
}

double dateDiffSecs(SHDatetime const *A,SHDatetime const *B,int *error){
    *error = NO_ERROR;
    if(!A||!B) return setErrorCode(NULL_VALUES,error);
    long ans;
    tryDiffDateSecs(A,B,&ans,error);
    return ans;
}


long dateDiffDays(SHDatetime const *A,SHDatetime const *B,int *error){
    *error = NO_ERROR;
    if(!A||!B) return setErrorCode(NULL_VALUES,error);
    long ans;
    tryDateDiffDays(A,B,&ans,error);
    return ans;
}


bool tryDateDiffDays(SHDatetime const *A,SHDatetime const *B,long *ans,int *error){
    *error = NO_ERROR;
    if(!A||!B) return setErrorCode(NULL_VALUES,error);
    *ans = dateDiffSecs(A,B,error);
    *ans /= DAY_IN_SECONDS;
    if(*error) return setErrorCode(*error,error);
    return true;
}


bool initDt(SHDatetime *dt){
    if(!dt) return false;
    dt->currentShiftIdx = -1;
    dt->day = 1;
    dt->hour = 0;
    dt->minute = 0;
    dt->month = 1;
    dt->second = 0;
    dt->shiftLen = 0;
    dt->shifts = NULL;
    return true;
}


bool initTimeshift(Timeshift *shift){
    if(!shift) return false;
    shift->adjustment = 0;
    shift->day = 0;
    shift->hour = 0;
    shift->minute = 0;
    shift->month = 0;
    return true;
}

