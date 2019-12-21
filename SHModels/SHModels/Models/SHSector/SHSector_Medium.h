//
//	SHSector_Medium.h
//	SHModels
//
//	Created by Joel Pridgen on 2/13/19.
//	Copyright © 2019 Joel Gillette. All rights reserved.
//

#import "SHSector.h"
#import "SHSectorArtifact.h"
#import "SHHero.h"
#import "SHSectorInfoDictionary.h"
@import Foundation;
@import SHCommon;


NS_ASSUME_NONNULL_BEGIN

extern NSString* const HOME_KEY;

@interface SHSector_Medium : NSObject

@property (strong,nonatomic) NSManagedObjectContext *context;
@property (strong,nonatomic) NSObject<SHResourceUtilityProtocol>* resourceUtil;
@property (strong,nonatomic) SHSectorInfoDictionary* sectorInfo;

-(instancetype)initWithResourceUtil:(id<SHResourceUtilityProtocol>)resourceUtil;

-(NSArray<NSString*>*)getSymbolsList;
-(NSString*)getRandomSectorDefinitionKey:(NSUInteger)heroLvl;
-(NSString*)getSymbolSuffix:(NSUInteger)visitCount;

-(SHSector*)newRandomSectorChoiceGivenHero:(SHHero*)hero
	ifShouldMatchLvl:(BOOL)shouldMatchLvl;

-(SHSector*)newSpecificSector2:(NSString*) sectorKey withLvl:(NSInteger) lvl;

-(SHSector*)newSpecificSector:(NSString*)sectorKey
	withLvl:(NSInteger)lvl withMonsterCount:(NSInteger)monsterCount;

-(NSArray<SHSector*>*)newMultipleSectorChoicesGivenHero:(SHHero*)hero
	ifShouldMatchLvl:(BOOL)matchLvl;
	
-(nullable NSArray<SHSector*>*)getUndecidedSectorChoices;
-(void)eraseSectorChoices;
NSArray<NSString*>* getUnlockedSectorGroupKeys(NSUInteger heroLvl);
@end

NS_ASSUME_NONNULL_END
