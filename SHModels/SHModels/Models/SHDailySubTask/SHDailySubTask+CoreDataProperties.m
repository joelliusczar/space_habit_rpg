//
//  SHDailySubTask+CoreDataProperties.m
//  
//
//  Created by Joel Pridgen on 4/14/19.
//
//

#import "SHDailySubTask+CoreDataProperties.h"

@implementation SHDailySubTask (CoreDataProperties)

+ (NSFetchRequest<SHDailySubTask *> *)fetchRequest {
	return [NSFetchRequest fetchRequestWithEntityName:@"SHDailySubTask"];
}

@dynamic activeDaysHash;
@dynamic dailySubTaskName;
@dynamic difficulty;
@dynamic lastActivationDateTime;
@dynamic lastUpdateDateTime;
@dynamic rate;
@dynamic urgency;
@dynamic subtask_daily;

@end
