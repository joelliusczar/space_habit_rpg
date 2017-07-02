//
//  DailySubTask+CoreDataProperties.m
//  HabitRPG2
//
//  Created by Joel Pridgen on 7/2/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import "DailySubTask+CoreDataProperties.h"

@implementation DailySubTask (CoreDataProperties)

+ (NSFetchRequest<DailySubTask *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"DailySubTask"];
}

@dynamic activeDaysHash;
@dynamic dailySubTaskName;
@dynamic difficulty;
@dynamic lastActivationTime;
@dynamic rate;
@dynamic urgency;
@dynamic subtask_daily;

@end
