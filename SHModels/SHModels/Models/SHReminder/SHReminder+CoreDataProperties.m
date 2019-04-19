//
//  SHReminder+CoreDataProperties.m
//  
//
//  Created by Joel Pridgen on 4/14/19.
//
//

#import "SHReminder+CoreDataProperties.h"

@implementation SHReminder (CoreDataProperties)

+ (NSFetchRequest<SHReminder *> *)fetchRequest {
	return [NSFetchRequest fetchRequestWithEntityName:@"SHReminder"];
}

@dynamic daysBeforeDue;
@dynamic lastUpdateDateTime;
@dynamic notificationID;
@dynamic reminderHour;
@dynamic remind_daily;

@end
