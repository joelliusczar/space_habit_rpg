//
//	SHSector_Medium.h
//	SHModels
//
//	Created by Joel Pridgen on 2/13/19.
//	Copyright © 2019 Joel Gillette. All rights reserved.
//

#import <SHData/SHCoreDataProtocol.h>
#import "SHSector.h"
#import <SHCommon/SHResourceUtilityProtocol.h>
#import "SHHero.h"
#import "SHSectorInfoDictionary.h"
#import <Foundation/Foundation.h>


NS_ASSUME_NONNULL_BEGIN

extern NSString* const HOME_KEY;

@interface SHSector_Medium : NSObject

+(instancetype)newWithContext:(nullable NSManagedObjectContext*)context
	withResourceUtil:(NSObject<SHResourceUtilityProtocol>*)resourceUtil;

-(SHSector*)newEmptySector;
-(NSArray<NSString*>*)getSymbolsList;
-(NSString*)getRandomSectorDefinitionKey:(NSUInteger)heroLvl;
-(NSString*)getSymbolSuffix:(NSUInteger)visitCount;

-(SHSector*)newRandomSectorChoiceGivenHero:(SHHero*)hero
	ifShouldMatchLvl:(BOOL)shouldMatchLvl;

-(SHSector*)newSpecificSector2:(NSString*) sectorKey withLvl:(int32_t) lvl;

-(SHSector*)newSpecificSector:(NSString*)sectorKey
	withLvl:(int32_t)lvl withMonsterCount:(int32_t)monsterCount;

-(NSArray<SHSector*>*)newMultipleSectorChoicesGivenHero:(SHHero*)hero
	ifShouldMatchLvl:(BOOL)matchLvl;

-(NSArray<SHSector*>*)getAllSectors:(nullable NSPredicate*)filter;
-(SHSector*)getSector:(BOOL)isFront;
-(void)moveSectorToFront:(SHSector*)sector;
NSArray<NSString*>* getUnlockedSectorGroupKeys(NSUInteger heroLvl);
@end

NS_ASSUME_NONNULL_END
