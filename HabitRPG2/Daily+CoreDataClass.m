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
#import "CommonUtilities.h"
#import "Reminder+CoreDataClass.h"
#import "DailySubTask+CoreDataClass.h"
#import "constants.h"

@implementation Daily


@synthesize activeDaysDict = _activeDaysDict;
-(NSMutableDictionary *)activeDaysDict{
    if(nil==_activeDaysDict){
        _activeDaysDict = [CommonUtilities jsonStringToDict:self.activeDays];
    }
    return _activeDaysDict;
}

-(NSMutableArray<NSDictionary<NSString *,NSNumber *> *> *)inUseActiveDays{
    NSString *rateTypeKey = [self getRateTypeKey:self.rateType];
    return self.activeDaysDict[rateTypeKey];
}


-(NSString *)getRateTypeKey:(RateType)rateType{
    switch(rateType){
        case WEEKLY_RATE:
            return @"daysOfWeek";
        case WEEKLY_RATE_INVERSE:
            return @"daysOfWeek_INV";
        case MONTHLY_RATE:
            return @"daysOfMonth";
        case MONTHLY_RATE_INVERSE:
            return @"daysOfMonth_INV";
        case YEARLY_RATE:
            return @"daysOfYear";
        case YEARLY_RATE_INVERSE:
            return @"daysOfYear_INV";
        case DAILY_RATE:
        DEFAULT:
            return @"";
    }
}



-(NSString *)name_w:(NSString *)name{
    self.dailyName = name;
    return name;
}


-(NSString *)noteText_w:(NSString *)noteText{
    self.note = noteText;
    return noteText;
}


-(NSInteger)rate_w:(int)rate{
    if(rate > 366){
        rate = 366;
    }
    if(rate < 1){
        rate = 1;
    }
    self.rate = rate;
    return rate;
}


int checkImportanceRange(int importance){
    if(importance > 10){
        return 10;
    }
    if(importance < 0){
        return 0;
    }
    return importance;
}


-(NSInteger)urgency_w:(int)urgency{
    urgency = checkImportanceRange(urgency);
    self.urgency = urgency;
    return urgency;
}


-(NSInteger)difficulty_w:(int)difficulty{
    difficulty = checkImportanceRange(difficulty);
    self.difficulty = difficulty;
    return difficulty;
}


-(NSInteger)streak_w:(int)streak{
    self.streakLength = streak;
    return streak;
}

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
    [object setValue:self.activeDays
              forKey:@"activeDays"];
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


//This method is not really necessary but using it will help my flow in
//viewDidLoad so that I didn't have a weird flag in there denoting that the
//model already existed. Besides, this makes things sorta more explicit
-(void)setupDefaults{
    self.activeDays = ALL_DAYS_JSON;
    self.rateType = WEEKLY_RATE;
    self.dailyName = @"";
    self.difficulty = 3;
    self.urgency = 3;
    self.note = @"";
    self.rate = 1;
    self.streakLength = 0;
}

@end
