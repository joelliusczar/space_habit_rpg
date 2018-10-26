//
//  SingletonCluster+Entity.h
//  SHModels
//
//  Created by Joel Pridgen on 2/27/18.
//  Copyright © 2018 Joel Gillette. All rights reserved.
//

#import <SHCommon/SHCommon.h>
#import <SHData/SingletonCluster+Data.H>
#import "OnlyOneEntities.h"
#import "ZoneInfoDictionary.h"
#import "MonsterInfoDictionary.h"
#import "StoryItemDictionary.h"

#define SHSettings [SingletonCluster getSharedInstance].userData.theSettings


@interface SingletonCluster (Entity)
@property (nonatomic) OnlyOneEntities* userData;
@property (nonatomic) ZoneInfoDictionary* zoneInfoDictionary;
@property (nonatomic) MonsterInfoDictionary* monsterInfoDictionary;
@property (nonatomic) StoryItemDictionary* storyItemDictionary;
@end
