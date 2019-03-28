//
//  Monster_Medium.m
//  SHModels
//
//  Created by Joel Pridgen on 3/25/19.
//  Copyright © 2019 Joel Gillette. All rights reserved.
//

#import <SHData/NSManagedObjectContext+Helper.h>
#import "ModelTools.h"
#import "Monster_Medium.h"

@interface Monster_Medium ()
@property (strong,nonatomic) NSObject<P_CoreData>* dataController;
@property (strong,nonatomic) MonsterInfoDictionary* monsterInfo;
@end

@implementation Monster_Medium


+(instancetype)newWithDataController:(NSObject<P_CoreData>*)dataController
withInfoDict:(MonsterInfoDictionary*)monsterInfo{
  Monster_Medium *instance = [Monster_Medium new];
  instance.monsterInfo = monsterInfo;
  instance.dataController = dataController;
  return instance;
}


-(Monster*)newRandomMonster:(NSString*)zoneKey zoneLvl:(uint32_t)zoneLvl{
    Monster *m = [self newEmptyMonster];
    m.monsterKey = [self randomMonsterKey:zoneKey];
    m.lvl = calculateLvl(zoneLvl,MONSTER_LVL_RANGE);
    m.nowHp = m.maxHp;
    return m;
}


-(Monster*)newEmptyMonster{
  return (Monster*)[NSManagedObjectContext newEntityUnattached:Monster.entity];
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


-(Monster*)getCurrentMonsterWithContext:(NSManagedObjectContext*)context{
  if(nil == context){
    context = self.dataController.mainThreadContext;
  }
  __block Monster* m = nil;
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


-(Monster*)getCurrentMonster{
  return [self getCurrentMonsterWithContext:nil];
}

@end
