//
//  NSDate+DateHelper.h
//  HabitRPG2
//
//  Created by Joel Pridgen on 6/3/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "constants.h"

@interface NSDate (DateHelper)
@property (class,strong,atomic) NSLocale *inUseLocale;
@property (class,strong,atomic) NSCalendar *inUseCalendar;
@property (class,strong,atomic) NSTimeZone *inUseTimeZone;
-(NSDate *)adjustDate:(NSInteger)y month:(NSInteger)m day:(NSInteger)d;
-(NSDate *)adjustTime:(NSInteger)h minute:(NSInteger)m second:(NSInteger)s;
+(NSDate *)createDateTime:(NSInteger)year month:(NSInteger)month
                      day:(NSInteger)day hour:(NSInteger)hour
                   minute:(NSInteger)minute second:(NSInteger)second;
+(NSDate *)createDateTime:(NSInteger)year month:(NSInteger)month
                      day:(NSInteger)day hour:(NSInteger)hour
                   minute:(NSInteger)minute second:(NSInteger)second
                 timeZone:(NSTimeZone *)timeZone;
+(NSDate *)todayStart;
+(double)daysBetween:(NSDate *)fromDate to:(NSDate *)toDate;
-(NSDate *)setTime:(NSInteger)h minute:(NSInteger)m second:(NSInteger)s;
+(NSDate *)createSimpleTime:(NSInteger)hour minute:(NSInteger)minute
                     second:(NSInteger)second;
+(NSDate *)createSimpleDate:(NSInteger)year month:(NSInteger)month
                        day:(NSInteger)day;
+(NSString *)timeOfDayInSystemPreferredFormat:(NSInteger)hour
                              andMinute:(NSInteger)minute;
-(NSString *)extractTimeInFormat:(hourFormatType)format;
-(NSInteger)getWeekdayIndex;
@end

