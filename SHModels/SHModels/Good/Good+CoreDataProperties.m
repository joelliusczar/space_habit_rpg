//
//  Good+CoreDataProperties.m
//  HabitRPG2
//
//  Created by Joel Pridgen on 7/28/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import "Good+CoreDataProperties.h"

@implementation Good (CoreDataProperties)

+ (NSFetchRequest<Good *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"Good"];
}

@dynamic cost;
@dynamic goodName;
@dynamic note;
@dynamic useType;
@dynamic lastUpdateTime;

@end
