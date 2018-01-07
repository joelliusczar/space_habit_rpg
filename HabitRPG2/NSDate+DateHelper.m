//
//  NSDate+DateHelper.m
//  HabitRPG2
//
//  Created by Joel Pridgen on 6/3/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import "NSDate+DateHelper.h"
#import "NSLocale+Helper.h"
#import <objc/runtime.h>
#import "NSException+SHCommonExceptions.h"
#import "SingletonCluster.h"

@implementation NSDate (DateHelper)


+(NSLocale *)inUseLocale{
    id tmp = objc_getAssociatedObject(self,@selector(inUseLocale));
    if(tmp){
        return (NSLocale *)tmp;
    }
    return SharedGlobal.inUseLocale;
}


+(void)setInUseLocale:(NSLocale *)locale{
    objc_setAssociatedObject(self,@selector(inUseLocale),locale,OBJC_ASSOCIATION_RETAIN);
}


+(NSCalendar *)inUseCalendar{
    id tmp = objc_getAssociatedObject(self,@selector(inUseCalendar));
    if(tmp){
        return (NSCalendar *)tmp;
    }
    return SharedGlobal.inUseCalendar;
}


+(void)setInUseCalendar:(NSCalendar *)calendar{
    objc_setAssociatedObject(self,@selector(inUseCalendar),calendar,OBJC_ASSOCIATION_RETAIN);
}


+(NSTimeZone *)inUseTimeZone{
    id tmp = objc_getAssociatedObject(self,@selector(inUseTimeZone));
    if(tmp){
        return (NSTimeZone *)tmp;
    }
    return SharedGlobal.inUseTimeZone;
}


+(void)setInUseTimeZone:(NSTimeZone *)timeZone{
    objc_setAssociatedObject(self,@selector(inUseTimeZone),timeZone,OBJC_ASSOCIATION_RETAIN);
}


-(NSDate *)dateAfterYears:(NSInteger)y months:(NSInteger)m days:(NSInteger)d{
    
    NSCalendar *calendar = NSDate.inUseCalendar;
    NSDate *date = [calendar dateByAddingUnit:NSCalendarUnitYear value:y
                               toDate:self options:0];
    
    date = [calendar dateByAddingUnit:NSCalendarUnitMonth value:m
                               toDate:date options:0];
    
    date = [calendar dateByAddingUnit:NSCalendarUnitDay value:d
                               toDate:date options:NSCalendarMatchStrictly];
    
    return date;
}


-(NSDate *)timeAfterHours:(NSInteger)h minutes:(NSInteger)m
               seconds:(NSInteger)s{
    
    NSCalendar *calendar = NSDate.inUseCalendar;
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
                 timeZone:(NSTimeZone *)timeZone{
    
    NSDateComponents *comps = [NSDateComponents new];
    comps.year = year;
    comps.month = month;
    comps.day = day;
    comps.hour = hour;
    comps.minute = minute;
    comps.second = second;
    comps.timeZone = timeZone;
    NSCalendar *calendar = self.inUseCalendar;
    return [calendar dateFromComponents:comps];
    
}


+(NSDate *)createDateTimeWithYear:(NSInteger)year month:(NSInteger)month
                      day:(NSInteger)day hour:(NSInteger)hour
                   minute:(NSInteger)minute second:(NSInteger)second{
    
    return
    [NSDate createDateTimeWithYear:year month:month day:day hour:hour minute:minute
                    second:second timeZone:self.inUseTimeZone];
}


+(NSDate *)createSimpleTimeWithHour:(NSInteger)hour minute:(NSInteger)minute
                     second:(NSInteger)second{
    return
    [NSDate createDateTimeWithYear:1970 month:1 day:1 hour:hour minute:minute
                    second:second];
}


+(NSDate *)createSimpleDateWithYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day{
    return [NSDate createDateTimeWithYear:year month:month day:day hour:0 minute:0 second:0];
}


+(NSDate *)todayStart{
    return [self.inUseCalendar startOfDayForDate:[NSDate date]];
}

+(NSInteger)daysBetween:(NSDate *)fromDate to:(NSDate *)toDate{
    NSCalendar *calendar = self.inUseCalendar;
    NSDateComponents *dayComponent = [calendar components:NSCalendarUnitDay
                                                 fromDate:fromDate toDate:toDate options:0];
    return dayComponent.day;
}

-(NSDate *)setHour:(NSInteger)h minute:(NSInteger)m second:(NSInteger)s{
    NSDate *roundedDownDate = [NSDate.inUseCalendar startOfDayForDate:self];
    return [roundedDownDate timeAfterHours:h minutes:m seconds:s];
}

+(NSString *)timeOfDayInSystemPreferredFormat:(NSInteger)hour
                              andMinute:(NSInteger)minute{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.locale = self.inUseLocale;
    formatter.timeStyle = NSDateFormatterShortStyle;
    NSString *dateString = [formatter stringFromDate:
                            [NSDate createSimpleTimeWithHour:hour minute:minute
                                              second:0]];
    
    return dateString;
}

-(NSString *)extractTimeInFormat:(hourFormatType)format{
    
    NSDateComponents *components = [NSDate.inUseCalendar
                                    components:NSCalendarUnitHour|NSCalendarUnitMinute
                                    fromDate:self];
    NSInteger convertedHour = [NSLocale hour:components.hour inGivenFormatMask:format];
    return [NSString stringWithFormat:@"%ld:%ld",convertedHour,components.minute];
}

-(NSInteger)getWeekdayIndex{
    return [NSDate.inUseCalendar component:NSCalendarUnitWeekday fromDate:self] % 7;
}

@end
