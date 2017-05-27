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

#define SAVE_DATA() [[SingletonCluster getSharedInstance].dataController save]
#define SHData [SingletonCluster getSharedInstance].dataController

@interface SingletonCluster : NSObject
+(instancetype)getSharedInstance;
@property (nonatomic,strong) NSObject<P_CoreData> *dataController;
@property (nonatomic,strong) NSObject<P_ResourceUtility> *resourceUtility;
@property (nonatomic,strong) ZoneInfoDictionary *zoneInfoDictionary;
@property (nonatomic,strong) MonsterInfoDictionary *monsterInfoDictionary;
@property (nonatomic,strong) NSObject<P_stdlibWrapper> *stdLibWrapper;
@property (nonatomic,readonly) int EnviromentNum;
@property (nonatomic,readonly) int gameState;
@end
