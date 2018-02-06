//
//  Settings+CoreDataProperties.m
//  HabitRPG2
//
//  Created by Joel Pridgen on 2/6/18.
//  Copyright © 2018 Joel Pridgen. All rights reserved.
//
//

#import "Settings+CoreDataProperties.h"

@implementation Settings (CoreDataProperties)

+ (NSFetchRequest<Settings *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"Settings"];
}

@dynamic allowReport;
@dynamic createDate;
@dynamic dayStart;
@dynamic deathGoldPenalty;
@dynamic heroLvlPenalty;
@dynamic invertColors;
@dynamic isPasscodeProtected;
@dynamic lastCheckinDate;
@dynamic lastUpdateTime;
@dynamic permaDeath;
@dynamic reminderHour;
@dynamic storyModeisOn;
@dynamic userId;
@dynamic zoneLvlPenalty;

@end
