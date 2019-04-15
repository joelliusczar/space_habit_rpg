//
//  SHItem+CoreDataProperties.m
//  
//
//  Created by Joel Pridgen on 4/14/19.
//
//

#import "SHItem+CoreDataProperties.h"

@implementation SHItem (CoreDataProperties)

+ (NSFetchRequest<SHItem *> *)fetchRequest {
	return [NSFetchRequest fetchRequestWithEntityName:@"SHItem"];
}

@dynamic cost;
@dynamic itemName;
@dynamic lastUpdateDateTime;
@dynamic note;
@dynamic useType;

@end
