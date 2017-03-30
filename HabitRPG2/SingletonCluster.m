//
//  SingletonCluster.m
//  HabitRPG2
//
//  Created by Joel Pridgen on 3/29/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import "SingletonCluster.h"
#import "CoreDataStackController.h"
#import "ResourceUtility.h"


@implementation SingletonCluster

@synthesize dataController = _dataController;
-(NSObject<P_CoreData> *)dataController{
    if(!_dataController){
        _dataController = [[CoreDataStackController alloc] initWithDBFileName:nil];
    }
    return _dataController;
}

@synthesize resourceUtility = _resourceUtility;
-(NSObject<P_ResourceUtility> *)resourceUtility{
    if(!_resourceUtility){
        _resourceUtility = [[ResourceUtility alloc] init];
    }
    return _resourceUtility;
}

@synthesize zoneInfoDictionary = _zoneInfoDictionary;
-(ZoneInfoDictionary *)zoneInfoDictionary{
    if(!_zoneInfoDictionary){
        _zoneInfoDictionary = [ZoneInfoDictionary construct];
    }
    return _zoneInfoDictionary;
}

@synthesize monsterInfoDictionary = _monsterInfoDictionary;
-(MonsterInfoDictionary *)monsterInfoDictionary{
    if(!_monsterInfoDictionary){
        _monsterInfoDictionary = [MonsterInfoDictionary construct];
    }
    return _monsterInfoDictionary;
}

+(instancetype)getSharedInstance{
    static SingletonCluster *sharedInstance = nil;
    if(!sharedInstance){
        sharedInstance = [[SingletonCluster alloc]init];
    }
    return sharedInstance;
}



@end
