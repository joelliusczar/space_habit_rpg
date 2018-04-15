 //
//  c_datetime.c
//  SHCommon
//
//  Created by Joel Pridgen on 3/10/18.
//  Copyright © 2018 Joel Gillette. All rights reserved.
//

#include "SHDatetime.h"
#include "SHConstants.h"
#include <limits.h>
#include <stdbool.h>
#include <stdlib.h>

static int _monthSums[12] = {0,31,59,90,120,151,181,212,243,273,304,334};
static int _backwardMonthSums[12] = {334,306,275,245,214,184,153,122,92,61,31,0};
static int _monthCount[12] = {31,28,31,30,31,30,31,31,30,31,30,31};

typedef struct{
    long totalMins;
    int exSecs;
    long totalHours;
    long totalDays;
    
} TimeCalcResult;

static int _getMonthFromDaySum(int daySum, int isLeapYear){
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

static int _isTimestampRangeInvalid(long timestamp,int timezoneOffset){
    if(timestamp < 0 && (YEAR_ZERO_FIRST_SEC - timestamp) > -1*timezoneOffset) return GEN_ERROR;
    if(timestamp > 0 && (LONG_MAX - timestamp) < timezoneOffset) return GEN_ERROR;
    return NO_ERROR;
}

static long _calcNumLeapYears(long year) {
    long mod = year > 0?year:year + -1*year*4; //for neg numbers, factor was abitrary
    long ans = (year + 4 - (mod % 4))/4;
    return ans < 0?-1*ans:ans;
}

static long _calcNumLeapYearsBaseLeap(long year){
    long dif = year - FIRST_LEAP_YEAR + (year >= FIRST_LEAP_YEAR?-1:0);
    return _calcNumLeapYears(dif);
}

static int _isLeapYear(long years){
    return !(years % 4);
}

static int _isLeapYearFromBaseYear(long year){
    long diff = year - FIRST_LEAP_YEAR;
    return _isLeapYear(diff);
}


static int _isLeapDayCusp(SHDateTime *dt){
    return dt->month == 2 && dt->day == 29;
}

static long _calcYears(long seconds){
    int beforeEpochOffset = seconds < 0?1:0;
    seconds = seconds < 0?-1*seconds:seconds;
    seconds -= beforeEpochOffset;
    int excess = seconds % LEAP_CYCLE_UNIX;
    long years = 0;
    long leapCycles = seconds / LEAP_CYCLE_UNIX;
    if(excess > UNIX_LEAP_YEAR_LAST_SEC){
        years++;
        excess -= UNIX_LEAP_YEAR;
    }
    else{
        return (leapCycles*LEAP_CYCLE_YEAR);
    }
    years += (excess/UNIX_YEAR) + (leapCycles*LEAP_CYCLE_YEAR);
    return years;
}


static void _calcTimeFromTimestamp(long timestamp,int minOffset,TimeCalcResult *result){
    result->totalMins = timestamp / UNIX_MIN;
    result->exSecs = timestamp % 60;
    result->totalMins += ((result->exSecs+minOffset) / 60);
    result->totalHours = result->totalMins/60;
    result->totalDays = result->totalHours / 24;
}

long createDateTime(long year,int month,int day,int hour,int minute,int second
  ,int timezoneOffset,int *error){
    long ans;
    *error = tryCreateDateTime(year,month,day,hour,minute,second,timezoneOffset,&ans);
    return ans;
}

int _areTimeComponentsValid(long year,int month,int day,int hour,int minute,int second){
    int isValid = year >= 0;
    isValid &= (hour >= 0 && hour < 24);
    isValid &= (minute >= 0 && minute < 60);
    isValid &= (second >= 0 && second < 60);
    isValid &= month > 0 && month < 13;
    
    int isLeapYear = _isLeapYearFromBaseYear(year);
    isValid &= (day > 0 && day <= (_monthCount[month-1] + (isLeapYear&&month==2?1:0)));
    
    return isValid;
}

int isValidSHDateTime(SHDateTime const *dt){
    return _areTimeComponentsValid(dt->year,dt->month,dt->day,dt->hour,dt->minute
      ,dt->second);
}

int tryCreateDateTime(long year,int month,int day,int hour,int minute,int second
  ,int timezoneOffset,long *ans){
    int isValid = _areTimeComponentsValid(year,month,day,hour,minute,second);
    if(!isValid) return GEN_ERROR;
    long sum;
    long leapYearCount = _calcNumLeapYearsBaseLeap(year);
    int isLeapYear = _isLeapYearFromBaseYear(year);
    if(year >= BASE_YEAR){
        long span = year - BASE_YEAR;
        int dayTotal = _monthSums[month-1];
        long yearStart = span*UNIX_DAY*365 + UNIX_DAY*leapYearCount;
        dayTotal+=(day-1);
        int FEB_DAY_SUM = 59;
        int leapDayOffset = isLeapYear
          &&(dayTotal > FEB_DAY_SUM||(month==3&&dayTotal== FEB_DAY_SUM))
          ?1:0;
        sum = yearStart + dayTotal*UNIX_DAY + leapDayOffset*UNIX_DAY;
        sum+=(hour*UNIX_HOUR + minute*UNIX_MIN + second);
    }
    else{
        long span = year - BASE_YEAR + 1;
        int dayTotal = _backwardMonthSums[month-1];
        long yearStart = span*UNIX_DAY*NORMAL_YEAR_DAYS - UNIX_DAY*leapYearCount;
        day = day - _monthCount[month-1] - (isLeapYear&&dayTotal >= 306?1:0);
        dayTotal=day - dayTotal;
        sum = yearStart + dayTotal*UNIX_DAY;
        sum+=((hour-23)*UNIX_HOUR + (minute-59)*UNIX_MIN + (second -60));
    }
    sum -= timezoneOffset;
    *ans = sum;
    return NO_ERROR;
}

long createDate(long year,int month,int day,int timezoneOffset,int *error){
    long ans;
    *error = tryCreateDate(year,month,day,timezoneOffset,&ans);
    return ans;
}

int tryCreateDate(long year,int month,int day,int timezoneOffset,long *ans){
    return tryCreateDateTime(year,month,day,0,0,0,timezoneOffset,ans);
}

int createTime(int hour,int minute,int second,int *error){
    int ans;
    *error = tryCreateTime(hour,minute,second,&ans);
    return ans;
}

int tryCreateTime(int hour,int minute,int second,int *ans){
    long tmpAns = *ans;
    int error;
    error = tryCreateDateTime(1970,1,1,hour,minute,second,0,&tmpAns);
    *ans = (int)tmpAns;
    return error;
}

int _filDateTimeObj(long year,int month,int day,int hour,int min,int sec,
  int timezoneOffset,SHDateTime *dt){
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
    return NO_ERROR;
}

void _timestampShortToDateObj(int timestamp,SHDateTime *dt){
    TimeCalcResult result;
    int isBeforeEpoch = timestamp < 0;
    timestamp += (isBeforeEpoch?UNIX_YEAR:0);
    _calcTimeFromTimestamp(timestamp,0,&result);
    int totalYears = (int)(result.totalDays/NORMAL_YEAR_DAYS);
    int exDays = (int)result.totalDays -totalYears*NORMAL_YEAR_DAYS + INCLUDE_TODAY;
    int month = _getMonthFromDaySum(exDays,false);
    exDays -= _monthSums[month -1];
    int exHours = result.totalHours % DAY_HOURS;
    int exMin = result.totalMins % MIN_SEC_LEN;
    int year = isBeforeEpoch?BEFORE_EPOCH_BASE_YEAR:BASE_YEAR + totalYears;
    _filDateTimeObj(year,month,exDays,exHours,exMin,result.exSecs,0,dt);
}

long _calcShiftedTimestamp(long timestamp,long years,int isBeforeEpoch){
    if(years > 1){
        return (timestamp % (years*UNIX_YEAR));
    }
    else if(years == 1){
        return timestamp + (isBeforeEpoch?UNIX_YEAR:-UNIX_YEAR);
    }
    return timestamp;
}

int timestampToDt(long timestamp, int timezoneOffset,SHDateTime *dt){
    if(!dt) return GEN_ERROR;
    if(_isTimestampRangeInvalid(timestamp,timezoneOffset)) return GEN_ERROR;
    if(timestamp - timezoneOffset == 0){
        return _filDateTimeObj(BASE_YEAR,1,1,0,0,0,timezoneOffset,dt);
    }
    timestamp += timezoneOffset;
    if(timestamp > TIMESTAMP_END_1968 && timestamp < TIMESTAMP_BEGIN_1972){
      _timestampShortToDateObj((int)timestamp,dt);
      dt->timezoneOffset = timezoneOffset;
      return NO_ERROR;
    }
    int isBeforeEpoch = timestamp < 0;
    long leapBasedTimestamp = isBeforeEpoch?timestamp+UNIX_YEAR:timestamp - 2*UNIX_YEAR;
    long totalYears = _calcYears(leapBasedTimestamp);
    int isLeapYear = !((totalYears)%LEAP_CYCLE_YEAR);
    long shiftedTimestamp = _calcShiftedTimestamp(leapBasedTimestamp,totalYears,isBeforeEpoch);
    int baseYear = isBeforeEpoch?LEAP_YEAR_BEFORE_EPOCH:FIRST_LEAP_YEAR;
    if(shiftedTimestamp == YEAR_CUSP){
      totalYears *= (isBeforeEpoch?MIRROR_BEFORE_EPOCH:EPOCH_NEUTRAL);
      return _filDateTimeObj(baseYear + totalYears,1,1,0,0,0,timezoneOffset,dt);
    }
    totalYears *= (isBeforeEpoch?MIRROR_BEFORE_EPOCH:EPOCH_NEUTRAL);
    long leapCount = _calcNumLeapYearsBaseLeap(totalYears+baseYear);
    if(isBeforeEpoch){
        long complimentYear = (isLeapYear?UNIX_LEAP_YEAR:UNIX_YEAR) + leapCount*UNIX_DAY;
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
    int exHours = result.totalHours % DAY_HOURS;
    int exMins = result.totalMins % MIN_SEC_LEN;
    
    return _filDateTimeObj(totalYears+baseYear,month,exDays,exHours,exMins,result.exSecs
             ,timezoneOffset,dt);
}

int timestampToDtUnitsOnly(long timestamp,SHDateTime *dt){
    TimeShift *shifts = dt->shifts;
    int shiftLen = dt->shiftLen;
    int shiftIdx = dt->currentShiftIdx;
    if(timestampToDt(timestamp,dt->timezoneOffset,dt))return GEN_ERROR;
    dt->shifts = shifts;
    dt->shiftLen = shiftLen;
    dt->currentShiftIdx = shiftIdx;
    return NO_ERROR;
}

int tryDtToTimestamp(SHDateTime const *dt,long *ans){
    if(!dt) return GEN_ERROR;
    return tryCreateDateTime(dt->year,dt->month,dt->day,dt->hour,dt->minute,dt->second,
      dt->timezoneOffset,ans);
}

long dtToTimestamp(SHDateTime const *dt,int *error){
    long ans;
    *error = tryDtToTimestamp(dt,&ans);
    return ans;
}


int tryExtractTime(SHDateTime *dt,int *ans){
    return tryCreateTime(dt->hour,dt->minute,dt->second,ans);
}


int extractTime(SHDateTime *dt,int *error){
    int ans;
    *error = tryExtractTime(dt,&ans);
    return ans;
}



int tryAddDaysToDtInPlace(SHDateTime *dt,long days,TimeAdjustOptions options){
    (void)options;
    long converted;
    if(tryDtToTimestamp(dt,&converted)) return INVALID_STATE;
    long ans;
    if(tryAddDaysToTimestamp(converted,days,0,&ans)) return GEN_ERROR;
    if(timestampToDtUnitsOnly(ans,dt))return GEN_ERROR;
    return updateTimezoneForShifts(dt);
}

int tryAddDaysToDt(SHDateTime const *dt,long days,TimeAdjustOptions options,SHDateTime *ans){
    *ans = *dt;
    return tryAddDaysToDtInPlace(ans,days,options);

}

int tryAddDaysToTimestamp(long timestamp,long days, TimeAdjustOptions options,long *ans){
    (void)options;
    timestamp += (days*UNIX_DAY);
    *ans = timestamp;
    return NO_ERROR;
}

int tryAddMonthsToDt(SHDateTime const *dt,long months,TimeAdjustOptions options
  ,SHDateTime *ans){
    *ans = *dt;
    return tryAddMonthsToDtInPlace(ans,months,options);
}

int tryAddMonthsToDtInPlace(SHDateTime *dt,long months,TimeAdjustOptions options){
    if(months == 0) return NO_ERROR;
    if(options == NO_OPTION) options = SHIFT_BKD;
    long totalMonths = months + dt->month;
    int exMonths = totalMonths % YEAR_MONTHS;
    long years = totalMonths / YEAR_MONTHS;
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
    updateTimezoneForShifts(dt);
    return NO_ERROR;
}

int tryAddMonthsToTimestamp(long timestamp,long months,int timezoneOffset
  ,TimeAdjustOptions options,long *ans){
    SHDateTime dt;
    if(timestampToDt(timestamp,timezoneOffset,&dt)) return GEN_ERROR;
    if(tryAddMonthsToDtInPlace(&dt,months,options)) return GEN_ERROR;
    return tryDtToTimestamp(&dt,ans);
}

static int _addYears_SHIFT(SHDateTime *dt,long years, TimeAdjustOptions options) {
    long yearSum = years + dt->year;
    options = options == NO_OPTION?SHIFT_BKD:options;
    if(options & ERROR){
        if(!_isLeapYearFromBaseYear(yearSum)&&_isLeapDayCusp(dt)){
            return GEN_ERROR;
        }
        dt->year = yearSum;
        return NO_ERROR;
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
        return NO_ERROR;
    }
    return GEN_ERROR;
}

long addYearsToTimestamp(long timestamp,long years,int timezoneOffset
  ,TimeAdjustOptions options,int *error){
    long ans;
    *error = tryAddYearsToTimestamp(timestamp,years,timezoneOffset,options,&ans);
    return ans;
}

int tryAddYearsToTimestamp(long timestamp,long years,int timezoneOffset
  ,TimeAdjustOptions options,long *ans){
    SHDateTime dt;
    if(timestampToDt(timestamp,timezoneOffset,&dt)) return GEN_ERROR;
    if(tryAddYearsToDtInPlace(&dt,years,options)) return GEN_ERROR;
    return tryDtToTimestamp(&dt,ans);
}

int tryAddYearsToDt(SHDateTime const *dt,long years,TimeAdjustOptions options
  ,SHDateTime *ans){
    *ans = *dt;
    return tryAddYearsToDtInPlace(ans,years,options);
}

int tryAddYearsToDtInPlace(SHDateTime *dt,long years,TimeAdjustOptions options){
    if(years == 0) return NO_ERROR;
    
    if((options &(SHIFT_BKD|SHIFT_FWD))||options == NO_OPTION){
        return _addYears_SHIFT(dt,years, options);
    }
    if(options & SIMPLE){
        long timestamp;
        if(tryDtToTimestamp(dt,&timestamp)) return GEN_ERROR;
        timestamp += years*UNIX_YEAR;
        if(timestampToDt(timestamp,dt->timezoneOffset,dt)) return GEN_ERROR;
        return NO_ERROR;
    }
    return GEN_ERROR;
}

int tryDayStart(long timestamp,int timezoneOffset,long *ans){
    SHDateTime dt;
    if(timestampToDt(timestamp,timezoneOffset,&dt)) return GEN_ERROR;
    dt.hour = 0;
    dt.minute = 0;
    dt.second = 0;
    return tryDtToTimestamp(&dt,ans);
}


int calcWeekdayIdx(SHDateTime *dt,int *error){
    long tmp;
    if((*error = tryDtToTimestamp(dt,&tmp))) return NOT_FOUND;
    int ans;
    if(tryCalcWeekdayIdx(tmp,dt->timezoneOffset,&ans)) return NOT_FOUND;
    return ans;
}


int tryCalcWeekdayIdx(long timestamp,int timezoneOffset,int *ans){
    if(_isTimestampRangeInvalid(timestamp,timezoneOffset)) return GEN_ERROR;
    timestamp -= timezoneOffset;
    long totalDays = timestamp/UNIX_DAY;
    //if within the first week
    if(totalDays > -1*WEEK_START_DAYS_BEFORE && totalDays < WEEK_START_DAYS_AFTER){
        return (int)totalDays + EPOCH_WEEK_CORRECTION;
    }
    totalDays = totalDays > 0?totalDays - WEEK_START_DAYS_AFTER:
      -1*totalDays - WEEK_START_DAYS_BEFORE;
    *ans = totalDays % 7;
    return NO_ERROR;
}

int tryDiffDateSecs(SHDateTime const *A,SHDateTime const *B,long *ans){
    if(!isValidSHDateTime(A)) return GEN_ERROR;
    if(!isValidSHDateTime(B)) return GEN_ERROR;
    int errorA,errorB;
    errorA = errorB = 0;
    *ans = dtToTimestamp(A,&errorA) - dtToTimestamp(B,&errorB);
    if(errorA | errorB) return errorA | errorB;
    return NO_ERROR;
}

long dateDiffSecs(SHDateTime const *A,SHDateTime const *B,int *error){
    long ans;
    *error = NO_ERROR;
    *error = tryDiffDateSecs(A,B,&ans);
    return ans;
}

long dateDiffDays(SHDateTime const *A,SHDateTime const *B,int *error){
    long ans;
    *error = NO_ERROR;
    *error = tryDateDiffDays(A,B,&ans);
    return ans;
}

int tryDateDiffDays(SHDateTime const *A,SHDateTime const *B,long *ans){
    int error = NO_ERROR;
    *ans = dateDiffSecs(A,B,&error);
    *ans /= UNIX_DAY;
    return error;
}

