//
//  MonsterMaker.m
//  HabitRPG2
//
//  Created by Joel Pridgen on 3/26/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import "MonsterMaker.h"
#import "P_CoreData.h"
#import "constants.h"

@interface MonsterMaker()
@property (nonatomic,weak) NSObject<P_CoreData> *dataController;

@end

@implementation MonsterMaker

-(instancetype)initWithDataController:(NSObject<P_CoreData>*)dataController{
    if(self = [self init]){
        self.dataController = dataController;
    }
    return self;
}

+(instancetype)constructWithDataController:(NSObject<P_CoreData>*)dataController{
    return [[MonsterMaker alloc] initWithDataController:dataController];
}

-(Monster *)constructRandomMonster:(NSString *)zoneKey AroundLvl:(uint32_t)zoneLvl{
    Monster *m = [self constructEmptyMonster];
    //todo
    return m;
}

-(Monster *)constructEmptyMonster{
    return (Monster *)[self.dataController constructEmptyEntity:MONSTER_ENTITY_NAME];
}

@end
