//
//  Settings+CoreDataProperties.m
//  HabitRPG2
//
//  Created by Joel Pridgen on 6/12/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import "Settings+CoreDataProperties.h"

@implementation Settings (CoreDataProperties)

+ (NSFetchRequest<Settings *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"Settings"];
}

@dynamic createDate;
@dynamic dayStart;
@dynamic deathGoldPenalty;
@dynamic heroLvlPenalty;
@dynamic invertColors;
@dynamic isPasscodeProtected;
@dynamic lastCheckinTime;
@dynamic permaDeath;
@dynamic reminderHour;
@dynamic storyModeisOn;
@dynamic zoneLvlPenalty;
@dynamic userId;
@dynamic allowReport;

@end
