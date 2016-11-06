//
//  Zone+CoreDataProperties.m
//  HabitRPG2
//
//  Created by Joel Pridgen on 11/5/16.
//  Copyright © 2016 Joel Pridgen. All rights reserved.
//

#import "Zone+CoreDataProperties.h"

@implementation Zone (CoreDataProperties)

+ (NSFetchRequest<Zone *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"Zone"];
}

@dynamic isCurrentZone;
@dynamic lvl;
@dynamic maxMonsters;
@dynamic monstersKilled;
@dynamic previousZonePK;
@dynamic suffixNumber;
@dynamic uniqueId;
@dynamic zoneKey;

@end
