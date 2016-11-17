//
//  Hero+CoreDataProperties.m
//  HabitRPG2
//
//  Created by Joel Pridgen on 11/15/16.
//  Copyright © 2016 Joel Pridgen. All rights reserved.
//

#import "Hero+CoreDataProperties.h"

@implementation Hero (CoreDataProperties)

+ (NSFetchRequest<Hero *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"Hero"];
}

@dynamic gold;
@dynamic lvl;
@dynamic maxHp;
@dynamic maxXp;
@dynamic nowHp;
@dynamic nowXp;
@dynamic shipName;

@end
