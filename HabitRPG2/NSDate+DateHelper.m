//
//  NSDate+DateHelper.m
//  HabitRPG2
//
//  Created by Joel Pridgen on 6/3/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import "NSDate+DateHelper.h"
#import "SingletonCluster.h"
#import "NSLocale+Helper.h"

@implementation NSDate (DateHelper)

+(NSDate *)adjustDate:(NSDate *)date year:(NSInteger)y month:(NSInteger)m
                  day:(NSInteger)d{
    
    NSCalendar *calendar = SharedGlobal.inUseCalendar;
    date = [calendar dateByAddingUnit:NSCalendarUnitYear value:y
                               toDate:date options:0];
    
    date = [calendar dateByAddingUnit:NSCalendarUnitMonth value:m
                               toDate:date options:0];
    
    date = [calendar dateByAddingUnit:NSCalendarUnitDay value:d
                               toDate:date options:0];
    
    return date;
}


+(NSDate *)adjustTime:(NSDate *)dt hour:(NSInteger)h minute:(NSInteger)m
               second:(NSInteger)s{
    
    NSCalendar *calendar = SharedGlobal.inUseCalendar;
    dt = [calendar dateByAddingUnit:NSCalendarUnitHour value:h
                             toDate:dt options:0];
    
    dt = [calendar dateByAddingUnit:NSCalendarUnitMinute value:m
                             toDate:dt options:0];
    
    dt = [calendar dateByAddingUnit:NSCalendarUnitSecond value:s
                             toDate:dt options:0];
    
    return dt;
}


+(NSDate *)createDateTime:(NSInteger)year month:(NSInteger)month
                      day:(NSInteger)day hour:(NSInteger)hour
                   minute:(NSInteger)minute second:(NSInteger)second
                 timeZone:(NSTimeZone *)timeZone{
    
    NSDateComponents *comps = [NSDateComponents new];
    comps.year = year;
    comps.month = month;
    comps.day = day;
    comps.hour = hour;
    comps.minute = minute;
    comps.second = second;
    comps.timeZone = timeZone;
    NSCalendar *calendar = SharedGlobal.inUseCalendar;
    return [calendar dateFromComponents:comps];
    
}


+(NSDate *)createDateTime:(NSInteger)year month:(NSInteger)month
                      day:(NSInteger)day hour:(NSInteger)hour
                   minute:(NSInteger)minute second:(NSInteger)second{
    
    return
    [NSDate createDateTime:year month:month day:day hour:hour minute:minute
                    second:second timeZone:SharedGlobal.inUseTimeZone];
}


+(NSDate *)createSimpleTime:(NSInteger)hour minute:(NSInteger)minute
                     second:(NSInteger)second{
    return
    [NSDate createDateTime:1970 month:1 day:1 hour:hour minute:minute
                    second:second];
}

+(NSDate *)todayStart{
    return [SharedGlobal.inUseCalendar startOfDayForDate:[NSDate date]];
}

+(double)daysBetween:(NSDate *)fromDate to:(NSDate *)toDate{
    NSTimeInterval timeLeft =
    toDate.timeIntervalSince1970 - fromDate.timeIntervalSince1970;
    
    return (timeLeft/86400.0);
}

+(NSDate *)setTime:(NSDate *)dt hour:(NSInteger)h minute:(NSInteger)m second:(NSInteger)s{
    NSDate *roundedDownDate = [SharedGlobal.inUseCalendar startOfDayForDate:dt];
    return [NSDate adjustTime:roundedDownDate hour:h minute:m second:s];
}

+(NSString *)timeOfDayInSystemPreferredFormat:(NSInteger)hour
                              andMinute:(NSInteger)minute{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.locale = SharedGlobal.inUseLocale;
    formatter.timeStyle = NSDateFormatterShortStyle;
    NSString *dateString = [formatter stringFromDate:
                            [NSDate createSimpleTime:hour minute:minute
                                              second:0]];
    
    return dateString;
}

-(NSString *)extractTimeInFormat:(hourFormatType)format{
    NSDateComponents *components=[SharedGlobal.inUseCalendar
                                    components:NSCalendarUnitHour|NSCalendarUnitMinute
                                    fromDate:self];
    NSInteger convertedHour=[NSLocale hour:components.hour inGivenFormatMask:format];
    return [NSString stringWithFormat:@"%ld:%ld",convertedHour,components.minute];
}

@end
