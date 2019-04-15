//
//  SHSector+CoreDataProperties.m
//  
//
//  Created by Joel Pridgen on 4/14/19.
//
//

#import "SHSector+CoreDataProperties.h"

@implementation SHSector (CoreDataProperties)

+ (NSFetchRequest<SHSector *> *)fetchRequest {
	return [NSFetchRequest fetchRequestWithEntityName:@"SHSector"];
}

@dynamic isFront;
@dynamic lastUpdateDateTime;
@dynamic lvl;
@dynamic maxMonsters;
@dynamic monstersKilled;
@dynamic suffix;
@dynamic uniqueId;
@dynamic sectorKey;

@end
