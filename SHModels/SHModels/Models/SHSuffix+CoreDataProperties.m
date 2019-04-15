//
//  SHSuffix+CoreDataProperties.m
//  
//
//  Created by Joel Pridgen on 4/14/19.
//
//

#import "SHSuffix+CoreDataProperties.h"

@implementation SHSuffix (CoreDataProperties)

+ (NSFetchRequest<SHSuffix *> *)fetchRequest {
	return [NSFetchRequest fetchRequestWithEntityName:@"SHSuffix"];
}

@dynamic visitCount;
@dynamic sectorKey;

@end
