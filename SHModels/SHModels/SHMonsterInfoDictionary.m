//
//  SHMonsterInfoDictionary.m
//  HabitRPG2
//
//  Created by Joel Pridgen on 3/27/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
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


+(instancetype)newWithResourceUtil:(NSObject<SHResourceUtilityProtocol>*)resourceUtil{
  SHMonsterInfoDictionary *instance = [SHMonsterInfoDictionary new];
  instance.resourceUtil = resourceUtil;
  return instance;
}

-(NSArray<NSString *> *)getMonsterKeyList:(NSString *)sectorKey{
    return [self.infoDict getGroupKeyList:sectorKey];
}


-(NSDictionary *)getMonsterInfo:(NSString *)monsterKey ForZone:(NSString *)sectorKey{
    return [self.infoDict getInfo:monsterKey forGroup:sectorKey];
}

-(NSDictionary *)getMonsterInfo:(NSString *)monsterKey{
    return [self.infoDict getInfo:monsterKey];
}

-(NSString *)getName:(NSString *)monsterKey{
    return [self getMonsterInfo:monsterKey][@"NAME"];
}

-(NSString *)getDescription:(NSString *)monsterKey{
    return [self getMonsterInfo:monsterKey][@"DESCRIPTION"];
}

-(int32_t)getBaseAttack:(NSString *)monsterKey{
   NSNumber *atkLvl = (NSNumber *)[self getMonsterInfo:monsterKey][@"ATTACK_LVL"];
    return atkLvl.intValue;
}

-(int32_t)getBaseDefense:(NSString *)monsterKey{
    NSNumber *defLvl = (NSNumber *)[self getMonsterInfo:monsterKey][@"DEFENSE_LVL"];
    return defLvl.intValue;
}

-(int32_t)getBaseXP:(NSString *)monsterKey{
    NSNumber *xp = (NSNumber *)[self getMonsterInfo:monsterKey][@"BASE_XP_REWARD"];
    return xp.intValue;
}

-(int32_t)getBaseHP:(NSString *)monsterKey{
    NSNumber *hp = (NSNumber *)[self getMonsterInfo:monsterKey][@"HP"];
    return hp.intValue;
}

-(float)getTreasureDropRate:(NSString *)monsterKey{
  NSNumber *dropRate = (NSNumber *)[self getMonsterInfo:monsterKey][@"TREASURE_DROP_RATE"];
    return dropRate.floatValue;
}

-(int32_t)getEncounterWeight:(NSString *)monsterKey{
    NSNumber *encounterWeight = (NSNumber *)[self getMonsterInfo:monsterKey][@"ENCOUNTER_WEIGHT"];
    return encounterWeight.intValue;
}

-(NSString *)getGrammaticalAgreement:(NSString *)monsterKey{
    return [self getMonsterInfo:monsterKey][@"GRAMMATICAL_AGREEMENT"];
}


@end
