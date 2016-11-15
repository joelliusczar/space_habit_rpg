//
//  DataInfo+CoreDataProperties.m
//  HabitRPG2
//
//  Created by Joel Pridgen on 11/15/16.
//  Copyright © 2016 Joel Pridgen. All rights reserved.
//  This file was automatically generated and should not be edited.
//

#import "DataInfo+CoreDataProperties.h"

@implementation DataInfo (CoreDataProperties)

+ (NSFetchRequest<DataInfo *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"DataInfo"];
}

@dynamic nextZoneId;

@end
