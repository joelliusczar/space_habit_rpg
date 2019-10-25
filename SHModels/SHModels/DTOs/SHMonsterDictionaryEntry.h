//
//  SHMonsterDictionaryEntry.h
//  SHModels
//
//  Created by Joel Pridgen on 4/6/19.
//  Copyright © 2019 Joel Gillette. All rights reserved.
//

@import Foundation;
#import "SHStoryItemProtocol.h"
@import SHCommon;
@import CoreData;


NS_ASSUME_NONNULL_BEGIN

@interface SHMonsterDictionaryEntry : SHObject<NSCopying>
-(instancetype)initWith:(NSString*)monsterKey withMonsterDict:(NSDictionary*)monInfoDict;
@property (strong,nonatomic) NSDictionary *monInfoDict;
@property (nonatomic,readonly) int32_t baseAttack;
@property (nonatomic,readonly) int32_t defense;
@property (nonatomic,readonly) int32_t baseXp;
@property (nonatomic,readonly) int32_t baseHp;
@property (nonatomic,readonly) float treasureDropRate;
@property (nonatomic,readonly) int32_t encounterWeight;
@property (readonly,nonatomic) NSString *synopsis;
@property (readonly,nonatomic) NSString *fullName;
@property (readonly,nonatomic) NSString *headline;
@property (nullable, nonatomic, copy) NSString *monsterKey;
@property (nonatomic) int32_t nowHp;
@property (readonly,nonatomic) NSMutableDictionary *mapable;
-(BOOL)shouldIgnoreProperty:(NSString *)propName;
@end

NS_ASSUME_NONNULL_END
