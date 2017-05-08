//
//  HabitTransaction+CoreDataProperties.m
//  HabitRPG2
//
//  Created by Joel Pridgen on 5/3/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import "HabitTransaction+CoreDataProperties.h"

@implementation HabitTransaction (CoreDataProperties)

+ (NSFetchRequest<HabitTransaction *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"HabitTransaction"];
}

@dynamic action;
@dynamic activationTime;
@dynamic misc;
@dynamic transaction_habit;

@end