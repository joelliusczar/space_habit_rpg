//
//  MonsterTransaction+CoreDataProperties.m
//  HabitRPG2
//
//  Created by Joel Pridgen on 5/2/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import "MonsterTransaction+CoreDataProperties.h"

@implementation MonsterTransaction (CoreDataProperties)

+ (NSFetchRequest<MonsterTransaction *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"MonsterTransaction"];
}

@dynamic monsterKey;
@dynamic lvl;
@dynamic startDate;
@dynamic endDate;

@end
