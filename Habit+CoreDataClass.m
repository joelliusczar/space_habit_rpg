//
//  Habit+CoreDataClass.m
//  HabitRPG2
//
//  Created by Joel Pridgen on 11/5/16.
//  Copyright © 2016 Joel Pridgen. All rights reserved.
//

#import "Habit+CoreDataClass.h"

@implementation Habit
-(NSMutableDictionary *)mapable{
    return [NSMutableDictionary dictionaryWithObjectsAndKeys:
            self.habitName,@"habitName"
            ,self.frequencyCounts,@"frequencyCounts"
            ,[NSNumber numberWithInt:self.difficulty],@"difficulty"
            ,[NSNumber numberWithInt:self.freeViolations],@"freeViolations"
            ,[NSNumber numberWithInt:self.urgency],@"urgency"
            ,[NSNumber numberWithBool:self.isGood],@"isGood"
            ,[NSNumber numberWithBool:self.isActive],@"isActive"
            ,[NSNumber numberWithBool:self.neglectPunishReward],@"neglectPunishReward"
            ,[NSNumber numberWithInt:self.userOrder]
            , nil];
}
@end
