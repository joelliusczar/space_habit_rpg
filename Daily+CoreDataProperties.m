//
//  Daily+CoreDataProperties.m
//  HabitRPG2
//
//  Created by Joel Pridgen on 5/23/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import "Daily+CoreDataProperties.h"

@implementation Daily (CoreDataProperties)

+ (NSFetchRequest<Daily *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"Daily"];
}

@dynamic activeDaysHash;
@dynamic dailyName;
@dynamic difficulty;
@dynamic isActive;
@dynamic lastActivationTime;
@dynamic nextDueTime;
@dynamic note;
@dynamic rate;
@dynamic rollbackActivationTime;
@dynamic streakLength;
@dynamic urgency;

@end
