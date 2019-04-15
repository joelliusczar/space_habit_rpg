//
//  SHTodoTransaction+CoreDataProperties.m
//  
//
//  Created by Joel Pridgen on 4/14/19.
//
//

#import "SHTodoTransaction+CoreDataProperties.h"

@implementation SHTodoTransaction (CoreDataProperties)

+ (NSFetchRequest<SHTodoTransaction *> *)fetchRequest {
	return [NSFetchRequest fetchRequestWithEntityName:@"SHTodoTransaction"];
}

@dynamic misc;
@dynamic timestamp;

@end
