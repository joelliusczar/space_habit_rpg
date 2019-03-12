//
//  SingletonCluster.m
//  HabitRPG2
//
//  Created by Joel Pridgen on 3/29/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import "SingletonCluster.h"
#import "ResourceUtility.h"
#import "NSDate+DateHelper.h"
#import <SHGlobal/constants.h>
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

/*
 I'm specifically using the gregorian calendar here because I do not to deal
 with any possible bugs that might result from using a calendar that might not have
 seven days
 */
@synthesize inUseCalendar = _inUseCalendar;
-(NSCalendar *)inUseCalendar{
  
    if(nil==_inUseCalendar){
        _inUseCalendar =
        [NSCalendar calendarWithIdentifier:NSCalendarIdentifierGregorian];
        _inUseCalendar.locale = self.inUseLocale;
        _inUseCalendar.timeZone = NSTimeZone.defaultTimeZone;
    }
    return _inUseCalendar;
}


-(NSLocale *)inUseLocale{
    if(nil==_inUseLocale){
        _inUseLocale = NSLocale.currentLocale;
    }
    return _inUseLocale;
}


-(FlexibleConstants *)constants{
    if(nil==_constants){
        _constants = [[FlexibleConstants alloc] init];
    }
    return _constants;
}


-(NSMutableDictionary*)bag{
    if(nil==_bag){
        _bag = [NSMutableDictionary dictionary];
    }
    return _bag;
}

-(NSBundle *)bundle{
    if(!_bundle){
        _bundle = [NSBundle mainBundle];
    }
    return _bundle;
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
