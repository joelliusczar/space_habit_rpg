//
//  MonsterTransaction+CoreDataProperties.m
//  HabitRPG2
//
//  Created by Joel Pridgen on 7/2/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import "MonsterTransaction+CoreDataProperties.h"

@implementation MonsterTransaction (CoreDataProperties)

+ (NSFetchRequest<MonsterTransaction *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"MonsterTransaction"];
}

@dynamic misc;
@dynamic timestamp;

@end
