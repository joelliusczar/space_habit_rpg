//
//  SHCounter+CoreDataProperties.m
//  
//
//  Created by Joel Pridgen on 4/14/19.
//
//

#import "SHCounter+CoreDataProperties.h"

@implementation SHCounter (CoreDataProperties)

+ (NSFetchRequest<SHCounter *> *)fetchRequest {
	return [NSFetchRequest fetchRequestWithEntityName:@"SHCounter"];
}

@dynamic difficulty;
@dynamic freeViolations;
@dynamic frequencyCounts;
@dynamic habitName;
@dynamic isActive;
@dynamic isGood;
@dynamic lastUpdateDateTime;
@dynamic neglectPunishReward;
@dynamic note;
@dynamic urgency;
@dynamic userOrder;
@dynamic cat_counter;
@dynamic trigger_daily;

@end
