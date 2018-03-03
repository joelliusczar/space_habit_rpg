//
//  SingletonCluster+Entity.m
//  SHModels
//
//  Created by Joel Pridgen on 2/27/18.
//  Copyright © 2018 Joel Gillette. All rights reserved.
//

#import "SingletonCluster+Entity.h"
#import <SHCommon/NSMutableDictionary+Helper.h>
#import "ZoneInfoDictionary.h"

@implementation SingletonCluster (Entity)

-(OnlyOneEntities *)userData{
    return [self.bag getWithKey:@"entity" OrCreateFromBlock:^id(){
        return [[OnlyOneEntities alloc] initWithDataController:self.dataController];
    }];
}


-(void)setUserData:(OnlyOneEntities *)userData{
    self.bag[@"entity"] = userData;
}


-(ZoneInfoDictionary *)zoneInfoDictionary{
    return [self.bag getWithKey:@"zoneDict" OrCreateFromBlock:^id(){
        return [ZoneInfoDictionary new];
    }];
}


-(void)setZoneInfoDictionary:(ZoneInfoDictionary *)zoneInfoDictionary{
    self.bag[@"zoneDict"] = zoneInfoDictionary;
}


-(MonsterInfoDictionary *)monsterInfoDictionary{
    return [self.bag getWithKey:@"monsterDict" OrCreateFromBlock:^id(){
        return [MonsterInfoDictionary new];
    }];
}


-(void)setMonsterInfoDictionary:(MonsterInfoDictionary *)monsterInfoDictionary{
    self.bag[@"monsterDict"] = monsterInfoDictionary;
}

@end
