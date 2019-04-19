//
//  SHHero+CoreDataProperties.m
//  
//
//  Created by Joel Pridgen on 4/14/19.
//
//

#import "SHHero+CoreDataProperties.h"

@implementation SHHero (CoreDataProperties)

+ (NSFetchRequest<SHHero *> *)fetchRequest {
	return [NSFetchRequest fetchRequestWithEntityName:@"SHHero"];
}

@dynamic gold;
@dynamic lastUpdateDateTime;
@dynamic lvl;
@dynamic maxHp;
@dynamic maxXp;
@dynamic nowHp;
@dynamic nowXp;
@dynamic shipName;
@dynamic teaLeaves;

@end
