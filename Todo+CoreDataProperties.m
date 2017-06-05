//
//  Todo+CoreDataProperties.m
//  HabitRPG2
//
//  Created by Joel Pridgen on 6/4/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import "Todo+CoreDataProperties.h"

@implementation Todo (CoreDataProperties)

+ (NSFetchRequest<Todo *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"Todo"];
}

@dynamic difficulty;
@dynamic dueDate;
@dynamic effectiveDate;
@dynamic note;
@dynamic todoName;
@dynamic urgency;
@dynamic userOrder;

@end
