//
//  Monster+CoreDataProperties.m
//  HabitRPG2
//
//  Created by Joel Pridgen on 11/5/16.
//  Copyright © 2016 Joel Pridgen. All rights reserved.
//

#import "Monster+CoreDataProperties.h"

@implementation Monster (CoreDataProperties)

+ (NSFetchRequest<Monster *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"Monster"];
}

@dynamic about;
@dynamic baseXpReward;
@dynamic lvl;
@dynamic maxHp;
@dynamic monsterName;
@dynamic nowHp;

@end
