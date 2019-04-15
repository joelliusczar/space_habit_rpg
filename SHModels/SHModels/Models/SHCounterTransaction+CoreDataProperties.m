//
//  SHCounterTransaction+CoreDataProperties.m
//  
//
//  Created by Joel Pridgen on 4/14/19.
//
//

#import "SHCounterTransaction+CoreDataProperties.h"

@implementation SHCounterTransaction (CoreDataProperties)

+ (NSFetchRequest<SHCounterTransaction *> *)fetchRequest {
	return [NSFetchRequest fetchRequestWithEntityName:@"SHCounterTransaction"];
}

@dynamic misc;
@dynamic timestamp;

@end
