//
//  SHDailyTransaction+CoreDataProperties.m
//  
//
//  Created by Joel Pridgen on 4/14/19.
//
//

#import "SHDailyTransaction+CoreDataProperties.h"

@implementation SHDailyTransaction (CoreDataProperties)

+ (NSFetchRequest<SHDailyTransaction *> *)fetchRequest {
	return [NSFetchRequest fetchRequestWithEntityName:@"SHDailyTransaction"];
}

@dynamic misc;
@dynamic timestamp;

@end
