//
//  SingletonCluster.h
//  HabitRPG2
//
//  Created by Joel Pridgen on 3/29/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//



#import <Foundation/Foundation.h>
#import "P_ResourceUtility.h"
#import "P_ReportServiceCaller.h"
#import "P_UtilityStore.h"
#import <SHGlobal/FlexibleConstants.h>


#define SharedGlobal [SingletonCluster getSharedInstance]
#define SHCONST [SingletonCluster getSharedInstance].constants

@interface SingletonCluster : NSObject<P_UtilityStore>
+(instancetype)getSharedInstance;
@property (strong,nonatomic) NSObject<P_ResourceUtility> *resourceUtility;
@property (strong,nonatomic) NSObject<P_ReportServiceCaller> *reportCaller;
@property (nonatomic,readonly) int EnviromentNum;
@property (strong,nonatomic) NSCalendar *inUseCalendar;
@property (strong,nonatomic) NSTimeZone *inUseTimeZone;
@property (strong,nonatomic) NSLocale *inUseLocale;
@property (strong,nonatomic) FlexibleConstants *constants;
@property (strong,nonatomic) NSMutableDictionary *bag;
@property (strong,nonatomic) NSBundle *bundle;
@end
