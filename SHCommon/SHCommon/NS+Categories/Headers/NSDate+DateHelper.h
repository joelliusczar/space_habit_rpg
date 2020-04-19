//
//	NSDate+DateHelper.h
//	HabitRPG2
//
//	Created by Joel Pridgen on 6/3/17.
//	Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import "SHConstants.h"
@import SHDatetime;
@import Foundation;



@interface NSDate (DateHelper)
-(NSDate *)dateAfterYears:(NSInteger)y months:(NSInteger)m days:(NSInteger)d;
-(NSDate *)timeAfterHours:(NSInteger)h minutes:(NSInteger)m seconds:(NSInteger)s;
+(NSDate *)createDateTimeWithYear:(NSInteger)year month:(NSInteger)month
	day:(NSInteger)day hour:(NSInteger)hour
	minute:(NSInteger)minute second:(NSInteger)second;
+(NSDate *)createDateTimeWithYear:(NSInteger)year month:(NSInteger)month
	day:(NSInteger)day hour:(NSInteger)hour
	minute:(NSInteger)minute second:(NSInteger)second
	timeZone:(NSTimeZone *)timeZone;
	

+(NSInteger)daysBetween:(NSDate *)fromDate to:(NSDate *)toDate;
+(NSInteger)SH_fullWeeksBetween:(NSDate *)fromDate to:(NSDate *)toDate;

+(NSInteger)SH_fullWeeksBetween:(NSDate *)fromDate to:(NSDate *)toDate
withWeekStartOffset:(NSUInteger)weekStartOffset;

-(NSDate *)setHour:(NSInteger)h minute:(NSInteger)m second:(NSInteger)s;
+(NSDate *)createSimpleTimeWithHour:(NSInteger)hour minute:(NSInteger)minute
	second:(NSInteger)second timzone:(NSTimeZone *)timeZone;
	
+(NSDate *)createSimpleTimeWithHour:(NSInteger)hour minute:(NSInteger)minute
	second:(NSInteger)second;
	
+(NSDate *)createSimpleDateWithYear:(NSInteger)year month:(NSInteger)month
	day:(NSInteger)day;
	
+(NSString *)timeOfDayInSystemPreferredFormat:(NSInteger)hour
	andMinute:(NSInteger)minute;
	
-(NSDate *)dayStart;
-(NSString *)extractTimeInFormat:(SHHourFormatType)format;
-(NSUInteger)getWeekdayIndex;
-(NSUInteger)SH_getWeekdayIndexOffsetForStartDayIdx:(NSInteger)dayOffset;
-(NSDateComponents *)getDateComponents;
-(NSString *)timeOfDayInSystemPreferredFormat;
-(NSString *)staticTimeOfDay;
-(NSDate *)timeAfterSeconds:(NSInteger)seconds;
-(NSDate *)dateInTimezone:(NSTimeZone *)tz;
-(SHDatetime *)toSHDatetime;
-(SHDatetime *)toSHDatetimeUTC;
-(NSDate*)SH_calcWeekStart;
-(NSDate *)SH_calcWeekStartWithDayOffset:(NSUInteger)dayOffset;
-(NSDate*)SH_calcNextWeekStart;
-(NSDate *)SH_calcNextWeekStartWithDayOffset:(NSUInteger)dayOffset;
-(BOOL)SH_isSameWeekAs:(NSDate*)date;
-(BOOL)SH_isSameWeekAs:(NSDate *)date withDayOffset:(NSUInteger)dayOffset;
@end

