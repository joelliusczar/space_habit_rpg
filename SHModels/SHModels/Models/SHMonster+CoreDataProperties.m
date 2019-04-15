//
//  SHMonster+CoreDataProperties.m
//  
//
//  Created by Joel Pridgen on 4/14/19.
//
//

#import "SHMonster+CoreDataProperties.h"

@implementation SHMonster (CoreDataProperties)

+ (NSFetchRequest<SHMonster *> *)fetchRequest {
	return [NSFetchRequest fetchRequestWithEntityName:@"SHMonster"];
}

@dynamic lastUpdateDateTime;
@dynamic lvl;
@dynamic monsterKey;
@dynamic nowHp;

@end
