//
//  SHCategory+CoreDataProperties.m
//  
//
//  Created by Joel Pridgen on 4/14/19.
//
//

#import "SHCategory+CoreDataProperties.h"

@implementation SHCategory (CoreDataProperties)

+ (NSFetchRequest<SHCategory *> *)fetchRequest {
	return [NSFetchRequest fetchRequestWithEntityName:@"SHCategory"];
}

@dynamic name;
@dynamic colorNum;

@end
