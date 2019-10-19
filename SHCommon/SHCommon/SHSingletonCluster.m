//
//  SHSingletonCluster.m
//  HabitRPG2
//
//  Created by Joel Pridgen on 3/29/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import "SHSingletonCluster.h"
#import "SHResourceUtility.h"
#import "NSDate+DateHelper.h"
#import <SHGlobal/SHConstants.h>
#import "SHReportServiceCaller.h"


@implementation SHSingletonCluster

-(int)EnviromentNum{
	NSDictionary* environment = [[NSProcessInfo processInfo] environment];
	NSString* testEnabled = environment[@"IS_UNIT_TESTING"];
	NSString* betaEnabled = environment[@"IS_BETA"];
	int num = 0;
	if([testEnabled isEqualToString:@"YES"]){
		num |= SH_ENV_UTEST;
	}
	if([betaEnabled isEqualToString:@"YES"]){
		num |= SH_ENV_BETA;
	}
	return num;
}


@synthesize resourceUtility = _resourceUtility;
-(NSObject<SHResourceUtilityProtocol> *)resourceUtility{
	if(nil==_resourceUtility){
		_resourceUtility = [[SHResourceUtility alloc] init];
	}
	return _resourceUtility;
}

@synthesize reportCaller = _reportCaller;
-(NSObject<SHReportServiceCallerProtocol> *)reportCaller{
	if(nil==_reportCaller){
		_reportCaller = [SHReportServiceCaller new];
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
	static SHSingletonCluster *sharedInstance = nil;
	static dispatch_once_t _onceToken;
	dispatch_once(&_onceToken,^{
		sharedInstance = [[SHSingletonCluster alloc] initClass];
	});
	return sharedInstance;
}


@end
