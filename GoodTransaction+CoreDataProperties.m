//
//  GoodTransaction+CoreDataProperties.m
//  HabitRPG2
//
//  Created by Joel Pridgen on 5/23/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import "GoodTransaction+CoreDataProperties.h"

@implementation GoodTransaction (CoreDataProperties)

+ (NSFetchRequest<GoodTransaction *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"GoodTransaction"];
}

@dynamic timestamp;
@dynamic misc;

@end
