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
+(NSDate *)adjustDate:(NSDate *)date year:(NSInteger)y month:(NSInteger)m
                  day:(NSInteger)d;

+(NSDate *)adjustTime:(NSDate *)dt hour:(NSInteger)h minute:(NSInteger)m
               second:(NSInteger)s;

+(NSDate *)createDateTime:(NSInteger)year month:(NSInteger)month
                      day:(NSInteger)day hour:(NSInteger)hour
                   minute:(NSInteger)minute second:(NSInteger)second;

+(NSDate *)createDateTime:(NSInteger)year month:(NSInteger)month
                      day:(NSInteger)day hour:(NSInteger)hour
                   minute:(NSInteger)minute second:(NSInteger)second
                 timeZone:(NSTimeZone *)timeZone;

+(NSDate *)todayStart;
+(double)daysBetween:(NSDate *)fromDate to:(NSDate *)toDate;
+(NSDate *)setTime:(NSDate *)dt hour:(NSInteger)h minute:(NSInteger)m
            second:(NSInteger)s;

+(NSDate *)createSimpleTime:(NSInteger)hour minute:(NSInteger)minute
                     second:(NSInteger)second;

+(NSString *)timeOfDayInSystemPreferredFormat:(NSInteger)hour
                              andMinute:(NSInteger)minute;
-(NSString *)extractTimeInFormat:(hourFormatType)format;

@end

