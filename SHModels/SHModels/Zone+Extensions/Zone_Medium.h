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
#import "Hero+CoreDataClass.h"
#import "ZoneInfoDictionary.h"
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

extern NSString* const HOME_KEY;

@interface Zone_Medium : NSObject

+(instancetype)newWithDataController:(NSObject<P_CoreData>*)dataController
withResourceUtil:(NSObject<P_ResourceUtility>*)resourceUtil
withInfoDict:(ZoneInfoDictionary*)zoneInfo;
-(Zone*)constructEmptyZone;
-(NSArray<NSString*>*)getSymbolsList;
-(NSString*)getRandomZoneDefinitionKey:(NSUInteger)heroLvl;
-(NSString*)getSymbolSuffix:(NSUInteger)visitCount;

-(Zone*)constructRandomZoneChoiceGivenHero:(Hero*)hero
ifShouldMatchLvl:(BOOL)shouldMatchLvl;

-(Zone*)constructSpecificZone2:(NSString*) zoneKey withLvl:(int32_t) lvl;

-(Zone*)constructSpecificZone:(NSString*)zoneKey
withLvl:(int32_t)lvl withMonsterCount:(int32_t)monsterCount;

-(NSMutableArray<Zone*>*)constructMultipleZoneChoicesGivenHero:(Hero*)hero
ifShouldMatchLvl:(BOOL)matchLvl;

-(NSArray<Zone*>*)getAllZones:(nullable NSPredicate*)filter;

-(NSArray<Zone*>*)getAllZones:(nullable NSPredicate*)filter
withContext:(nullable NSManagedObjectContext*)context;

-(Zone*)getZone:(BOOL)isFront;

-(void)moveZoneToFront:(Zone*)zone;
-(void)moveZoneToFront:(Zone*)zone withContext:(nullable NSManagedObjectContext*)context;
NSArray<NSString*>* getUnlockedZoneGroupKeys(NSUInteger heroLvl);
@end

NS_ASSUME_NONNULL_END
