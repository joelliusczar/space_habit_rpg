//
//  Reminder+CoreDataProperties.m
//  HabitRPG2
//
//  Created by Joel Pridgen on 7/28/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import "Reminder+CoreDataProperties.h"

@implementation Reminder (CoreDataProperties)

+ (NSFetchRequest<Reminder *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"Reminder"];
}

@dynamic daysBeforeDue;
@dynamic reminderHour;
@dynamic lastUpdateTime;
@dynamic remind_daily;

@end
