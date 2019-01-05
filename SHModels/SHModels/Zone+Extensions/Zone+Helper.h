//
//  Zone+Helper.h
//  SHModels
//
//  Created by Joel Pridgen on 2/27/18.
//  Copyright © 2018 Joel Gillette. All rights reserved.
//

#import "Zone+CoreDataClass.h"
#import "Hero+CoreDataClass.h"

extern NSString* const HOME_KEY;

@interface Zone (Helper)
NSArray<NSString *>* getUnlockedZoneGroupKeys(NSUInteger heroLvl);
NSString* getRandomZoneDefinitionKey(NSUInteger heroLvl);
NSString* getSymbolSuffix(NSUInteger visitCount);
NSArray<NSString*>* getSymbolsList(void);
Zone* constructEmptyZone(void);
Zone* constructRandomZoneChoice(Hero* hero,BOOL shouldMatchLvl);
Zone* constructSpecificZone2(NSString* zoneKey,int32_t lvl);
Zone* constructSpecificZone(NSString* zoneKey, int32_t lvl,int32_t monsterCount);
NSMutableArray<Zone*>* constructMultipleZoneChoices(Hero* hero,BOOL matchLvl);
Zone * getZone(BOOL isFront);
NSArray<NSManagedObject*>* getAllZones(NSPredicate* filter);
-(void)moveZoneToFront;
@end
