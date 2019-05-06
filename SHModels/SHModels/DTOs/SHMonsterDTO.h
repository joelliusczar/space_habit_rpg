//
//  SHMonsterDTO.h
//  SHModels
//
//  Created by Joel Pridgen on 4/6/19.
//  Copyright © 2019 Joel Gillette. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SHStoryItemProtocol.h"
#import "SHMonsterInfoDictionary.h"
#import <SHCommon/SHObject.h>
@import CoreData;

NS_ASSUME_NONNULL_BEGIN

@interface SHMonsterDTO : SHObject<SHStoryItemProtocol,NSCopying>
+(instancetype)newWithMonsterDict:(SHMonsterInfoDictionary*)monInfoDict;
@property (strong,nonatomic) SHMonsterInfoDictionary *monInfoDict;
@property (strong,nonatomic) NSManagedObjectID *objectID;
@property (nonatomic,readonly) int32_t attack;
@property (nonatomic,readonly) int32_t defense;
@property (nonatomic,readonly) int32_t xp;
@property (nonatomic,readonly) int32_t maxHp;
@property (nonatomic,readonly) float treasureDropRate;
@property (nonatomic,readonly) int32_t encounterWeight;
@property (nonatomic) int32_t lvl;
@property (nullable, nonatomic, copy) NSString *monsterKey;
@property (nonatomic) int32_t nowHp;
@property (readonly,nonatomic) NSMutableDictionary *mapable;
@end

NS_ASSUME_NONNULL_END
