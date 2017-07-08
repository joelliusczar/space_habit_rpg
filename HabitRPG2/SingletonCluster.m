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
#import "ReportServiceCaller.h"


@implementation SingletonCluster

-(int)EnviromentNum{
    NSDictionary* environment = [[NSProcessInfo processInfo] environment];
    NSString* testEnabled = environment[@"IS_UNIT_TESTING"];
    NSString* betaEnabled = environment[@"IS_BETA"];
    int num = 0;
    if([testEnabled isEqualToString:@"YES"]){
        num |= ENV_UTEST;
    }
    if([betaEnabled isEqualToString:@"YES"]){
        num |= ENV_BETA;
    }
    return num;
}

@synthesize dataController = _dataController;
-(NSObject<P_CoreData> *)dataController{
    if(nil==_dataController){
        _dataController = [CoreDataStackController new];
    }
    return _dataController;
}


@synthesize resourceUtility = _resourceUtility;
-(NSObject<P_ResourceUtility> *)resourceUtility{
    if(nil==_resourceUtility){
        _resourceUtility = [[ResourceUtility alloc] init];
    }
    return _resourceUtility;
}

@synthesize reportCaller = _reportCaller;
-(NSObject<P_ReportServiceCaller> *)reportCaller{
    if(nil==_reportCaller){
        _reportCaller = [ReportServiceCaller new];
    }
    return _reportCaller;
}

@synthesize zoneInfoDictionary = _zoneInfoDictionary;
-(ZoneInfoDictionary *)zoneInfoDictionary{
    if(nil==_zoneInfoDictionary){
        _zoneInfoDictionary = [ZoneInfoDictionary construct];
    }
    return _zoneInfoDictionary;
}

@synthesize monsterInfoDictionary = _monsterInfoDictionary;
-(MonsterInfoDictionary *)monsterInfoDictionary{
    if(nil==_monsterInfoDictionary){
        _monsterInfoDictionary = [MonsterInfoDictionary construct];
    }
    return _monsterInfoDictionary;
}

@synthesize stdLibWrapper = _stdLibWrapper;
-(NSObject<P_stdlibWrapper> *)stdLibWrapper{
    if(nil==_stdLibWrapper){
        _stdLibWrapper = [[StdLibWrapper alloc] init];
    }
    return _stdLibWrapper;
}

-(int)gameState{
    return [SingletonCluster getSharedInstance]
    .dataController.userData.theDataInfo.gameState;
}

@synthesize inUseCalendar = _inUseCalendar;
-(NSCalendar *)inUseCalendar{
    if(nil==_inUseCalendar){
        _inUseCalendar =
        [NSCalendar calendarWithIdentifier:NSCalendarIdentifierGregorian];
    }
    return _inUseCalendar;
}

@synthesize inUseTimeZone = _inUseTimeZone;
-(NSTimeZone *)inUseTimeZone{
    if(nil==_inUseTimeZone){
        _inUseTimeZone = NSTimeZone.systemTimeZone;
    }
    return _inUseTimeZone;
}

-(NSLocale *)inUseLocale{
    if(nil==_inUseLocale){
        _inUseLocale = NSLocale.autoupdatingCurrentLocale;
    }
    return _inUseLocale;
}

-(instancetype)initClass{
    if(self = [super init]){}
    return self;
}

-(instancetype)init{
    @throw [NSException
            exceptionWithName:@"Not designated initializer"
            reason:@"User [SingletonCluster getSharedInstance]" userInfo:nil];
    
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
