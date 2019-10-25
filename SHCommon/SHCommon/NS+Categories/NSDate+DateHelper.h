//
//	NSDate+DateHelper.h
//	HabitRPG2
//
//	Created by Joel Pridgen on 6/3/17.
//	Copyright © 2017 Joel Pridgen. All rights reserved.
//

@import Foundation;
@import SHGlobal;

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
-(NSDate *)dayStart;
+(NSInteger)daysBetween:(NSDate *)fromDate to:(NSDate *)toDate;
-(NSDate *)setHour:(NSInteger)h minute:(NSInteger)m second:(NSInteger)s;
+(NSDate *)createSimpleTimeWithHour:(NSInteger)hour minute:(NSInteger)minute
	second:(NSInteger)second timzone:(NSTimeZone *)timeZone;
+(NSDate *)createSimpleTimeWithHour:(NSInteger)hour minute:(NSInteger)minute
	second:(NSInteger)second;
+(NSDate *)createSimpleDateWithYear:(NSInteger)year month:(NSInteger)month
	day:(NSInteger)day;
+(NSString *)timeOfDayInSystemPreferredFormat:(NSInteger)hour
	andMinute:(NSInteger)minute;
-(NSString *)extractTimeInFormat:(SHHourFormatType)format;
-(NSInteger)getWeekdayIndex;
-(NSDateComponents *)getDateComponents;
-(NSString *)timeOfDayInSystemPreferredFormat;
-(NSString *)staticTimeOfDay;
-(NSDate *)timeAfterSeconds:(NSInteger)seconds;
@end

