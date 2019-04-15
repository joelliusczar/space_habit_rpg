//
//  SHDaily+CoreDataProperties.m
//  
//
//  Created by Joel Pridgen on 4/14/19.
//
//

#import "SHDaily+CoreDataProperties.h"

@implementation SHDaily (CoreDataProperties)

+ (NSFetchRequest<SHDaily *> *)fetchRequest {
	return [NSFetchRequest fetchRequestWithEntityName:@"SHDaily"];
}

@dynamic activeDays;
@dynamic customUserOrder;
@dynamic cycleStartTime;
@dynamic dailyName;
@dynamic difficulty;
@dynamic isActive;
@dynamic lastActivationDateTime;
@dynamic lastDueDateTime;
@dynamic lastUpdateDateTime;
@dynamic note;
@dynamic rate;
@dynamic rateType;
@dynamic rollbackActivationDateTime;
@dynamic streakLength;
@dynamic urgency;
@dynamic activeFromDate;
@dynamic activeToDate;
@dynamic daily_remind;
@dynamic daily_subtask;
@dynamic daily_cat;
@dynamic daily_itemReward;
@dynamic trigger_daily;

@end
