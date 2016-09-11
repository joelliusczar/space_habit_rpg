//
//  Habit+CoreDataProperties.m
//  HabitRPG2
//
//  Created by Joel Pridgen on 9/10/16.
//  Copyright © 2016 Joel Pridgen. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Habit+CoreDataProperties.h"

@implementation Habit (CoreDataProperties)

@dynamic habitName;
@dynamic note;
@dynamic polarity;
@dynamic urgency;
@dynamic difficulty;
@dynamic freeViolations;
@dynamic neglectPunishReward;
@dynamic frequencyCounts;

@end
