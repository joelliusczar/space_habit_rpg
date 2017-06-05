//
//  Daily+CoreDataClass.m
//  HabitRPG2
//
//  Created by Joel Pridgen on 11/5/16.
//  Copyright © 2016 Joel Pridgen. All rights reserved.
//

#import "Daily+CoreDataClass.h"

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
            ,self.nextDueTime.timeIntervalSince1970,@"nextDueTime"
            ,self.rollbackActivationTime.timeIntervalSince1970,@"rollbackActivationTime"
            ,[NSNumber numberWithInt:self.userOrder]
            , nil];
}
@end
