//
//  Settings+CoreDataProperties.m
//  HabitRPG2
//
//  Created by Joel Pridgen on 5/2/17.
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
@dynamic lastCheckinTime;
@dynamic permaDeath;
@dynamic reminderHour;
@dynamic storyModeisOn;
@dynamic zoneLvlPenalty;
@dynamic isPasscodeProtected;

@end
