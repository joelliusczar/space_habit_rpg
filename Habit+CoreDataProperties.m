//
//  Habit+CoreDataProperties.m
//  HabitRPG2
//
//  Created by Joel Pridgen on 11/5/16.
//  Copyright © 2016 Joel Pridgen. All rights reserved.
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
@dynamic neglectPunishReward;
@dynamic note;
@dynamic polarity;
@dynamic urgency;

@end
