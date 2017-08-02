//
//  Daily+CoreDataProperties.m
//  HabitRPG2
//
//  Created by Joel Pridgen on 8/2/17.
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
@dynamic lastUpdateTime;
@dynamic note;
@dynamic rate;
@dynamic rollbackActivationTime;
@dynamic shouldInactiveDaysCount;
@dynamic streakLength;
@dynamic urgency;
@dynamic rateType;
@dynamic daily_remind;
@dynamic daily_subtask;

@end
