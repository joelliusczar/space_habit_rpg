//
//  DailySubTask+CoreDataProperties.m
//  HabitRPG2
//
//  Created by Joel Pridgen on 6/17/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import "DailySubTask+CoreDataProperties.h"

@implementation DailySubTask (CoreDataProperties)

+ (NSFetchRequest<DailySubTask *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"DailySubTask"];
}

@dynamic dailySubTaskName;
@dynamic activeDaysHash;
@dynamic difficulty;
@dynamic urgency;
@dynamic lastActivationTime;
@dynamic rate;
@dynamic subtask_daily;

@end
