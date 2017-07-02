//
//  DailyTransaction+CoreDataProperties.m
//  HabitRPG2
//
//  Created by Joel Pridgen on 7/2/17.
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
