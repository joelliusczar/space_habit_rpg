//
//	NSDate+DateHelper.m
//	HabitRPG2
//
//	Created by Joel Pridgen on 6/3/17.
//	Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import "NSDate+DateHelper.h"
#import "NSLocale+Helper.h"
#import <objc/runtime.h>
#import "NSException+SHCommonExceptions.h"
#import "SHSingletonCluster.h"


@implementation NSDate (DateHelper)



-(NSDate *)dateAfterYears:(NSInteger)y months:(NSInteger)m days:(NSInteger)d{
	SHDatetime dt;
	int tzOffset = (int)[NSTimeZone.defaultTimeZone secondsFromGMTForDate:self];
	SHError error;
	memset(&error, 0, sizeof(SHError));
	SH_timestampToDt(self.timeIntervalSince1970,tzOffset,&dt,&error);
	SH_addYearsToDtInPlace(&dt,y,0,&error);
	SH_addMonthsToDt(&dt,m,0,&error);
	SH_addDaysToDt(&dt,d,0,&error);
	return [NSDate dateWithTimeIntervalSince1970:shDtToTimestamp(&dt,&error)];
}


-(NSDate *)timeAfterHours:(NSInteger)h minutes:(NSInteger)m
	seconds:(NSInteger)s
{
	NSCalendar *calendar = SharedGlobal.inUseCalendar;
	NSDate *dt = [calendar dateByAddingUnit:NSCalendarUnitHour value:h
		toDate:self options:0];
	
	dt = [calendar dateByAddingUnit:NSCalendarUnitMinute value:m
		toDate:dt options:0];
	
	dt = [calendar dateByAddingUnit:NSCalendarUnitSecond value:s
		toDate:dt options:0];
	
	return dt;
}


+(NSDate *)createDateTimeWithYear:(NSInteger)year month:(NSInteger)month
	day:(NSInteger)day hour:(NSInteger)hour
	minute:(NSInteger)minute second:(NSInteger)second
	timeZone:(NSTimeZone *)timeZone
{
	double timestamp;
	SHError error;
	memset(&error, 0, sizeof(SHError));
	SH_timestampCalc(year,(int32_t)month,(int32_t)day,(int32_t)hour,(int32_t)minute,(int32_t)second
	,(int32_t)(timeZone.secondsFromGMT),&timestamp,&error);
	return [NSDate dateWithTimeIntervalSince1970:timestamp];
	
}


+(NSDate *)createDateTimeWithYear:(NSInteger)year month:(NSInteger)month
	day:(NSInteger)day hour:(NSInteger)hour
	minute:(NSInteger)minute second:(NSInteger)second
{
	return [NSDate createDateTimeWithYear:year month:month day:day
		hour:hour minute:minute second:second
		timeZone:NSTimeZone.defaultTimeZone];
}


+(NSDate *)createSimpleTimeWithHour:(NSInteger)hour minute:(NSInteger)minute
	second:(NSInteger)second timzone:(NSTimeZone *)timeZone
{
	return [NSDate createDateTimeWithYear:1970 month:1 day:1
		hour:hour minute:minute second:second timeZone:timeZone];
}


+(NSDate *)createSimpleTimeWithHour:(NSInteger)hour minute:(NSInteger)minute
	second:(NSInteger)second
{
	NSTimeZone *timeZone = [NSTimeZone timeZoneForSecondsFromGMT:0];
	return [NSDate createSimpleTimeWithHour:hour minute:minute second:second
		timzone:timeZone];
}


+(NSDate *)createSimpleDateWithYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day{
	return [NSDate createDateTimeWithYear:year month:month day:day hour:0 minute:0 second:0];
}


-(NSDate *)dayStart{
	NSInteger timestamp = self.timeIntervalSince1970;
	double dayStartTimestamp;
	SHError error;
	memset(&error, 0, sizeof(SHError));
	shTryDayStart(timestamp,(int32_t)NSTimeZone.defaultTimeZone.secondsFromGMT, &dayStartTimestamp, &error);
	return [NSDate dateWithTimeIntervalSince1970:dayStartTimestamp];
}


+(NSInteger)daysBetween:(NSDate *)fromDate to:(NSDate *)toDate{
	SHDatetime dtFrom;
	SHDatetime dtTo;
	SHError err;
	memset(&err, 0, sizeof(SHError));
	SH_timestampToDt(fromDate.timeIntervalSince1970
		,(int32_t)NSTimeZone.defaultTimeZone.secondsFromGMT,&dtFrom,&err);
	SH_timestampToDt(toDate.timeIntervalSince1970
		,(int32_t)NSTimeZone.defaultTimeZone.secondsFromGMT,&dtTo,&err);

	return shDateDiffDays(&dtTo,&dtFrom,&err);
}


+(NSInteger)SH_fullWeeksBetween:(NSDate *)fromDate to:(NSDate *)toDate
	withWeekStartOffset:(NSUInteger)weekStartOffset
{
	NSDate *firstFullWeek = [fromDate SH_calcNextWeekStartWithDayOffset:weekStartOffset];
	NSDate *lastFullWeek = [toDate SH_calcWeekStartWithDayOffset:weekStartOffset];
	NSInteger daysBetween = [self daysBetween:firstFullWeek to:lastFullWeek];
	if(daysBetween < 0) return 0;
	return daysBetween / SH_DAYS_IN_WEEK;
}


+(NSInteger)SH_fullWeeksBetween:(NSDate *)fromDate to:(NSDate *)toDate {
	NSUInteger sundayOffset = 0;
	return [self SH_fullWeeksBetween:fromDate to:toDate withWeekStartOffset:sundayOffset];
}


-(NSDate *)setHour:(NSInteger)h minute:(NSInteger)m second:(NSInteger)s{
	NSDate *roundedDownDate = [SharedGlobal.inUseCalendar startOfDayForDate:self];
	return [roundedDownDate timeAfterHours:h minutes:m seconds:s];
}


+(NSString *)timeOfDayInSystemPreferredFormat:(NSInteger)hour
	andMinute:(NSInteger)minute
{
	NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
	formatter.locale = SharedGlobal.inUseLocale;
	formatter.timeStyle = NSDateFormatterShortStyle;
	NSDate *date = [NSDate createSimpleTimeWithHour:hour minute:minute second:0];
	NSString *dateString = [formatter stringFromDate: date];
	
	return dateString;
}


-(NSString *)timeOfDayInSystemPreferredFormat{
	return [self timeOfDayWithLocale:SharedGlobal.inUseLocale
	andTimeZone:NSTimeZone.defaultTimeZone];
}


-(NSString *)timeOfDayWithLocale:(NSLocale*)locale andTimeZone:(NSTimeZone*)tz{
	NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
	formatter.locale = locale;
	formatter.timeZone = tz;
	formatter.timeStyle = NSDateFormatterShortStyle;
	NSString *dateString = [formatter stringFromDate:self];
	
	return dateString;
}


-(NSString *)staticTimeOfDay{
	NSTimeZone *tz = [NSTimeZone timeZoneForSecondsFromGMT:0];
	return [self timeOfDayWithLocale:SharedGlobal.inUseLocale andTimeZone:tz];
}


-(NSString *)extractTimeInFormat:(SHHourFormatType)format{
	
	NSDateComponents *components = [SharedGlobal.inUseCalendar
		components:NSCalendarUnitHour|NSCalendarUnitMinute
		fromDate:self];
	NSInteger convertedHour = [NSLocale hour:components.hour inGivenFormatMask:format];
	return [NSString stringWithFormat:@"%ld:%ld",convertedHour,components.minute];
}


-(NSUInteger)SH_getWeekdayIndexOffsetForStartDayIdx:(NSInteger)dayOffset {
	
	NSUInteger resultDayIdx = ([self getWeekdayIndex] + SH_DAYS_IN_WEEK - dayOffset) % SH_DAYS_IN_WEEK;
	return resultDayIdx;
	
	
}


-(NSUInteger)getWeekdayIndex{
	SHDatetime dt;
	int32_t tzOffset = (int32_t)[NSTimeZone.defaultTimeZone secondsFromGMT];
	SHError error;
	memset(&error, 0, sizeof(SHError));
	SH_timestampToDt(self.timeIntervalSince1970, tzOffset, &dt, &error);
	return SH_calcWeekdayIdx(&dt, &error);
}


-(NSDateComponents *)getDateComponents{
	NSCalendarUnit calendarUnits = (252 + 2097152); //magic number for year,month,day,hour,min,sec
	NSDateComponents *components = [NSCalendar.currentCalendar
		components:calendarUnits
		fromDate:self];
	return components;
}


-(NSDate *)timeAfterSeconds:(NSInteger)seconds{
	NSTimeInterval timestamp = self.timeIntervalSince1970;
	timestamp += seconds;
	return [NSDate dateWithTimeIntervalSince1970:timestamp];
}


-(NSDate *)dateInTimezone:(NSTimeZone *)tz {
	NSTimeInterval adjustedTimestamp = self.timeIntervalSince1970 + tz.secondsFromGMT;
	return [NSDate dateWithTimeIntervalSince1970:adjustedTimestamp];
}


static SHDatetime* _nsDateToShDatetime(NSDate *date, int32_t tzOffset) {
	SHDatetime *dt = calloc(ALLOC_COUNT, sizeof(SHDatetime));
	SHError error;
	memset(&error, 0, sizeof(SHError));
	
	SH_timestampToDt(date.timeIntervalSince1970,tzOffset,dt,&error);
	if(error.code) {
		@throw [NSException encounterSHError:&error];
	}
	return dt;
}

-(SHDatetime *)toSHDatetime {
	int32_t tzOffset = (int32_t)[NSTimeZone.defaultTimeZone secondsFromGMT];
	return _nsDateToShDatetime(self, tzOffset);
}

-(SHDatetime *)toSHDatetimeUTC {
	return _nsDateToShDatetime(self, 0);
}


-(NSDate *)SH_calcWeekStartWithDayOffset:(NSUInteger)dayOffset {
	SHDatetime *dt = [self toSHDatetime];
	SHDatetime *ans = calloc(ALLOC_COUNT, sizeof(SHDatetime));
	SHError error;
	NSDate *weekStart = nil;
	int32_t timeShiftCount = 1;
	memset(&error, 0, sizeof(SHError));
	if(!SH_tryCalcWeekStartWithDayOffset(dt, &error, (int32_t)dayOffset, ans)) {
		goto cleanup;
	}
	double weekStartTimeStamp = shDtToTimestamp(ans, &error);
	weekStart = [[NSDate alloc] initWithTimeIntervalSince1970:weekStartTimeStamp];
	cleanup:
		shFreeSHDatetime(dt, timeShiftCount);
		shFreeSHDatetime(ans, timeShiftCount);
		if(error.isError) {
			@throw [NSException encounterSHError:&error];
		}
	return weekStart;
}


-(NSDate*)SH_calcWeekStart {
	SHDatetime *dt = [self toSHDatetime];
	SHDatetime *ans = calloc(ALLOC_COUNT, sizeof(SHDatetime));
	SHError error;
	NSDate *weekStart = nil;
	int32_t timeShiftCount = 1;
	memset(&error, 0, sizeof(SHError));
	if(!SH_tryCalcWeekStart(dt, &error, ans)) {
		goto cleanup;
	}
	double weekStartTimeStamp = shDtToTimestamp(ans, &error);
	weekStart = [[NSDate alloc] initWithTimeIntervalSince1970:weekStartTimeStamp];
	cleanup:
		shFreeSHDatetime(dt, timeShiftCount);
		shFreeSHDatetime(ans, timeShiftCount);
		if(error.isError) {
			@throw [NSException encounterSHError:&error];
		}
	return weekStart;
}


-(NSDate *)SH_calcNextWeekStartWithDayOffset:(NSUInteger)dayOffset {
	SHDatetime *dt = [self toSHDatetime];
	SHDatetime *ans = calloc(ALLOC_COUNT, sizeof(SHDatetime));
	SHError error;
	NSDate *nextWeekStart = nil;
	int32_t timeShiftCount = 1;
	memset(&error, 0, sizeof(SHError));
	if(!SH_calcNextWeekStartWithDayOffset(dt, &error, (int32_t)dayOffset, ans)) {
		goto cleanup;
	}
	double nextWeekStartTimeStamp = shDtToTimestamp(ans, &error);
	nextWeekStart = [[NSDate alloc] initWithTimeIntervalSince1970:nextWeekStartTimeStamp];
	cleanup:
		shFreeSHDatetime(dt, timeShiftCount);
		shFreeSHDatetime(ans, timeShiftCount);
		if(error.isError) {
			@throw [NSException encounterSHError:&error];
		}
	return nextWeekStart;
}


-(NSDate*)SH_calcNextWeekStart {
	SHDatetime *dt = [self toSHDatetime];
	SHDatetime *ans = calloc(ALLOC_COUNT, sizeof(SHDatetime));
	SHError error;
	NSDate *nextWeekStart = nil;
	int32_t timeShiftCount = 1;
	memset(&error, 0, sizeof(SHError));
	
	if(!SH_calcNextWeekStart(dt, &error, ans)) {
		goto cleanup;
	}
	double nextWeekStartTimeStamp = shDtToTimestamp(ans, &error);
	nextWeekStart = [[NSDate alloc] initWithTimeIntervalSince1970:nextWeekStartTimeStamp];
	cleanup:
		shFreeSHDatetime(dt, timeShiftCount);
		shFreeSHDatetime(ans, timeShiftCount);
		if(error.isError) {
			@throw [NSException encounterSHError:&error];
		}
	return nextWeekStart;
}


-(BOOL)SH_isSameWeekAs:(NSDate *)date withDayOffset:(NSUInteger)dayOffset {
	SHDatetime *dt = [self toSHDatetime];
	SHDatetime *otherDt = [date toSHDatetime];
	SHError error;
	memset(&error, 0, sizeof(SHError));
	bool result = SH_areSameWeekWithDayOffset(dt, otherDt, (int32_t)dayOffset, &error);

	int32_t timeShiftCount = 1;
	shFreeSHDatetime(dt, timeShiftCount);
	shFreeSHDatetime(otherDt, timeShiftCount);
	if(error.isError) {
		@throw [NSException encounterSHError:&error];
	}
	return result;
}


-(BOOL)SH_isSameWeekAs:(NSDate*)date {
	SHDatetime *dt = [self toSHDatetime];
	SHDatetime *otherDt = [date toSHDatetime];
	SHError error;
	memset(&error, 0, sizeof(SHError));
	bool result = SH_areSameWeek(dt, otherDt, &error);

	int32_t timeShiftCount = 1;
	shFreeSHDatetime(dt, timeShiftCount);
	shFreeSHDatetime(otherDt, timeShiftCount);
	if(error.isError) {
		@throw [NSException encounterSHError:&error];
	}
	return result;
}

@end
