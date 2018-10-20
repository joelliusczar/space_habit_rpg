//
//  SHDatetimeMod.h
//  SHDatetime
//
//  Created by Joel Pridgen on 8/25/18.
//  Copyright © 2018 Joel Gillette. All rights reserved.
//

#ifndef SHDatetimeMod_h
#define SHDatetimeMod_h

#include <stdio.h>
#include <stdbool.h>
#include <inttypes.h>
#include "DTConstants.h"
#include "SHTimeZone.h"
#include "ErrorHandling.h"

/*
 *****
 "try" prefixed on a method means the result is stored in a pointer passed as an argument
 and any errors are returned.
 *****
 */


double createDateTime_m(int64_t year,int month,int day,int hour,int minute,int second,int timezoneOffset
,SHError *error);

bool tryCreateDateTime_m(int64_t year,int month,int day,int hour,int minute,int second,int timezoneOffset
,double *ans,SHError *error);

double createDate_m(int64_t year,int month,int day,int timezoneOffset,SHError *error);

bool tryCreateDate_m(int64_t year,int month,int day,int timezoneOffset,double *ans,SHError *error);

double createTime_m(int hour,int minute,int second,SHError *error);

bool tryCreateTime_m(int hour,int minute,int second,double *ans,SHError *error);

double extractTime_m(SHDatetime *dt,SHError *error);

bool tryExtractTime_m(SHDatetime *dt,double *ans,SHError *error);

bool tryTimestampToDt_m(double timestamp, int timezoneOffset,SHDatetime *dt,SHError *error);

bool timestampToDtUnitsOnly_m(double timestamp,SHDatetime *dt,SHError *error);

double dtToTimestamp_m(SHDatetime const *dt,SHError *error);

bool tryDtToTimestamp_m(SHDatetime const *dt,double *ans,SHError *error);

bool tryAddYearsToDt_m(SHDatetime const *dt,int64_t years,TimeAdjustOptions options,SHDatetime *ans
,SHError *error);

bool tryAddYearsToDtInPlace_m(SHDatetime *dt,int64_t years,TimeAdjustOptions options,SHError *error);

double addYearsToTimestamp_m(double timestamp,int64_t years,int timezoneOffset,TimeAdjustOptions options
,SHError *error);

bool tryAddYearsToTimestamp_m(double timestamp,int64_t years,int timezoneOffset,TimeAdjustOptions options
,double *ans,SHError *error);

bool tryAddMonthsToDt_m(SHDatetime const *dt,int64_t months,TimeAdjustOptions options,SHDatetime *ans
,SHError *error);

bool tryAddMonthsToDtInPlace_m(SHDatetime *dt,int64_t months,TimeAdjustOptions options,SHError *error);

bool tryAddMonthsToTimestamp_m(double timestamp,int64_t months,int timezoneOffset,TimeAdjustOptions options
,double *ans,SHError *error);

bool tryAddDaysToDt_m(SHDatetime const *dt,int64_t days,TimeAdjustOptions options,SHDatetime *ans
,SHError *error);

bool tryAddDaysToDtInPlace_m(SHDatetime *dt,int64_t days,TimeAdjustOptions options,SHError *error);

bool tryAddDaysToTimestamp_m(double timestamp,int64_t day,TimeAdjustOptions options,double *ans
,SHError *error);

bool tryDayStart_m(double timestamp,int timezoneOffset,double *ans,SHError *error);

SHDatetime* dayStartInPlace(SHDatetime *dt);

int calcWeekdayIdx_m(SHDatetime *dt,SHError *error);

int calcDayOfYear_m(SHDatetime *dt,SHError *error);

int calcDayOfYearFromTimestamp_m(double timestamp,int timezoneOffset,SHError * error);

int64_t dateDiffDays_m(SHDatetime const *A,SHDatetime const *B,SHError *error);

bool tryDateDiffDays_m(SHDatetime const *A,SHDatetime const *B,int64_t *ans,SHError *error);

double dateDiffSecs_m(SHDatetime const *A,SHDatetime const *B,SHError *error);

bool tryDiffDateSecs_m(SHDatetime const *A,SHDatetime const *B,int64_t *ans,SHError *error);

bool isValidSHDateTime_m(SHDatetime const *dt);

void SHDTToString(SHDatetime const *dt,char* str);
#endif /* SHDatetimeMod_h */


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

/*
 tryCreateTime:
 Converts time units to unix epoch time jan 1,1970. This is always less than a day
 hour: between 0 and 23
 minute: between 0 and 59
 second: between 0 and 59
 ans: pointer to variable to store result
 returns:true for pass, false for fail
 */

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

/*
 tryExtractTime:
 gets the time in seconds from the hour,minute, and seconds on the SHDatetime
 dt:SHDateTime to get hour,minute,and seconds from
 ans: pointer to variable to store result
 error: pointer to variable to store an error number, right now it's just
 pass(0) or fail(1)
 returns:true for pass, false for fail
 */

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

/*
 timestampToDtUnitsOnly:
 this is like timestampToDateObj but it retains any existing values on SHDateTime obj
 timestamp: a unix epoch timestamp
 dt: the SHDateTime to store the results in
 error: pointer to variable to store an error number, right now it's just
 pass(0) or fail(1)
 return: true for pass, false for fail
 */

/*
 dtToTimestamp:
 this is a wrapper around createDateTime. It takes the components on the SHDateTime
 and converts them to an epoch timestamp
 dt: the SHDateTime that we're pulling the time units from
 error: pointer to variable to store an error number, right now it's just
 pass(0) or fail(1)
 return: the epoch timestamp
 */

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

/*
dayStart(SHDatetime *dt):
 this basically sets the hour, miniute, second to 0
 dt: this doesn't necessarily even need to be a valid SHDatetime object,
 no point sending it but nothing stopping you.
 return: this returns the original datetime object you send in.
 */

/*
 calcWeekdayIdx:
 takes a SHDateTime and infers what the day of the week is. By default, Sunday is 0,
 Saturday is 6
 dt: extract the weekday from this
 error: pointer to variable to store an error number, right now it's just
 pass(0) or fail(1)
 return: index 0 - 6 of the day of the week that dt represents, -1 if there was an error
 */

/*
 dateDiffDays:
 calculates the number of days between the dates represented by A, and B
 A: the date subtracted from
 B: the date that is subtracting
 error: pointer to variable to store an error number, right now it's just
 pass(0) or fail(1)
 return: the difference between two dates in days. This can be negative
 */

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

/*
 dateDiffSecs:
 calculates the number of seconds between the dates represented by A, and B
 A: the date subtracted from
 B: the date that is subtracting
 error: pointer to variable to store an error number, right now it's just
 pass(0) or fail(1)
 return: the difference between two dates in seconds. This can be negative
 */

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

/*
 isValidSHDateTime:
 this tests if an SHDateTime object has valid properties. ie. year is greater than 0,
 and less than whatever the max possible year is; the month is between 1 and 12; etc.
 returns: 1 or 0, true or false
 */


