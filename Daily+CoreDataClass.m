//
//  Daily+CoreDataClass.m
//  HabitRPG2
//
//  Created by Joel Pridgen on 11/5/16.
//  Copyright © 2016 Joel Pridgen. All rights reserved.
//

#import "Daily+CoreDataClass.h"
#import "Daily+DailyHelper.h"
#import "SingletonCluster.h"
#import "NSDate+DateHelper.h"

@implementation Daily

@synthesize rowNum = _rowNum;
@synthesize sectionNum = _sectionNum;

-(NSMutableDictionary *)mapable{
    return [NSMutableDictionary dictionaryWithObjectsAndKeys:
            self.dailyName,@"dailyName"
            ,[NSNumber numberWithInt:self.activeDaysHash],@"activeDaysHash"
            ,[NSNumber numberWithInt:self.difficulty],@"difficulty"
            ,[NSNumber numberWithInt:self.rate],@"rate"
            ,[NSNumber numberWithInt:self.streakLength],@"streakLength"
            ,[NSNumber numberWithInt:self.urgency],@"urgency"
            ,[NSNumber numberWithBool:self.isActive],@"isActive"
            ,self.lastActivationTime.timeIntervalSince1970,@"lastActivationTime"
            ,self.rollbackActivationTime.timeIntervalSince1970,@"rollbackActivationTime"
            ,[NSNumber numberWithInt:self.customUserOrder],@"customUserOrder"
            , nil];
}

-(NSDate *)nextDueTime{
    return
    [Daily calculateNextDueTime:self.lastActivationTime withRate:self.rate
                    andDayStart:SCSettings.dayStart];
}

-(int)daysUntilDue{
    NSDate *roundedDownToday =
    [NSDate setTime:[NSDate date] hour:SCSettings.dayStart minute:0 second:0];
    
    return (int)[NSDate daysBetween:roundedDownToday to:self.nextDueTime];
}

-(NSOrderedSet<NSManagedObject<P_Reminder> *> *)getReminderSet{
    return
    (NSOrderedSet<NSManagedObject<P_Reminder> *> *)self.daily_remind;
}

@end
