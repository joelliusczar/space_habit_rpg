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
#import "StdLibWrapper.h"
#import "constants.h"


@implementation SingletonCluster

@synthesize EnviromentNum = _EnviromentNum;
-(int32_t)EnviromentNum{
    NSDictionary* environment = [[NSProcessInfo processInfo] environment];
    NSString* testEnabled = environment[@"IS_UNIT_TESTING"];
    if([testEnabled isEqualToString:@"YES"]){
        return ENV_UTEST;
    }
    return ENV_DEFAULT;
}

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

@synthesize stdLibWrapper = _stdLibWrapper;
-(NSObject<P_stdlibWrapper> *)stdLibWrapper{
    if(!_stdLibWrapper){
        _stdLibWrapper = [[StdLibWrapper alloc] init];
    }
    return _stdLibWrapper;
}

-(instancetype)initClass{
    if(self = [super init]){}
    return self;
}

-(instancetype)init{
    @throw [NSException exceptionWithName:@"Not designated initializer" reason:@"User [SingletonCluster getSharedInstance]" userInfo:nil];
    return nil;
}

+(instancetype)getSharedInstance{
    static SingletonCluster *sharedInstance = nil;
    static dispatch_once_t _onceToken;
    dispatch_once(&_onceToken,^{
        sharedInstance = [[SingletonCluster alloc] initClass];
    });
    return sharedInstance;
}



@end
