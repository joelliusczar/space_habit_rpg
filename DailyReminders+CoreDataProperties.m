//
//  DailyReminders+CoreDataProperties.m
//  HabitRPG2
//
//  Created by Joel Pridgen on 7/1/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import "DailyReminders+CoreDataProperties.h"

@implementation DailyReminders (CoreDataProperties)

+ (NSFetchRequest<DailyReminders *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"DailyReminders"];
}

@dynamic daysBeforeDue;
@dynamic reminderHour;
@dynamic remind_daily;

@end
