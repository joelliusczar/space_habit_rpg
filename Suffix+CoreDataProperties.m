//
//  Suffix+CoreDataProperties.m
//  HabitRPG2
//
//  Created by Joel Pridgen on 3/26/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import "Suffix+CoreDataProperties.h"

@implementation Suffix (CoreDataProperties)

+ (NSFetchRequest<Suffix *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"Suffix"];
}

@dynamic zoneKey;
@dynamic visitCount;

@end
