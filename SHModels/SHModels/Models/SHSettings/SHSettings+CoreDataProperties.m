//
//  SHSettings+CoreDataProperties.m
//  
//
//  Created by Joel Pridgen on 4/14/19.
//
//

#import "SHSettings+CoreDataProperties.h"

@implementation SHSettings (CoreDataProperties)

+ (NSFetchRequest<SHSettings *> *)fetchRequest {
	return [NSFetchRequest fetchRequestWithEntityName:@"SHSettings"];
}

@dynamic allowReport;
@dynamic createDateTime;
@dynamic dayStart;
@dynamic deathGoldPenalty;
@dynamic heroLvlPenalty;
@dynamic invertColors;
@dynamic isPasscodeProtected;
@dynamic lastCheckinDateTime;
@dynamic lastUpdateDateTime;
@dynamic permaDeath;
@dynamic reminderHour;
@dynamic storyModeisOn;
@dynamic userId;
@dynamic zoneLvlPenalty;
@dynamic gameState;
@dynamic migrationNumber;

@end
