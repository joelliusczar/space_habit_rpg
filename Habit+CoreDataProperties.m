//
//  Habit+CoreDataProperties.m
//  HabitRPG2
//
//  Created by Joel Pridgen on 6/4/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import "Habit+CoreDataProperties.h"

@implementation Habit (CoreDataProperties)

+ (NSFetchRequest<Habit *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"Habit"];
}

@dynamic difficulty;
@dynamic freeViolations;
@dynamic frequencyCounts;
@dynamic habitName;
@dynamic isActive;
@dynamic isGood;
@dynamic neglectPunishReward;
@dynamic note;
@dynamic urgency;
@dynamic userOrder;

@end
