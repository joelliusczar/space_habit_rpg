//
//  DailySubTask+CoreDataClass.m
//  HabitRPG2
//
//  Created by Joel Pridgen on 6/17/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import "DailySubTask+CoreDataClass.h"
#import "Daily+CoreDataClass.h"

@implementation DailySubTask

-(NSMutableDictionary *)mapable{
    NSMutableDictionary *mappedData = [NSMutableDictionary dictionary];
    [self copyInto:mappedData];
    [mappedData removeObjectForKey:@"subtask_daily"];
    [mappedData setValue:[NSNumber
                          numberWithDouble:self.lastActivationTime.timeIntervalSince1970]
                  forKey:@"lastActivationTime"];
    return mappedData;
}

-(void)copyInto:(NSObject *)object{
    NSAssert([object isKindOfClass:DailySubTask.class]||
             [object isKindOfClass:NSDictionary.class],
             @"object needs to be of the same class or a dictionary");
    [object setValue:self.dailySubTaskName forKey:@"dailySubTaskName"];
    [object setValue:[NSNumber numberWithInt:self.activeDaysHash]
              forKey:@"activeDaysHash"];
    [object setValue:[NSNumber numberWithInt:self.difficulty]
              forKey:@"difficulty"];
    [object setValue:[NSNumber numberWithInt:self.rate]
              forKey:@"rate"];
    [object setValue:[NSNumber numberWithInt:self.urgency]
              forKey:@"urgency"];
    [object setValue:[NSNumber numberWithInt:self.urgency]
              forKey:@"urgency"];
    [object setValue:self.lastActivationTime forKey:@"lastActivationTime"];
    [object setValue:self.subtask_daily forKey:@"subtask_daily"];
}


@end
