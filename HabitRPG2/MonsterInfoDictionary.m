//
//  MonsterInfoDictionary.m
//  HabitRPG2
//
//  Created by Joel Pridgen on 3/27/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import "MonsterInfoDictionary.h"
#import "CommonUtilities.h"
#import "SingletonCluster.h"

@interface MonsterInfoDictionary()
    @property (nonatomic,strong) NSDictionary *treeDict;
    @property (nonatomic,strong) NSMutableDictionary *flatDict;
@end

@implementation MonsterInfoDictionary

@synthesize treeDict = _treeDict;
-(NSDictionary *)treeDict{
    if(!_treeDict){
        NSObject<P_ResourceUtility> *ru = [SingletonCluster getSharedInstance].resourceUtility;
        _treeDict = [ru getPListDict:@"MonsterInfo" withClassBundle:self.class];
    }
    return _treeDict;
}

@synthesize flatDict = _flatDict;
-(NSMutableDictionary *)flatDict{
    if(!_flatDict){
        _flatDict = [NSMutableDictionary dictionary];
    }
    return _flatDict;
}

+(instancetype)construct{
    MonsterInfoDictionary *instance = [[MonsterInfoDictionary alloc]init];
    return instance;
}

-(NSArray<NSString *> *)getMonsterKeyList:(NSString *)zoneKey{
    NSDictionary *zone = self.treeDict[zoneKey];
    return zone.allKeys;
}

-(NSDictionary *)searchZonesForMonster:(NSString *)monsterKey{
    NSEnumerator<NSString*> *enumerator = [self.treeDict keyEnumerator];
    NSString *nextKey;
    while(nextKey = [enumerator nextObject]){
        if(self.treeDict[nextKey][monsterKey]){
            return self.treeDict[nextKey][monsterKey];
        }
    }
    return nil;
}

-(NSDictionary *)getMonsterInfo:(NSString *)monsterKey ForZone:(NSString *)zoneKey{
    if(self.treeDict[zoneKey][monsterKey]){
        NSDictionary *monsterInfo = self.treeDict[zoneKey][monsterKey];
        if(!self.flatDict[zoneKey]){
            self.flatDict[zoneKey] = monsterInfo;
        }
        return monsterInfo;
    }
    return nil;
}

-(NSDictionary *)getMonsterInfo:(NSString *)monsterKey{
    NSDictionary *monsterInfo;
    if(!(monsterInfo = [self.flatDict valueForKey:monsterKey])){
        monsterInfo = [self searchZonesForMonster:monsterKey];
        if(monsterInfo){
            self.flatDict[monsterKey] = monsterInfo;
        }
    }
    return monsterInfo;
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

-(int32_t)getBaseHP:(NSString *)monsterKey{//TODO: figure out how I want to handle this
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
