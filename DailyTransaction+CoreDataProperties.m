//
//  DailyTransaction+CoreDataProperties.m
//  HabitRPG2
//
//  Created by Joel Pridgen on 5/23/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import "DailyTransaction+CoreDataProperties.h"

@implementation DailyTransaction (CoreDataProperties)

+ (NSFetchRequest<DailyTransaction *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"DailyTransaction"];
}

@dynamic misc;
@dynamic timestamp;

@end
