//
//  Good+CoreDataProperties.m
//  HabitRPG2
//
//  Created by Joel Pridgen on 11/15/16.
//  Copyright © 2016 Joel Pridgen. All rights reserved.
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

@end
