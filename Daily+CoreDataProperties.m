//
//  Daily+CoreDataProperties.m
//  HabitRPG2
//
//  Created by Joel Pridgen on 6/16/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import "Daily+CoreDataProperties.h"

@implementation Daily (CoreDataProperties)

+ (NSFetchRequest<Daily *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"Daily"];
}

@dynamic activeDaysHash;
@dynamic customUserOrder;
@dynamic dailyName;
@dynamic difficulty;
@dynamic isActive;
@dynamic lastActivationTime;
@dynamic note;
@dynamic rate;
@dynamic rollbackActivationTime;
@dynamic streakLength;
@dynamic urgency;

@end
