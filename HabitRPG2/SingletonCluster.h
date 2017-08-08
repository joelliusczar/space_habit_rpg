//
//  SingletonCluster.h
//  HabitRPG2
//
//  Created by Joel Pridgen on 3/29/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//



#import <Foundation/Foundation.h>
#import "P_CoreData.h"
#import "P_ResourceUtility.h"
#import "ZoneInfoDictionary.h"
#import "MonsterInfoDictionary.h"
#import "P_stdlibWrapper.h"
#import "P_ReportServiceCaller.h"
#import "P_TimeUtilityStore.h"

#define SAVE_DATA() [[SingletonCluster getSharedInstance].dataController save]
#define SHData [SingletonCluster getSharedInstance].dataController
#define SharedGlobal [SingletonCluster getSharedInstance]
#define SHSettings [SingletonCluster getSharedInstance].dataController.userData.theSettings

@interface SingletonCluster : NSObject<P_TimeUtilityStore>
+(instancetype)getSharedInstance;
@property (strong,nonatomic) NSObject<P_CoreData> *dataController;
@property (strong,nonatomic) NSObject<P_ResourceUtility> *resourceUtility;
@property (strong,nonatomic) NSObject<P_ReportServiceCaller> *reportCaller;
@property (strong,nonatomic) ZoneInfoDictionary *zoneInfoDictionary;
@property (strong,nonatomic) MonsterInfoDictionary *monsterInfoDictionary;
@property (strong,nonatomic) NSObject<P_stdlibWrapper> *stdLibWrapper;
@property (nonatomic,readonly) int EnviromentNum;
@property (nonatomic,readonly) int gameState;
@property (strong,nonatomic) NSCalendar *inUseCalendar;
@property (strong,nonatomic) NSTimeZone *inUseTimeZone;
@property (strong,nonatomic) NSLocale *inUseLocale;
@end
