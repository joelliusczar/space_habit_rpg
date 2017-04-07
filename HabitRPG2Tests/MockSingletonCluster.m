//
//  MockSingletonCluster.m
//  HabitRPG2
//
//  Created by Joel Pridgen on 4/6/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SingletonCluster.h"
#import "MockDataController.h"
#import "MockResourceUtility.h"
#import "MockStdLibWrapper.h"


@implementation SingletonCluster
    
    @synthesize dataController = _dataController;
    -(NSObject<P_CoreData> *)dataController{
        if(!_dataController){
            _dataController = [[MockDataController alloc] initWithDBFileName:nil];
        }
        return _dataController;
    }
    
    @synthesize resourceUtility = _resourceUtility;
    -(NSObject<P_ResourceUtility> *)resourceUtility{
        if(!_resourceUtility){
            _resourceUtility = [[MockResourceUtility alloc] init];
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
    
    @synthesize stdLibWrapper = _stdLibWrapper;
    -(NSObject<P_stdlibWrapper> *)stdLibWrapper{
        if(!_stdLibWrapper){
            _stdLibWrapper = [[MockStdLibWrapper alloc] init];
        }
        return _stdLibWrapper;
    }
    
    +(instancetype)getSharedInstance{
        static SingletonCluster *sharedInstance = nil;
        if(!sharedInstance){
            sharedInstance = [[SingletonCluster alloc]init];
        }
        return sharedInstance;
    }
    
    
    
    @end
