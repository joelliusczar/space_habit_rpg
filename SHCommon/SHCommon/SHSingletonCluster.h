//
//  SHSingletonCluster.h
//  HabitRPG2
//
//  Created by Joel Pridgen on 3/29/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//



#import <Foundation/Foundation.h>
#import "SHResourceUtilityProtocol.h"
#import "SHReportServiceCallerProtocol.h"


#define SharedGlobal [SHSingletonCluster getSharedInstance]
#define SHCONST [SHSingletonCluster getSharedInstance].constants


@interface SHSingletonCluster : NSObject
+(instancetype)getSharedInstance;
@property (strong,nonatomic) NSObject<SHResourceUtilityProtocol> *resourceUtility;
@property (strong,nonatomic) NSObject<SHReportServiceCallerProtocol> *reportCaller;
@property (nonatomic,readonly) int EnviromentNum;
@property (strong,nonatomic) NSCalendar *inUseCalendar;
@property (strong,nonatomic) NSLocale *inUseLocale;
@property (strong,nonatomic) NSMutableDictionary *bag;
@property (strong,nonatomic) NSBundle *bundle;
@end
