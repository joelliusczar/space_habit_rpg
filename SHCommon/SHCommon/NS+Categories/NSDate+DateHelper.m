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
#import "SHDatetime.h"

@implementation NSDate (DateHelper)



-(NSDate *)dateAfterYears:(NSInteger)y months:(NSInteger)m days:(NSInteger)d{
    SHDatetime dt;
    int tzOffset = (int)[NSTimeZone.defaultTimeZone secondsFromGMTForDate:self];
    int error;
    tryTimestampToDt(self.timeIntervalSince1970,tzOffset,&dt,&error);
    tryAddYearsToDtInPlace(&dt,y,0,&error);
    tryAddMonthsToDtInPlace(&dt,m,0,&error);
    tryAddDaysToDtInPlace(&dt,d,0,&error);
    return [NSDate dateWithTimeIntervalSince1970:dtToTimestamp(&dt,&error)];
}


-(NSDate *)timeAfterHours:(NSInteger)h minutes:(NSInteger)m
               seconds:(NSInteger)s{
    
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
                 timeZone:(NSTimeZone *)timeZone{
    
    double timestamp;
    int error;
    tryCreateDateTime(year,(int)month,(int)day,(int)hour,(int)minute,(int)second
      ,(int)(timeZone.secondsFromGMT),&timestamp,&error);
    return [NSDate dateWithTimeIntervalSince1970:timestamp];
    
}


+(NSDate *)createDateTimeWithYear:(NSInteger)year month:(NSInteger)month
                      day:(NSInteger)day hour:(NSInteger)hour
                   minute:(NSInteger)minute second:(NSInteger)second{
    return [NSDate createDateTimeWithYear:year month:month day:day hour:hour minute:minute
                    second:second timeZone:NSTimeZone.defaultTimeZone];
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


-(NSDate *)dayStart{
    NSInteger timestamp = self.timeIntervalSince1970;
    NSInteger dayStartTimestamp;
    int error;
    tryDayStart(timestamp,(int)NSTimeZone.defaultTimeZone.secondsFromGMT,&dayStartTimestamp,&error);
    return [NSDate dateWithTimeIntervalSince1970:dayStartTimestamp];
}


+(NSInteger)daysBetween:(NSDate *)fromDate to:(NSDate *)toDate{
    SHDatetime dtFrom;
    SHDatetime dtTo;
    int err;
    tryTimestampToDt(fromDate.timeIntervalSince1970
      ,(int)NSTimeZone.defaultTimeZone.secondsFromGMT,&dtFrom,&err);
    tryTimestampToDt(toDate.timeIntervalSince1970
                       ,(int)NSTimeZone.defaultTimeZone.secondsFromGMT,&dtTo,&err);

    return dateDiffDays(&dtTo,&dtFrom,&err);
}

-(NSDate *)setHour:(NSInteger)h minute:(NSInteger)m second:(NSInteger)s{
    NSDate *roundedDownDate = [SharedGlobal.inUseCalendar startOfDayForDate:self];
    return [roundedDownDate timeAfterHours:h minutes:m seconds:s];
}

+(NSString *)timeOfDayInSystemPreferredFormat:(NSInteger)hour
                              andMinute:(NSInteger)minute{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.locale = SharedGlobal.inUseLocale;
    formatter.timeStyle = NSDateFormatterShortStyle;
    NSString *dateString = [formatter stringFromDate:
                            [NSDate createSimpleTimeWithHour:hour minute:minute
                                              second:0]];
    
    return dateString;
}

-(NSString *)extractTimeInFormat:(hourFormatType)format{
    
    NSDateComponents *components = [SharedGlobal.inUseCalendar
                                    components:NSCalendarUnitHour|NSCalendarUnitMinute
                                    fromDate:self];
    NSInteger convertedHour = [NSLocale hour:components.hour inGivenFormatMask:format];
    return [NSString stringWithFormat:@"%ld:%ld",convertedHour,components.minute];
}


-(NSInteger)getWeekdayIndex{
    SHDatetime dt;
    int tzOffset = (int)[NSTimeZone.defaultTimeZone secondsFromGMTForDate:self];
    int error;
    tryTimestampToDt(self.timeIntervalSince1970,tzOffset,&dt,&error);
    return calcWeekdayIdx(&dt,&error);
}

@end
