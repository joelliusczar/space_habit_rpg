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
#import "Reminder+CoreDataClass.h"
#import "DailySubTask+CoreDataClass.h"

@implementation Daily

@synthesize rowNum = _rowNum;
@synthesize sectionNum = _sectionNum;


-(NSMutableDictionary *)mapable{
    
    NSMutableDictionary *mappedData = [self simpleMapable];
    [mappedData setValue:[self mappedReminders] forKey:@"daily_remind"];
    [mappedData setValue:[self mappedSubtasks] forKey:@"daily_subtask"];
    return mappedData;
}

//so that we don't have to map all of the relationships
-(NSMutableDictionary *)simpleMapable{
    NSMutableDictionary *mappedData = [NSMutableDictionary dictionary];
    //since NSDates don't play with JSON,I'm going to overrite these
    //guys here
    [self copyInto:mappedData];
    [mappedData
     setValue:[NSNumber numberWithDouble:self.lastActivationTime.timeIntervalSince1970]
     forKey:@"lastActivationTime"];
    [mappedData
     setValue:[NSNumber numberWithDouble:self.rollbackActivationTime.timeIntervalSince1970]
     forKey:@"rollbackActivationTime"];
    return mappedData;
}


-(NSArray<NSMutableDictionary *> *)mappedReminders{
    NSMutableArray<NSMutableDictionary *> *reminders = [NSMutableArray array];
    for(Reminder *reminder in self.daily_remind){
        [reminders addObject:reminder.mapable];
    }
    return reminders;
}

-(NSArray<NSMutableDictionary *> *)mappedSubtasks{
    NSMutableArray<NSMutableDictionary *> *subtasks = [NSMutableArray array];
    for(DailySubTask *subtask in self.daily_subtask){
        [subtasks addObject:subtask.mapable];
    }
    return subtasks;
}

-(void)copyInto:(NSObject *)object{
    NSAssert([object isKindOfClass:Daily.class]||[object isKindOfClass:NSDictionary.class],
             @"object needs to be of the same class or a dictionary");
    [object setValue:self.dailyName forKey:@"dailyName"];
    [object setValue:self.note forKey:@"note"];
    [object setValue:[NSNumber numberWithInt:self.activeDaysHash]
              forKey:@"activeDaysHash"];
    [object setValue:[NSNumber numberWithInt:self.difficulty]
              forKey:@"difficulty"];
    [object setValue:[NSNumber numberWithInt:self.rate]
              forKey:@"rate"];
    [object setValue:[NSNumber numberWithInt:self.streakLength]
              forKey:@"streakLength"];
    [object setValue:[NSNumber numberWithInt:self.urgency]
              forKey:@"urgency"];
    [object setValue:[NSNumber numberWithInt:self.urgency]
              forKey:@"urgency"];
    [object setValue:[NSNumber numberWithInt:self.isActive]
              forKey:@"isActive"];
    [object setValue:self.lastActivationTime forKey:@"lastActivationTime"];
    [object setValue:self.rollbackActivationTime forKey:@"rollbackActivationTime"];
    [object setValue:[NSNumber numberWithInt:self.customUserOrder]
              forKey:@"customUserOrder"];
    [object setValue:self.lastUpdateTime forKey:@"lastUpdateTime"];
    [object setValue:[NSNumber numberWithBool:self.shouldInactiveDaysCount]
                                       forKey:@"shouldInactiveDaysCount"];
}


-(NSDate *)nextDueTime{
    NSDate *usableDate = self.lastActivationTime?
                            self.lastActivationTime:
                            self.lastUpdateTime;
    return [Daily calculateNextDueTime:usableDate
                              withRate:self.rate
                           andDayStart:SHSettings.dayStart];
}


-(int)daysUntilDue{
    NSDate *roundedDownToday =
    [NSDate setTime:[NSDate date] hour:SHSettings.dayStart minute:0 second:0];
    
    return (int)[NSDate daysBetween:roundedDownToday to:self.nextDueTime];
}


-(NSInteger)maxDaysBefore{
    return self.rate;
}


-(NSString *)taskTitle{
    return self.dailyName;
}


-(NSOrderedSet<Reminder *> *)getReminderSet{
    return self.daily_remind;
}


-(void)addNewReminder:(Reminder *)reminder{
    [self addDaily_remindObject:reminder];
}


-(void)removeReminder:(Reminder *)reminder{
    [self removeDaily_remindObject:reminder];
}

@end
