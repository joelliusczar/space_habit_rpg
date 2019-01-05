//
//  MonsterHelper.m
//  HabitRPG2
//
//  Created by Joel Pridgen on 3/29/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import "Monster+Helper.h"
#import "SingletonCluster+Entity.h"
#import <SHData/P_CoreData.h>
#import "ModelTools.h"
#import <SHGlobal/Constants.h>
#import "MonsterInfoDictionary.h"


@implementation Monster (Helper)

Monster* constructRandomMonster(NSString* zoneKey,uint32_t zoneLvl){
    Monster *m = constructEmptyMonster();
    m.monsterKey = randomMonsterKey(zoneKey);
    m.lvl = calculateLvl(zoneLvl,MONSTER_LVL_RANGE);
    m.nowHp = m.maxHp;
    return m;
}

Monster* constructEmptyMonster(){
    NSObject<P_CoreData> *dataController = [SingletonCluster getSharedInstance].dataController;
    return (Monster *)[dataController constructEmptyEntity:Monster.entity];
}

NSString* randomMonsterKey(NSString* zoneKey){
    MonsterInfoDictionary *monInfoDict = [SingletonCluster getSharedInstance].monsterInfoDictionary;
    NSMutableArray<NSString *> *monsterKeys = [NSMutableArray arrayWithArray:[monInfoDict getMonsterKeyList:zoneKey]];
    [monsterKeys addObjectsFromArray:[monInfoDict getMonsterKeyList:@"ALL"]];
    ProbWeight *pbw = buildProbilityWeight(monsterKeys);
    return [pbw weightedRandomKey];
}

ProbWeight* buildProbilityWeight(NSMutableArray<NSString*>* keys){
    MonsterInfoDictionary *monInfoDict = [SingletonCluster getSharedInstance].monsterInfoDictionary;
    ProbWeight *pbw = [[ProbWeight alloc] init];
    for(NSString* zoneKey in keys){
        int32_t encounterWeight = [monInfoDict getEncounterWeight:zoneKey];
        [pbw add:zoneKey With:encounterWeight];
    }
    return pbw;
}

Monster* getCurrentMonster(){
    NSFetchRequest<Monster *> *request = [Monster fetchRequest];
    NSSortDescriptor *sortByMonsterKey = [[NSSortDescriptor alloc]initWithKey:@"monsterKey" ascending:NO];
    NSArray<NSManagedObject *> *results = [[SingletonCluster getSharedInstance].dataController getItemWithRequest:request predicate:nil sortBy:@[sortByMonsterKey]];
    NSCAssert(results.count<2,@"There are too many monsters");
    return (Monster *)results[0];
}

@end
