//
//  GoodTransaction+CoreDataProperties.m
//  HabitRPG2
//
//  Created by Joel Pridgen on 7/2/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import "GoodTransaction+CoreDataProperties.h"

@implementation GoodTransaction (CoreDataProperties)

+ (NSFetchRequest<GoodTransaction *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"GoodTransaction"];
}

@dynamic misc;
@dynamic timestamp;

@end
