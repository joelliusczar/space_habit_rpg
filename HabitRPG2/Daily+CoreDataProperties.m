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

@dynamic activeDays;
@dynamic customUserOrder;
@dynamic dailyName;
@dynamic difficulty;
@dynamic isActive;
@dynamic lastActivationTime;
@dynamic lastUpdateTime;
@dynamic note;
@dynamic rate;
@dynamic rateType;
@dynamic rollbackActivationTime;
@dynamic streakLength;
@dynamic urgency;
@dynamic cycleStartTime;
@dynamic daily_remind;
@dynamic daily_subtask;

@end
