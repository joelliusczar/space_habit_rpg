//
//  Zone_Medium.h
//  SHModels
//
//  Created by Joel Pridgen on 2/13/19.
//  Copyright © 2019 Joel Gillette. All rights reserved.
//

#import <SHData/P_CoreData.h>
#import "Zone+CoreDataClass.h"
#import <SHCommon/P_ResourceUtility.h>
#import "SHHeroDTO.h"
#import "SHZoneDTO.h"
#import "ZoneInfoDictionary.h"
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

extern NSString* const HOME_KEY;

@interface Zone_Medium : NSObject

+(instancetype)newWithContext:(NSManagedObjectContext*)context
  withResourceUtil:(NSObject<P_ResourceUtility>*)resourceUtil
  withInfoDict:(ZoneInfoDictionary*)zoneInfo;

-(Zone*)newEmptyZone;
-(NSArray<NSString*>*)getSymbolsList;
-(NSString*)getRandomZoneDefinitionKey:(NSUInteger)heroLvl;
-(NSString*)getSymbolSuffix:(NSUInteger)visitCount;

-(ZoneDTO*)newRandomZoneChoiceGivenHero:(HeroDTO*)hero
  ifShouldMatchLvl:(BOOL)shouldMatchLvl;

-(ZoneDTO*)newSpecificZone2:(NSString*) zoneKey withLvl:(int32_t) lvl;

-(ZoneDTO*)newSpecificZone:(NSString*)zoneKey
  withLvl:(int32_t)lvl withMonsterCount:(int32_t)monsterCount;

-(NSMutableArray<ZoneDTO*>*)newMultipleZoneChoicesGivenHero:(HeroDTO*)hero
  ifShouldMatchLvl:(BOOL)matchLvl;

-(NSArray<Zone*>*)getAllZones:(nullable NSPredicate*)filter;
-(Zone*)getZone:(BOOL)isFront;
-(void)moveZoneToFront:(Zone*)zone;
NSArray<NSString*>* getUnlockedZoneGroupKeys(NSUInteger heroLvl);
@end

NS_ASSUME_NONNULL_END
