//
//  Daily+CoreDataProperties.m
//  HabitRPG2
//
//  Created by Joel Pridgen on 9/12/16.
//  Copyright © 2016 Joel Pridgen. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Daily+CoreDataProperties.h"

@implementation Daily (CoreDataProperties)

@dynamic activeDaysHash;
@dynamic dailyName;
@dynamic difficulty;
@dynamic lastActivationTime;
@dynamic note;
@dynamic rate;
@dynamic streakLength;
@dynamic urgency;
@dynamic nextDueTime;

@end
