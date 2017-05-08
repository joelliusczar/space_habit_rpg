//
//  TodoTransaction+CoreDataProperties.m
//  HabitRPG2
//
//  Created by Joel Pridgen on 5/3/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import "TodoTransaction+CoreDataProperties.h"

@implementation TodoTransaction (CoreDataProperties)

+ (NSFetchRequest<TodoTransaction *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"TodoTransaction"];
}

@dynamic action;
@dynamic activationTime;
@dynamic misc;
@dynamic transaction_todo;

@end