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

@implementation MonsterHelper

+(Monster *)constructRandomMonster:(NSString *)zoneKey AroundLvl:(uint32_t)zoneLvl{
    Monster *m = [self constructEmptyMonster];
    //todo
    return m;
}

+(Monster *)constructEmptyMonster{
    
    NSObject<P_CoreData> *dataController = [SingletonCluster getSharedInstance].dataController;
    return (Monster *)[dataController constructEmptyEntity:MONSTER_ENTITY_NAME];
}

@end