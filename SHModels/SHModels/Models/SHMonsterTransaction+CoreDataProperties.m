//
//  SHMonsterTransaction+CoreDataProperties.m
//  
//
//  Created by Joel Pridgen on 4/14/19.
//
//

#import "SHMonsterTransaction+CoreDataProperties.h"

@implementation SHMonsterTransaction (CoreDataProperties)

+ (NSFetchRequest<SHMonsterTransaction *> *)fetchRequest {
	return [NSFetchRequest fetchRequestWithEntityName:@"SHMonsterTransaction"];
}

@dynamic misc;
@dynamic timestamp;

@end
