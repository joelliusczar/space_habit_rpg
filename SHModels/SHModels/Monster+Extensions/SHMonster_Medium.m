//
//  SHMonster_Medium.m
//  SHModels
//
//  Created by Joel Pridgen on 3/25/19.
//  Copyright © 2019 Joel Gillette. All rights reserved.
//

#import <SHData/NSManagedObjectContext+Helper.h>
#import "SHModelTools.h"
#import "SHMonster_Medium.h"

@interface Monster_Medium ()
@property (strong,nonatomic) NSManagedObjectContext *context;
@property (strong,nonatomic) SHMonsterInfoDictionary* monsterInfo;
@end

@implementation Monster_Medium


+(instancetype)newWithContext:(NSManagedObjectContext*)context
withInfoDict:(SHMonsterInfoDictionary*)monsterInfo{
  Monster_Medium *instance = [Monster_Medium new];
  instance.monsterInfo = monsterInfo;
  instance.context = context;
  return instance;
}


-(SHMonsterDTO*)newRandomMonster:(NSString*)sectorKey zoneLvl:(uint32_t)zoneLvl{
    SHMonsterDTO *m = [self newEmptyMonster];
    m.monsterKey = [self randomMonsterKey:sectorKey];
    m.lvl = shCalculateLvl(zoneLvl,SH_MONSTER_LVL_RANGE);
    m.nowHp = m.maxHp;
    return m;
}


-(SHMonsterDTO*)newEmptyMonster{
  return [SHMonsterDTO newWithMonsterDict:self.monsterInfo];
}


-(NSString*)randomMonsterKey:(NSString*)sectorKey{
    SHMonsterInfoDictionary *monInfoDict = self.monsterInfo;
    NSMutableArray<NSString *> *monsterKeys = [NSMutableArray arrayWithArray:[monInfoDict getMonsterKeyList:sectorKey]];
    [monsterKeys addObjectsFromArray:[monInfoDict getMonsterKeyList:@"ALL"]];
    SHProbWeight *pbw = [self buildProbilityWeight:monsterKeys];
    return [pbw weightedRandomKey];
}

-(SHProbWeight*)buildProbilityWeight:(NSMutableArray<NSString*>*)keys{
    SHMonsterInfoDictionary *monInfoDict = self.monsterInfo;
    SHProbWeight *pbw = [[SHProbWeight alloc] init];
    for(NSString* sectorKey in keys){
        int32_t encounterWeight = [monInfoDict getEncounterWeight:sectorKey];
        [pbw add:sectorKey With:encounterWeight];
    }
    return pbw;
}


-(SHMonster*)getCurrentMonster{
  __block SHMonster* m = nil;
  NSManagedObjectContext *context = self.context;
  [context performBlockAndWait:^{
    NSFetchRequest<SHMonster *> *request = [SHMonster fetchRequest];
    NSSortDescriptor *sortByMonsterKey = [[NSSortDescriptor alloc]initWithKey:@"monsterKey" ascending:NO];
    request.sortDescriptors = @[sortByMonsterKey];
    NSArray<NSManagedObject *> *results = [context getItemsWithRequest:request];
    NSCAssert(results.count<2,@"There are too many monsters");
    m = (SHMonster*)results[0];
  }];
  return m;
}

@end
