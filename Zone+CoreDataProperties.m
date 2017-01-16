//
//  Zone+CoreDataProperties.m
//  HabitRPG2
//
//  Created by Joel Pridgen on 1/16/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import "Zone+CoreDataProperties.h"

@implementation Zone (CoreDataProperties)

+ (NSFetchRequest<Zone *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"Zone"];
}

@dynamic lvl;
@dynamic maxMonsters;
@dynamic monstersKilled;
@dynamic suffixNumber;
@dynamic uniqueId;
@dynamic zoneKey;

@end
