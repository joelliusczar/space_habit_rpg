//
//  SHItemTransaction+CoreDataProperties.m
//  
//
//  Created by Joel Pridgen on 4/14/19.
//
//

#import "SHItemTransaction+CoreDataProperties.h"

@implementation SHItemTransaction (CoreDataProperties)

+ (NSFetchRequest<SHItemTransaction *> *)fetchRequest {
	return [NSFetchRequest fetchRequestWithEntityName:@"SHItemTransaction"];
}

@dynamic misc;
@dynamic timestamp;

@end
