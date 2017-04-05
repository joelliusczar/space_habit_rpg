//
//  Monster+CoreDataProperties.m
//  HabitRPG2
//
//  Created by Joel Pridgen on 4/4/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import "Monster+CoreDataProperties.h"

@implementation Monster (CoreDataProperties)

+ (NSFetchRequest<Monster *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"Monster"];
}

@dynamic lvl;
@dynamic maxHp;
@dynamic nowHp;
@dynamic monsterKey;

@end
