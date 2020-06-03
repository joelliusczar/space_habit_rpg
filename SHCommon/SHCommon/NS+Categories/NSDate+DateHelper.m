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
#import "NSCalendar+SHHelper.h"


@implementation NSDate (DateHelper)


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
	NSDateComponents *components = [[NSDateComponents alloc] init];
	components.hour = hour;
	components.minute = minute;
	NSCalendar *calendar = [NSCalendar calendarWithIdentifier:NSCalendarIdentifierGregorian];
	NSDate *date = [calendar dateFromComponents:components];
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


-(NSDateComponents *)getDateComponents{
	NSCalendarUnit calendarUnits = (252 + 2097152); //magic number for year,month,day,hour,min,sec
	NSDateComponents *components = [NSCalendar.SH_appCalendar
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


static struct SHDatetime* _nsDateToShDatetime(NSDate *date, int32_t tzOffset) {
	struct SHDatetime *dt = calloc(SH_ALLOC_COUNT, sizeof(struct SHDatetime));
	
	if(SH_timestampToDt(date.timeIntervalSince1970, tzOffset, dt) != SH_NO_ERROR) {
		SH_freeSHDatetime(dt, SH_ALLOC_COUNT);
		@throw [NSException encounterError];
	}

	return dt;
}


-(struct SHDatetime *)SH_toSHDatetime {
	int32_t tzOffset = (int32_t)[NSTimeZone.defaultTimeZone secondsFromGMT];
	return _nsDateToShDatetime(self, tzOffset);
}

-(struct SHDatetime *)SH_toSHDatetimeUTC {
	return _nsDateToShDatetime(self, 0);
}






@end
