//
//	SHSector_Medium.m
//	SHModels
//
//	Created by Joel Pridgen on 2/13/19.
//	Copyright © 2019 Joel Gillette. All rights reserved.
//

#import <SHCommon/SHCommonUtils.h>
#import <SHData/NSManagedObjectContext+Helper.h>
#import "SHSuffix.h"
#import "SHModelTools.h"
#import "SHModelConstants.h"
#import "SHSector_Medium.h"
#import "SHHero_Medium.h"


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

+(instancetype)newWithContext:(NSManagedObjectContext*)context
withResourceUtil:(NSObject<SHResourceUtilityProtocol>*)resourceUtil{
	SHSector_Medium *instance = [[SHSector_Medium alloc] init];
	instance.context = context;
	instance.resourceUtil = resourceUtil;
	return instance;
}


-(NSArray<NSString*>*)getSymbolsList{
	NSBundle *bundle = [NSBundle bundleForClass:SHSector.class];
	NSArray *symbols = [self.resourceUtil getPListArray:@"SuffixList" withBundle:bundle];

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


-(SHSuffix*)getSuffixEntity:(NSString*)sectorKey{
	NSFetchRequest<SHSuffix*>* request = [SHSuffix fetchRequest];
	NSSortDescriptor* sortBySectorKey = [[NSSortDescriptor alloc] initWithKey:@"sectorKey" ascending:NO];
	NSPredicate* filter = [NSPredicate predicateWithFormat:@"sectorKey = %@",sectorKey];
	request.predicate = filter;
	request.sortDescriptors = @[sortBySectorKey];
	NSArray<NSManagedObject*>* results = [self.context getItemsWithRequest:request];

	NSCAssert(results.count<2, @"There are too many entities");
	SHSuffix* s = nil;
	if(results.count){
		s = (SHSuffix*)results[0];
	}
	else{
		s = (SHSuffix*)[self.context newEntity:SHSuffix.entity];
		s.sectorKey = sectorKey;
	}
	return s;
}


-(SHSector*)newEmptySector{
	//if we change here update afterSectorPick
	return (SHSector*)[NSManagedObjectContext newEntityUnattached:SHSector.entity];
}

/*
	I am going to let this on touching a suffix rather than
	picking a sector with a suffix because I don't want
	sector alpha to show up twice for example
*/
-(int32_t)getVisitCountForSector:(NSString*)sectorKey{
	/*
	The reason we're doing this whole temp context stuff is because we
	call save for the suffix and we don't want stuff that's already in the context to save
	this used to be in constructMultipleSectorChoicesGivenHero
	but I counldn't remember my reason for having it there
	to justify keeping it there.
	*/
	__weak SHSector_Medium *weakSelf = self;
	__block int currentVisitCount = 0;
	NSManagedObjectContext *context = self.context;
	[context performBlockAndWait:^{
		SHSuffix *s = [weakSelf getSuffixEntity:sectorKey];
		currentVisitCount = s.visitCount++;
		NSError *error = nil;
		[context save:&error];
	}];
	
	return currentVisitCount;
}


-(SHSector*)newSpecificSector:(NSString*) sectorKey
withLvl:(int32_t)lvl withMonsterCount:(int32_t)monsterCount{
	
	NSAssert(sectorKey,@"Key can't be null");
	NSAssert(lvl > 0, @"Lvl must be greater than 0");
	SHSector *z = (SHSector*)[self.context newEntity:SHSector.entity];
	z.sectorKey = sectorKey;
	z.suffix = [self getSymbolSuffix:[self getVisitCountForSector:sectorKey]];
	z.maxMonsters = monsterCount;
	z.monstersKilled = 0;
	z.lvl = lvl;
	return z;
}


-(SHSector*)newSpecificSector2:(NSString*) sectorKey withLvl:(int32_t) lvl{
	int32_t monsterCount = shRandomUInt(SH_MAX_MONSTER_RAND_UP_BOUND) + SH_MAX_MONSTER_LOW_BOUND;
	return [self newSpecificSector:sectorKey withLvl:lvl withMonsterCount: monsterCount];
}


-(SHSector*)newRandomSectorChoiceGivenHero:(SHHero*)hero ifShouldMatchLvl:(BOOL)shouldMatchLvl{
	NSString *sectorKey = [self getRandomSectorDefinitionKey:hero.lvl];
	int32_t sectorLvl = shouldMatchLvl?hero.lvl:shCalculateLvl(hero.lvl,SH_SECTOR_LVL_RANGE);
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


-(NSArray<SHSector*>*)getAllSectors:(NSPredicate*) filter{
	__block NSArray *results = nil;
	[self.context performBlockAndWait:^{
		NSFetchRequest<SHSector *> *request = [SHSector fetchRequest];
		NSSortDescriptor *sortByIsFront = [[NSSortDescriptor alloc] initWithKey:@"isFront" ascending:NO];
		request.predicate = filter;
		request.sortDescriptors = @[sortByIsFront];
		results = [self.context getItemsWithRequest:request];
	}];

	return results;
}


-(SHSector*)getSector:(BOOL)isFront{
	NSPredicate *filter = nil;
	NSArray<SHSector*> *results = nil;
	filter = [NSPredicate predicateWithFormat:@"isFront =%d",isFront?1:0];
	results = [self getAllSectors:filter];
	if(results.count > 1){
		@throw [NSException exceptionWithName:@"CorruptionException"
			reason:@"There are too many sectors" userInfo:nil];
	}
	return results.count > 0 ? (SHSector *)results[0] : nil;
}


-(void)moveSectorToFront:(nonnull SHSector*)sector{
	NSAssert(sector && sector.managedObjectContext,@"Sector must be registered in a context already");
	NSManagedObjectContext *context = sector.managedObjectContext;
	[context performBlockAndWait:^{
		NSArray<SHSector*> *results = [self getAllSectors:nil];
		
		sector.isFront = YES;
		NSAssert(results.count<4, @"There are too many sectors");
		if(results.count < 2){
			return;
		}
		NSPredicate *filterNewItem = [NSPredicate predicateWithBlock:^BOOL(id item, NSDictionary<NSString*,id> *bindings){
			(void)bindings;
			if(item == sector) return NO;
			return YES;
		}];
		NSArray<SHSector*> *filtered = [results filteredArrayUsingPredicate:filterNewItem];
		filtered[0].isFront = NO;
		if(results.count == 2){
			return;
		}
		[context deleteObject:filtered[1]];
	}];
	
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
