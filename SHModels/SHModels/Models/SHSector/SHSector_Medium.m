//
//	SHSector_Medium.m
//	SHModels
//
//	Created by Joel Pridgen on 2/13/19.
//	Copyright © 2019 Joel Gillette. All rights reserved.
//

#import "SHSuffix.h"
#import "SHModelTools.h"
#import "SHModelConstants.h"
#import "SHSector_Medium.h"
@import SHCommon;
@import SHData;


NSString* const HOME_KEY = @"HOME";

@interface SHSector_Medium ()

@end

@implementation SHSector_Medium

-(SHSectorInfoDictionary*)sectorInfo{
	if(nil == _sectorInfo){
		_sectorInfo = SHSector.sectorInfo;
	}
	return _sectorInfo;
}

-(instancetype)initWithResourceUtil:(NSObject<SHResourceUtilityProtocol>*)resourceUtil{
	if(self = [super init]){
		_resourceUtil = resourceUtil;
	}
	return self;
}


-(NSArray<NSString*>*)getSymbolsList{
	NSArray *symbols = [self.resourceUtil getPListArray:@"SuffixList"];

	return symbols;
}


-(NSString*)getRandomSectorDefinitionKey:(NSUInteger)heroLvl{
	NSArray<NSString *> *groupKeys = getUnlockedSectorGroupKeys(heroLvl);
	uint r = shRandomUInt((uint)groupKeys.count);
	NSString *groupKey = groupKeys[r];
	SHSectorInfoDictionary *zd = self.sectorInfo;
	NSArray *sectorList = [zd getGroupKeyList:groupKey];
	r = shRandomUInt((uint32_t)sectorList.count);
	return sectorList[r];
}


-(NSString*)getSymbolSuffix:(NSUInteger)visitCount{
	NSMutableArray<NSString *> *suffixList = [NSMutableArray array];
	NSArray *symbols = [self getSymbolsList];
	while(visitCount > 0){
		NSUInteger m = (visitCount-1) % symbols.count;
		visitCount -= m;
		visitCount /= symbols.count;
		[suffixList addObject:symbols[m]];
	}
	return [[[suffixList reverseObjectEnumerator] allObjects] componentsJoinedByString:@" "];
}

/*
	I am going to let this on touching a suffix rather than
	picking a sector with a suffix because I don't want
	sector alpha to show up twice for example
*/
-(NSInteger)getVisitCountForSector:(NSString*)sectorKey{
	SHSuffix *suffixTracker = [[SHSuffix alloc] initWithResourceUtil:self.resourceUtil];
	NSInteger currentVisitCount = [suffixTracker getAndIncrementCountForSector:sectorKey];
	[suffixTracker saveToFile];
	return currentVisitCount;
}


-(SHSector*)newSpecificSector:(NSString*) sectorKey
withLvl:(NSInteger)lvl withMonsterCount:(NSInteger)monsterCount{
	
	NSAssert(sectorKey,@"Key can't be null");
	NSAssert(lvl > 0, @"Lvl must be greater than 0");
	SHSector *sector = [[SHSector alloc] initEmptyWithResourceUtil:self.resourceUtil];;
	sector.sectorKey = sectorKey;
	sector.suffix = [self getSymbolSuffix:[self getVisitCountForSector:sectorKey]];
	sector.maxMonsters = monsterCount;
	sector.monstersKilled = 0;
	sector.lvl = lvl;
	return sector;
}


-(SHSector*)newSpecificSector2:(NSString*) sectorKey withLvl:(NSInteger) lvl{
	NSInteger monsterCount = shRandomUInt(SH_MAX_MONSTER_RAND_UP_BOUND) + SH_MAX_MONSTER_LOW_BOUND;
	return [self newSpecificSector:sectorKey withLvl:lvl withMonsterCount: monsterCount];
}


-(SHSector*)newRandomSectorChoiceGivenHero:(SHHero*)hero ifShouldMatchLvl:(BOOL)shouldMatchLvl{
	NSString *sectorKey = [self getRandomSectorDefinitionKey:hero.lvl];
	NSInteger sectorLvl = shouldMatchLvl?hero.lvl:shCalculateLvl(hero.lvl,SH_SECTOR_LVL_RANGE);
	SHSector *z = [self newSpecificSector2:sectorKey withLvl:sectorLvl];
	return z;
}


-(NSArray<SHSector*>*)newMultipleSectorChoicesGivenHero:(SHHero*)hero ifShouldMatchLvl:(BOOL)matchLvl{
	//Sector create uses nil context so that should be okay
	
	uint sectorCount = shRandomUInt(SH_MAX_ZONE_CHOICE_RAND_UP_BOUND)	+ SH_MIN_ZONE_CHOICE_COUNT;
	NSMutableArray<SHSector *> *choices = [NSMutableArray arrayWithCapacity:sectorCount];
	choices[0] = [self newRandomSectorChoiceGivenHero:hero ifShouldMatchLvl:matchLvl];
	for(uint i = 1;i<sectorCount;i++){
		choices[i] = [self newRandomSectorChoiceGivenHero:hero ifShouldMatchLvl:NO];
	}
	
	return choices;
}


/*
 We're adding the sector groups to a list and one of them will be randomly selected
 */
NSArray<NSString*>* getUnlockedSectorGroupKeys(NSUInteger heroLvl){
	if(heroLvl == 0){
		return @[SH_LVL_0_SECTORS];
	}
	NSMutableArray<NSString *> *availableSectorGroups	= [[NSMutableArray alloc]init];
	[availableSectorGroups addObject:SH_LVL_1_SECTORS];
	if(heroLvl >= 5){
		[availableSectorGroups addObject:SH_LVL_5_SECTORS];
		if(heroLvl >= 10){
			[availableSectorGroups addObject:SH_LVL_10_SECTORS];
			if(heroLvl >= 15){
				[availableSectorGroups addObject:SH_LVL_15_SECTORS];
				if(heroLvl >= 20){
					[availableSectorGroups addObject:SH_LVL_20_SECTORS];
					if(heroLvl >= 25){
						[availableSectorGroups addObject:SH_LVL_25_SECTORS];
						if(heroLvl >= 30){
							[availableSectorGroups addObject:SH_LVL_30_SECTORS];
						}
					}
				}
			}
		}
	}
	return [NSArray arrayWithArray:availableSectorGroups];
}


@end
