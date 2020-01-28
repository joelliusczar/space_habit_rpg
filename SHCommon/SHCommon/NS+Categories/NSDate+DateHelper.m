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
#import <SHDatetime/SHDatetimeFuncs.h>
#import <SHErrorHandling.h>
#import "NSException+SHCommonExceptions.h"
#import "SHSingletonCluster.h"


@implementation NSDate (DateHelper)



-(NSDate *)dateAfterYears:(NSInteger)y months:(NSInteger)m days:(NSInteger)d{
	SHDatetime dt;
	int tzOffset = (int)[NSTimeZone.defaultTimeZone secondsFromGMTForDate:self];
	SHError error;
	memset(&error, 0, sizeof(SHError));
	shTryTimestampToDt(self.timeIntervalSince1970,tzOffset,&dt,&error);
	shTryAddYearsToDtInPlace(&dt,y,0,&error);
	shTryAddMonthsToDtInPlace(&dt,m,0,&error);
	shTryAddDaysToDtInPlace(&dt,d,0,&error);
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
	shTryCreateDateTime(year,(int)month,(int)day,(int)hour,(int)minute,(int)second
	,(int)(timeZone.secondsFromGMT),&timestamp,&error);
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
	shTryDayStart(timestamp,(int)NSTimeZone.defaultTimeZone.secondsFromGMT,&dayStartTimestamp,&error);
	return [NSDate dateWithTimeIntervalSince1970:dayStartTimestamp];
}


+(NSInteger)daysBetween:(NSDate *)fromDate to:(NSDate *)toDate{
	SHDatetime dtFrom;
	SHDatetime dtTo;
	SHError err;
	memset(&err, 0, sizeof(SHError));
	shTryTimestampToDt(fromDate.timeIntervalSince1970
		,(int)NSTimeZone.defaultTimeZone.secondsFromGMT,&dtFrom,&err);
	shTryTimestampToDt(toDate.timeIntervalSince1970
						 ,(int)NSTimeZone.defaultTimeZone.secondsFromGMT,&dtTo,&err);

	return shDateDiffDays(&dtTo,&dtFrom,&err);
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


-(NSInteger)getWeekdayIndex{
	SHDatetime dt;
	int tzOffset = (int)[NSTimeZone.defaultTimeZone secondsFromGMTForDate:self];
	SHError error;
	memset(&error, 0, sizeof(SHError));
	shTryTimestampToDt(self.timeIntervalSince1970,tzOffset,&dt,&error);
	return shCalcWeekdayIdx(&dt,&error);
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

@end
