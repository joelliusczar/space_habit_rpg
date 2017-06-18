//
//  DailyReminders+CoreDataProperties.m
//  HabitRPG2
//
//  Created by Joel Pridgen on 6/17/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import "DailyReminders+CoreDataProperties.h"

@implementation DailyReminders (CoreDataProperties)

+ (NSFetchRequest<DailyReminders *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"DailyReminders"];
}

@dynamic reminderHour;
@dynamic daysBeforeDue;
@dynamic remind_daily;

@end
