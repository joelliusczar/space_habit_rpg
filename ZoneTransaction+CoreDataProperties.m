//
//  ZoneTransaction+CoreDataProperties.m
//  HabitRPG2
//
//  Created by Joel Pridgen on 5/2/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import "ZoneTransaction+CoreDataProperties.h"

@implementation ZoneTransaction (CoreDataProperties)

+ (NSFetchRequest<ZoneTransaction *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"ZoneTransaction"];
}

@dynamic zoneKey;
@dynamic uniqueId;
@dynamic lvl;
@dynamic suffix;
@dynamic startDate;
@dynamic endDate;
@dynamic maxMonsters;
@dynamic prevUniqueId;

@end
