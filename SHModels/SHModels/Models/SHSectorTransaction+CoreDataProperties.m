//
//  SHSectorTransaction+CoreDataProperties.m
//  
//
//  Created by Joel Pridgen on 4/14/19.
//
//

#import "SHSectorTransaction+CoreDataProperties.h"

@implementation SHSectorTransaction (CoreDataProperties)

+ (NSFetchRequest<SHSectorTransaction *> *)fetchRequest {
	return [NSFetchRequest fetchRequestWithEntityName:@"SHSectorTransaction"];
}

@dynamic misc;
@dynamic timestamp;

@end
