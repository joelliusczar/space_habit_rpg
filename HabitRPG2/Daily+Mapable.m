//
//  Daily+Mapable.m
//  HabitRPG2
//
//  Created by Joel Pridgen on 9/8/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import "Daily+Mapable.h"
#import "DailySubTask+CoreDataClass.h"

@implementation Daily (Mapable)


-(NSMutableDictionary *)mapable{
    
    NSMutableDictionary *mappedData = [self simpleMapable];
    [mappedData setValue:[self mappedReminders] forKey:@"daily_remind"];
    [mappedData setValue:[self mappedSubtasks] forKey:@"daily_subtask"];
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

@end
