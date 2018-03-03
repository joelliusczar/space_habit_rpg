//
//  Reminder+CoreDataProperties.m
//  HabitRPG2
//
//  Created by Joel Pridgen on 8/1/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import "Reminder+CoreDataProperties.h"

@implementation Reminder (CoreDataProperties)

+ (NSFetchRequest<Reminder *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"Reminder"];
}

@dynamic daysBeforeDue;
@dynamic lastUpdateTime;
@dynamic reminderHour;
@dynamic notificationID;
@dynamic remind_daily;

@end
