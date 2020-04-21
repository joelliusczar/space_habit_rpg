//
//	NSDate+DateHelper.h
//	HabitRPG2
//
//	Created by Joel Pridgen on 6/3/17.
//	Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import "SHConstants.h"
//@import SHDatetime;
@import Foundation;



@interface NSDate (DateHelper)
-(NSDate *)timeAfterHours:(NSInteger)h minutes:(NSInteger)m seconds:(NSInteger)s;
	
-(NSDate *)setHour:(NSInteger)h minute:(NSInteger)m second:(NSInteger)s;
	
+(NSString *)timeOfDayInSystemPreferredFormat:(NSInteger)hour
	andMinute:(NSInteger)minute;
	
-(NSString *)extractTimeInFormat:(SHHourFormatType)format;
-(NSDateComponents *)getDateComponents;
-(NSString *)timeOfDayInSystemPreferredFormat;
-(NSString *)staticTimeOfDay;
-(NSDate *)timeAfterSeconds:(NSInteger)seconds;
-(NSDate *)dateInTimezone:(NSTimeZone *)tz;
@end

