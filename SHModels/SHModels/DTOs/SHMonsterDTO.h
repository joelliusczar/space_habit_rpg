//
//  SHMonsterDTO.h
//  SHModels
//
//  Created by Joel Pridgen on 4/6/19.
//  Copyright © 2019 Joel Gillette. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "P_StoryItem.h"
#import "MonsterInfoDictionary.h"

NS_ASSUME_NONNULL_BEGIN

@interface MonsterDTO : NSObject<P_StoryItem>
+(instancetype)newWithMonsterDict:(MonsterInfoDictionary*)monInfoDict;
@property (strong,nonatomic) MonsterInfoDictionary *monInfoDict;
@property (nonatomic,readonly) int32_t attack;
@property (nonatomic,readonly) int32_t defense;
@property (nonatomic,readonly) int32_t xp;
@property (nonatomic,readonly) int32_t maxHp;
@property (nonatomic,readonly) float treasureDropRate;
@property (nonatomic,readonly) int32_t encounterWeight;
@property (nonatomic) int32_t lvl;
@property (nullable, nonatomic, copy) NSString *monsterKey;
@property (nonatomic) int32_t nowHp;
@end

NS_ASSUME_NONNULL_END
