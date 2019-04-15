//
//  Monster_Medium.m
//  SHModels
//
//  Created by Joel Pridgen on 3/25/19.
//  Copyright © 2019 Joel Gillette. All rights reserved.
//

#import <SHData/NSManagedObjectContext+Helper.h>
#import "ModelTools.h"
#import "SHMonster_Medium.h"

@interface Monster_Medium ()
@property (strong,nonatomic) NSManagedObjectContext *context;
@property (strong,nonatomic) MonsterInfoDictionary* monsterInfo;
@end

@implementation Monster_Medium


+(instancetype)newWithContext:(NSManagedObjectContext*)context
withInfoDict:(MonsterInfoDictionary*)monsterInfo{
  Monster_Medium *instance = [Monster_Medium new];
  instance.monsterInfo = monsterInfo;
  instance.context = context;
  return instance;
}


-(MonsterDTO*)newRandomMonster:(NSString*)zoneKey zoneLvl:(uint32_t)zoneLvl{
    MonsterDTO *m = [self newEmptyMonster];
    m.monsterKey = [self randomMonsterKey:zoneKey];
    m.lvl = calculateLvl(zoneLvl,MONSTER_LVL_RANGE);
    m.nowHp = m.maxHp;
    return m;
}


-(MonsterDTO*)newEmptyMonster{
  return [MonsterDTO newWithMonsterDict:self.monsterInfo];
}


-(NSString*)randomMonsterKey:(NSString*)zoneKey{
    MonsterInfoDictionary *monInfoDict = self.monsterInfo;
    NSMutableArray<NSString *> *monsterKeys = [NSMutableArray arrayWithArray:[monInfoDict getMonsterKeyList:zoneKey]];
    [monsterKeys addObjectsFromArray:[monInfoDict getMonsterKeyList:@"ALL"]];
    ProbWeight *pbw = [self buildProbilityWeight:monsterKeys];
    return [pbw weightedRandomKey];
}

-(ProbWeight*)buildProbilityWeight:(NSMutableArray<NSString*>*)keys{
    MonsterInfoDictionary *monInfoDict = self.monsterInfo;
    ProbWeight *pbw = [[ProbWeight alloc] init];
    for(NSString* zoneKey in keys){
        int32_t encounterWeight = [monInfoDict getEncounterWeight:zoneKey];
        [pbw add:zoneKey With:encounterWeight];
    }
    return pbw;
}


-(Monster*)getCurrentMonster{
  __block Monster* m = nil;
  NSManagedObjectContext *context = self.context;
  [context performBlockAndWait:^{
    NSFetchRequest<Monster *> *request = [Monster fetchRequest];
    NSSortDescriptor *sortByMonsterKey = [[NSSortDescriptor alloc]initWithKey:@"monsterKey" ascending:NO];
    request.sortDescriptors = @[sortByMonsterKey];
    NSArray<NSManagedObject *> *results = [context getItemsWithRequest:request];
    NSCAssert(results.count<2,@"There are too many monsters");
    m = (Monster*)results[0];
  }];
  return m;
}

@end
