//
//  MonsterHelper.m
//  HabitRPG2
//
//  Created by Joel Pridgen on 3/29/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import "MonsterHelper.h"
#import "SingletonCluster.h"
#import "P_CoreData.h"
#import "CommonUtilities.h"
#import "constants.h"
#import "MonsterInfoDictionary.h"
#import "ProbWeight.h"

@implementation MonsterHelper

    +(Monster *)constructRandomMonster:(NSString *)zoneKey AroundLvl:(uint32_t)zoneLvl{
        Monster *m = [MonsterHelper constructEmptyMonster];
        m.monsterKey = [MonsterHelper randomMonsterKey:zoneKey];
        m.lvl = [CommonUtilities calculateLvl:zoneLvl OffsetBy:MONSTER_LVL_RANGE];
        m.nowHp = m.maxHp;
        return m;
    }

    +(Monster *)constructEmptyMonster{
        
        NSObject<P_CoreData> *dataController = [SingletonCluster getSharedInstance].dataController;
        return (Monster *)[dataController constructEmptyEntity:MONSTER_ENTITY_NAME];
    }
    
    +(NSString *)randomMonsterKey:(NSString *)zoneKey{
        MonsterInfoDictionary *monInfoDict = [SingletonCluster getSharedInstance].monsterInfoDictionary;
        NSMutableArray<NSString *> *monsterKeys = [NSMutableArray arrayWithArray:[monInfoDict getMonsterKeyList:zoneKey]];
        [monsterKeys addObjectsFromArray:[monInfoDict getMonsterKeyList:@"ALL"]];
        ProbWeight *pbw = [MonsterHelper buildProbilityWeigher:monsterKeys];
        return [pbw weightedRandomKey];
    }
    
    +(ProbWeight *)buildProbilityWeigher:(NSMutableArray<NSString *> *)keys{
        MonsterInfoDictionary *monInfoDict = [SingletonCluster getSharedInstance].monsterInfoDictionary;
        ProbWeight *pbw = [[ProbWeight alloc] init];
        NSEnumerator<NSString *> *enumer = keys.objectEnumerator;
        NSString *nextKey;
        while(nextKey = [enumer nextObject]){
            int32_t encounterWeight = [monInfoDict getEncounterWeight:nextKey];
            [pbw add:nextKey With:encounterWeight];
        }
        return pbw;
    }
    


@end
