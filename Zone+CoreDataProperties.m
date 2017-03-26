//
//  Zone+CoreDataProperties.m
//  HabitRPG2
//
//  Created by Joel Pridgen on 3/25/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import "Zone+CoreDataProperties.h"

@implementation Zone (CoreDataProperties)

+ (NSFetchRequest<Zone *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"Zone"];
}

@dynamic isFront;
@dynamic lvl;
@dynamic maxMonsters;
@dynamic monstersKilled;
@dynamic suffixNumber;
@dynamic uniqueId;
@dynamic zoneKey;

@end
