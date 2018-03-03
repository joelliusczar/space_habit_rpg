//
//  DataInfo+CoreDataProperties.m
//  HabitRPG2
//
//  Created by Joel Pridgen on 7/28/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import "DataInfo+CoreDataProperties.h"

@implementation DataInfo (CoreDataProperties)

+ (NSFetchRequest<DataInfo *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"DataInfo"];
}

@dynamic gameState;
@dynamic migrationNumber;
@dynamic nextZoneId;
@dynamic lastUpdateTime;

@end
