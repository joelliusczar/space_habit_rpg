//
//  Hero+CoreDataProperties.m
//  HabitRPG2
//
//  Created by Joel Pridgen on 1/8/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
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
@dynamic zone_link;

@end
