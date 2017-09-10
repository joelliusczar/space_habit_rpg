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
#import "constants.h"
#import "RateTypeHelper.h"

@implementation Daily


@synthesize isTouched;
@synthesize isActiveDaysTouched = _isActiveDaysTouched;


@synthesize activeDaysDict = _activeDaysDict;
-(NSMutableDictionary *)activeDaysDict{
    if(nil==_activeDaysDict){
        _activeDaysDict = [CommonUtilities jsonStringToDict:self.activeDays];
    }
    return _activeDaysDict;
}


-(BOOL)isInverseRateType{
    return isInverseRateType(self.rateType);
}


-(NSMutableArray<RateValueItemDict *> *)inUseActiveDays{
    return [self getActiveDaysForRateType:self.rateType];
}


-(NSString *)name_w:(NSString *)name{
    self.isTouched = YES;
    self.dailyName = name;
    return name;
}


-(NSString *)noteText_w:(NSString *)noteText{
    self.isTouched = YES;
    self.note = noteText;
    return noteText;
}


-(NSInteger)rate_w:(int)rate{
    self.isTouched = YES;
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
    self.isTouched = YES;
    urgency = checkImportanceRange(urgency);
    self.urgency = urgency;
    return urgency;
}


-(NSInteger)difficulty_w:(int)difficulty{
    self.isTouched = YES;
    difficulty = checkImportanceRange(difficulty);
    self.difficulty = difficulty;
    return difficulty;
}


-(NSInteger)streak_w:(int)streak{
    self.isTouched = YES;
    self.streakLength = streak;
    return streak;
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


-(void)preSave{
    self.activeDays = [CommonUtilities dictToString:self.activeDaysDict];
}

@end
