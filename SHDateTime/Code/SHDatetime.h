//
//  c_datetime.h
//  SHCommon
//
//  Created by Joel Pridgen on 3/10/18.
//  Copyright © 2018 Joel Gillette. All rights reserved.
//


#ifndef datetime_h
#define datetime_h

#include <stdio.h>
#include <stdbool.h>
#include "DTConstants.h"
#include "SHTimeZone.h"


typedef enum {NO_OPTION = 0,
    SHIFT_FWD = 1,
    SHIFT_BKD = 2,
    ERROR = 3,
    SIMPLE = 4,
} TimeAdjustOptions;

/*
 *****
    "try" prefixed on a method means the result is stored in a pointer passed as an argument
    and any errors are returned.
 *****
 */

/*
 createDateTime:
 Converts time units to unix epoch time
 year: ex. 1988
 month: between 1 and 12
 day: between 1 and 31,30,29, or 28 depending on month and year
 hour: between 0 and 23
 minute: between 0 and 59
 second: between 0 and 59
 timezoneOffset: whatever, this should probably be a real timezone
 error: pointer to variable to store an error number, right now it's just
   pass(0) or fail(1)
 returns: the unix epoch timestamp
 */
long createDateTime(long year,int month,int day,int hour,int minute,int second
  ,int timezoneOffset, int *error);

/*
 tryCreateDateTime:
 Converts time units to unix epoch time
 year: ex. 1988
 month: between 1 and 12
 day: between 1 and 31,30,29, or 28 depending on month and year
 hour: between 0 and 23
 minute: between 0 and 59
 second: between 0 and 59
 timezoneOffset: whatever, this should probably be a real timezone
 ans: pointer to variable to store result
 error: pointer to variable to store an error number, right now it's just
   pass(0) or fail(1)
 returns:  true for pass, false for fail
 */
bool tryCreateDateTime(long year,int month,int day,int hour,int minute,int second
  ,int timezoneOffset, long *ans,int *error);

/*
 createDate:
 Converts time units to unix epoch time at start of day
 year: ex. 1988
 month: between 1 and 12
 day: between 1 and 31,30,29, or 28 depending on month and year
 timezoneOffset: whatever, this should probably be a real timezone
 error: pointer to variable to store an error number, right now it's just
   pass(0) or fail(1)
 returns: the unix epoch timestamp
 */
long createDate(long year,int month,int day,int timezoneOffset,int *error);

/*
 tryCreateDate:
 Converts time units to unix epoch time at start of day
 year: ex. 1988
 month: between 1 and 12
 day: between 1 and 31,30,29, or 28 depending on month and year
 timezoneOffset: whatever, this should probably be a real timezone
 error: pointer to variable to store an error number, right now it's just
 pass(0) or fail(1)
 ans: pointer to variable to store result
 error: pointer to variable to store an error number, right now it's just
   pass(0) or fail(1)
 returns:true for pass, false for fail
 */
bool tryCreateDate(long year,int month,int day,int timezoneOffset,long *ans,int *error);

/*
 createTime:
 Converts time units to unix epoch time jan 1,1970. This is always less than a day
 hour: between 0 and 23
 minute: between 0 and 59
 second: between 0 and 59
 error: pointer to variable to store an error number, right now it's just
   pass(0) or fail(1)
 returns: the unix epoch timestamp for the time
 */
int createTime(int hour,int minute,int second,int *error);

/*
 tryCreateTime:
 Converts time units to unix epoch time jan 1,1970. This is always less than a day
 hour: between 0 and 23
 minute: between 0 and 59
 second: between 0 and 59
 ans: pointer to variable to store result
 returns:true for pass, false for fail
 */
bool tryCreateTime(int hour,int minute,int second,int *ans,int *error);

/*
 extractTime:
 gets the time in seconds from the hour,minute, and seconds on the SHDatetime
 dt:SHDateTime to get hour,minute,and seconds from
 error:pointer to variable to store an error number, right now it's just
   pass(0) or fail(1)
 error: pointer to variable to store an error number, right now it's just
   pass(0) or fail(1)
 returns:timestamp for day
 */
int extractTime(SHDatetime *dt,int *error);

/*
 tryExtractTime:
 gets the time in seconds from the hour,minute, and seconds on the SHDatetime
 dt:SHDateTime to get hour,minute,and seconds from
 ans: pointer to variable to store result
 error: pointer to variable to store an error number, right now it's just
   pass(0) or fail(1)
 returns:true for pass, false for fail
 */
bool tryExtractTime(SHDatetime *dt,int *ans,int *error);

/*
 timestampToDt:
 converts a unix timestamp to year,month,day,hour,second and stores it in an
   SHDateTime
 timestamp: a unix epoch timestamp
 timezoneOffset: whatever, this should probably be a real timezone
 dt: the SHDateTime to store the results in
 error: pointer to variable to store an error number, right now it's just
   pass(0) or fail(1)
 return: true for pass, false for fail
 */
bool tryTimestampToDt(long timestamp, int timezoneOffset,SHDatetime *dt,int *error);

/*
 timestampToDtUnitsOnly:
 this is like timestampToDateObj but it retains any existing values on SHDateTime obj
 timestamp: a unix epoch timestamp
 dt: the SHDateTime to store the results in
 error: pointer to variable to store an error number, right now it's just
   pass(0) or fail(1)
 return: true for pass, false for fail
 */
bool timestampToDtUnitsOnly(long timestamp,SHDatetime *dt,int *error);

/*
 dtToTimestamp:
 this is a wrapper around createDateTime. It takes the components on the SHDateTime
 and converts them to an epoch timestamp
 dt: the SHDateTime that we're pulling the time units from
 error: pointer to variable to store an error number, right now it's just
   pass(0) or fail(1)
 return: the epoch timestamp
 */
long dtToTimestamp(SHDatetime const *dt,int *error);

/*
 tryDtToTimestamp:
 this is a wrapper around createDateTime. It takes the components on the SHDateTime
   and converts them to an epoch timestamp
 dt: the SHDateTime that we're pulling the time units from
 ans: pointer to variable to store result
 error: pointer to variable to store an error number, right now it's just
   pass(0) or fail(1)
 return: true for pass, false for fail
 */
bool tryDtToTimestamp(SHDatetime const *dt,long *ans,int *error);

/*
 tryAddYearsToDt:
 adds years to a date object while keeping track of things such as leap days
 dt: we use this as base time
 years: how ever many you want
 options: use this to determine if non leap years on feb 29 should go to feb 28,
   or mar 1; or if it should just simply add the timestamps, or return an error
 ans: stores the timechanges in here
 error: pointer to variable to store an error number, right now it's just
   pass(0) or fail(1)
 return: true for pass, false for fail
 */
bool tryAddYearsToDt(SHDatetime const *dt,long years,TimeAdjustOptions options,
  SHDatetime *ans,int *error);

/*
 tryAddYearsToDtInPlace:
 this is the same as tryAddYearsToDt but changes are in place
 dt: we use this as base time, and we update it
 years: how ever many you want
 options: use this to determine if non leap years on feb 29 should go to feb 28,
   or mar 1; or if it should just simply add the timestamps, or return an error
 error: pointer to variable to store an error number, right now it's just
   pass(0) or fail(1)
 return: true for pass, false for fail
 */
bool tryAddYearsToDtInPlace(SHDatetime *dt,long years,TimeAdjustOptions options
  ,int *error);

/*
 addYearsToTimestamp:
 adds years to epoch timestamp
 timestamp: a unix epoch timestamp
 years: nothing to say here
 timezoneOffset: whatever, this should probably be a real timezone
 options: use this to determine if non leap years on feb 29 should go to feb 28,
   or mar 1; or if it should just simply add the timestamps, or return an error
 error: pointer to variable to store an error number, right now it's just
   pass(0) or fail(1)
 return: the ajusted timestamp
 */
long addYearsToTimestamp(long timestamp,long years,int timezoneOffset
  ,TimeAdjustOptions options,int *error);

/*
 tryAddYearsToTimestamp:
 adds years to epoch timestamp
 timestamp: a unix epoch timestamp
 years: nothing to say here
 timezoneOffset: whatever, this should probably be a real timezone
 options: use this to determine if non leap years on feb 29 should go to feb 28,
   or mar 1; or if it should just simply add the timestamps, or return an error
 ans: pointer to variable to store result
 error: pointer to variable to store an error number, right now it's just
   pass(0) or fail(1)
 return: true for pass, false for fail
 */
bool tryAddYearsToTimestamp(long timestamp,long years,int timezoneOffset
  ,TimeAdjustOptions options,long *ans,int *error);

/*
 tryAddMonthsToDt:
 adds months to a date object while keeping track of things such as year adjustments
 dt: we use this as base time
 months: how ever many you want
 options: use this to determine if non leap years on feb 29 should go to feb 28,
 or mar 1; or if it should just simply add the timestamps, or return an error
 ans: stores the timechanges in here
 error: pointer to variable to store an error number, right now it's just
   pass(0) or fail(1)
 return: true for pass, false for fail
 */
bool tryAddMonthsToDt(SHDatetime const *dt,long months,TimeAdjustOptions options
                     ,SHDatetime *ans,int *error);

/*
 tryAddMonthsToDtInPlace:
 this is the same as tryAddMonthsToDt but changes are in place
 dt: we use this as base time, and we update it
 years: how ever many you want
 options: use this to determine if non leap years on feb 29 should go to feb 28,
 or mar 1; or if it should just simply add the timestamps, or return an error
 error: pointer to variable to store an error number, right now it's just
   pass(0) or fail(1)
 return: true for pass, false for fail
 */
bool tryAddMonthsToDtInPlace(SHDatetime *dt,long months,TimeAdjustOptions options
  ,int *error);

/*
 tryAddMonthsToTimestamp:
 adds months to epoch timestamp
 timestamp: a unix epoch timestamp
 years: nothing to say here
 timezoneOffset: whatever, this should probably be a real timezone
 options: use this to determine if non leap years on feb 29 should go to feb 28,
 or mar 1; or if it should just simply add the timestamps, or return an error
 ans: pointer to variable to store result
 error: pointer to variable to store an error number, right now it's just
   pass(0) or fail(1)
 return: true for pass, false for fail
 */
bool tryAddMonthsToTimestamp(long timestamp,long months,int timezoneOffset
  ,TimeAdjustOptions options,long *ans,int *error);

/*
 tryAddDaysToDt:
 adds days to a date object while keeping track of things such as year adjustments
 dt: we use this as base time
 days: how ever many you want
 options: (currently not used)use this to determine if non leap years on feb 29
 should go to feb 28, or mar 1; or if it should just simply add the timestamps,
 or return an error
 error: pointer to variable to store an error number, right now it's just
   pass(0) or fail(1)
 ans: stores the timechanges in here
 return: true for pass, false for fail
 */
bool tryAddDaysToDt(SHDatetime const *dt,long days,TimeAdjustOptions options
  ,SHDatetime *ans,int *error);

/*
 tryAddDaysToDtInPlace:
 this is the same as tryAddDaysToDt but changes are in place
 dt: we use this as base time, and we update it
 days: how ever many you want
 options: use this to determine if non leap years on feb 29 should go to feb 28,
 or mar 1; or if it should just simply add the timestamps, or return an error
 error: pointer to variable to store an error number, right now it's just
   pass(0) or fail(1)
 return: true for pass, false for fail
 */
bool tryAddDaysToDtInPlace(SHDatetime *dt,long days,TimeAdjustOptions options
  ,int *error);

/*
 tryAddDaysToTimestamp:
 adds days to epoch timestamp
 timestamp: a unix epoch timestamp
 day: nothing to say here
 timezoneOffset: whatever, this should probably be a real timezone
 options: use this to determine if non leap years on feb 29 should go to feb 28,
 or mar 1; or if it should just simply add the timestamps, or return an error
  ans: pointer to variable to store result
 error: pointer to variable to store an error number, right now it's just
   pass(0) or fail(1)
 return: true for pass, false for fail
 */
bool tryAddDaysToTimestamp(long timestamp,long day,TimeAdjustOptions options, long *ans
  ,int *error);

/*
 tryDayStart:
 takes a timestamp and returns a new one with same date but at the beginning.
 timestamp: a unix epoch timestamp
 timezoneOffset: whatever, this should probably be a real timezone
 ans: pointer to variable to store result
 error: pointer to variable to store an error number, right now it's just
   pass(0) or fail(1)
 return: true for pass, false for fail
 */
bool tryDayStart(long timestamp,int timezoneOffset,long *ans,int *error);

/*
calcWeekdayIdx:
takes a SHDateTime and infers what the day of the week is. By default, Sunday is 0,
  Saturday is 6
dt: extract the weekday from this
error: pointer to variable to store an error number, right now it's just
   pass(0) or fail(1)
 return: index 0 - 6 of the day of the week that dt represents, -1 if there was an error
 */
int calcWeekdayIdx(SHDatetime *dt,int *error);

/*
 dateDiffDays:
 calculates the number of days between the dates represented by A, and B
 A: the date subtracted from
 B: the date that is subtracting
 error: pointer to variable to store an error number, right now it's just
   pass(0) or fail(1)
 return: the difference between two dates in days. This can be negative
 */
long dateDiffDays(SHDatetime const *A,SHDatetime const *B,int *error);

/*
 tryDateDiffDays:
 calculates the number of days between the dates represented by A, and B
 A: the date subtracted from
 B: the date that is subtracting
 ans: pointer to variable to store result. the difference between two dates in days.
   This can be negative
 error: pointer to variable to store an error number, right now it's just
   pass(0) or fail(1)
 return: true for pass, false for fail
 */
bool tryDateDiffDays(SHDatetime const *A,SHDatetime const *B,long *ans,int *error);

/*
 dateDiffSecs:
 calculates the number of seconds between the dates represented by A, and B
 A: the date subtracted from
 B: the date that is subtracting
 error: pointer to variable to store an error number, right now it's just
 pass(0) or fail(1)
 return: the difference between two dates in seconds. This can be negative
 */
long dateDiffSecs(SHDatetime const *A,SHDatetime const *B,int *error);

/*
 tryDiffDateSecs:
 calculates the number of seconds between the dates represented by A, and B
 A: the date subtracted from
 B: the date that is subtracting
 ans: pointer to variable to store result. the difference between two dates in seconds.
 This can be negative
 error: pointer to variable to store an error number, right now it's just
   pass(0) or fail(1)
 return: true for pass, false for fail
 */
bool tryDiffDateSecs(SHDatetime const *A,SHDatetime const *B,long *ans,int *error);

/*
 isValidSHDateTime:
 this tests if an SHDateTime object has valid properties. ie. year is greater than 0,
   and less than whatever the max possible year is; the month is between 1 and 12; etc.
 returns: 1 or 0, true or false
 */
int isValidSHDateTime(SHDatetime const *dt);

/*
 initDt:
 zeros out an SHDatetime object
 dt: the datetime object we're setting to factory state.
 */
bool initDt(SHDatetime *dt);

/*
 initTimeshift:
 zeros out a Timeshift object
 shift: the Timeshift object we're setting to factory state.
 */
bool initTimeshift(Timeshift *shift);

#endif /* datetime_h */
