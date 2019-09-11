//
//	SHMonsterInfoDictionary.m
//	HabitRPG2
//
//	Created by Joel Pridgen on 3/27/17.
//	Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import "SHMonsterInfoDictionary.h"
#import <SHCommon/SHCommonUtils.h>
#import <SHCommon/SHSingletonCluster.h>


@interface SHMonsterInfoDictionary()
@end

@implementation SHMonsterInfoDictionary

@synthesize infoDict = _infoDict;
-(SHInfoDictionary*)infoDict{
	if(nil == _infoDict){
		_infoDict = [[SHInfoDictionary alloc] initWithPListKey:@"MonsterInfo"
			AndBundleClass:SHMonsterInfoDictionary.class AndResourceUtil:self.resourceUtil];
	}
	return _infoDict;
}


-(instancetype)initWithResourceUtil:(NSObject<SHResourceUtilityProtocol>*)resourceUtil{
	if(self = [super init]){
		_resourceUtil = resourceUtil;
	}
	return self;
}


-(NSArray<NSString *> *)getMonsterKeyList:(NSString *)sectorKey{
		return [self.infoDict getGroupKeyList:sectorKey];
}


-(NSDictionary *)getMonsterInfo:(NSString *)monsterKey ForSector:(NSString *)sectorKey{
		return [self.infoDict getInfo:monsterKey forGroup:sectorKey];
}


-(NSDictionary *)getMonsterInfo:(NSString *)monsterKey{
		return [self.infoDict getInfo:monsterKey];
}


-(SHMonsterDictionaryEntry *)getMonsterEntry:(NSString*)monsterKey{
	SHMonsterDictionaryEntry *entry = [[SHMonsterDictionaryEntry alloc] initWith:monsterKey withMonsterDict:self];
	return entry;
}

-(NSString *)getName:(NSString *)monsterKey{
	NSString *monName = [self getMonsterInfo:monsterKey][@"NAME"];
	#if SH_EXTRA_ERRORS
		NSAssert(monName,@"Monster name should not be null");
	#else
		if(nil == monName){
			return @"";
		}
	#endif
	return monName;
}

-(NSString *)getDescription:(NSString *)monsterKey{
	NSString *desc = [self getMonsterInfo:monsterKey][@"DESCRIPTION"];
	#if SH_EXTRA_ERRORS
		NSAssert(desc,@"Monster description should not be null");
	#else
		if(nil == desc){
			return @"";
		}
	#endif
	return desc;
}

-(int32_t)getBaseAttack:(NSString *)monsterKey{
 NSNumber *atkLvl = (NSNumber *)[self getMonsterInfo:monsterKey][@"ATTACK_LVL"];
	#if SH_EXTRA_ERRORS
		NSAssert(atkLvl,@"Basic attack should not be null");
	#else
		if(nil == atkLvl){
			return 0;
		}
	#endif
	return atkLvl.intValue;
}

-(int32_t)getBaseDefense:(NSString *)monsterKey{
	NSNumber *defLvl = (NSNumber *)[self getMonsterInfo:monsterKey][@"DEFENSE_LVL"];
	#if SH_EXTRA_ERRORS
		NSAssert(defLvl,@"Basic defense should not be null");
	#else
		if(nil == defLvl){
			return 0;
		}
	#endif
	return defLvl.intValue;
}

-(int32_t)getBaseXP:(NSString *)monsterKey{
	NSNumber *xp = (NSNumber *)[self getMonsterInfo:monsterKey][@"BASE_XP_REWARD"];
	#if SH_EXTRA_ERRORS
		NSAssert(xp,@"Basic XP should not be null");
	#else
		if(nil == xp){
			return 0;
		}
	#endif
	return xp.intValue;
}

-(int32_t)getBaseHP:(NSString *)monsterKey{
	NSNumber *hp = (NSNumber *)[self getMonsterInfo:monsterKey][@"HP"];
	#if SH_EXTRA_ERRORS
		NSAssert(hp,@"Basic defense should not be null");
	#else
		if(nil == hp){
			return 0;
		}
	#endif
	return hp.intValue;
}

-(float)getTreasureDropRate:(NSString *)monsterKey{
	NSNumber *dropRate = (NSNumber *)[self getMonsterInfo:monsterKey][@"TREASURE_DROP_RATE"];
	#if SH_EXTRA_ERRORS
		NSAssert(dropRate,@"Treasure drop rate should not be null");
	#else
		if(nil == dropRate){
			return 0;
		}
	#endif
	return dropRate.floatValue;
}

-(int32_t)getEncounterWeight:(NSString *)monsterKey{
	NSNumber *encounterWeight = (NSNumber *)[self getMonsterInfo:monsterKey][@"ENCOUNTER_WEIGHT"];
	#if SH_EXTRA_ERRORS
		NSAssert(encounterWeight,@"Encounter rate should not be null");
	#else
		if(nil == encounterWeight){
			return 0;
		}
	#endif
	return encounterWeight.intValue;
}

-(NSString *)getGrammaticalAgreement:(NSString *)monsterKey{
	NSString *ga = [self getMonsterInfo:monsterKey][@"GRAMMATICAL_AGREEMENT"];
	#if SH_EXTRA_ERRORS
		NSAssert(ga,@"gramatical agreement should not be null");
	#else
		if(nil == ga){
			return @"";
		}
	#endif
	return ga;
}


@end
