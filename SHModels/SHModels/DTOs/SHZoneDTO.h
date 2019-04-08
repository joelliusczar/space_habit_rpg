//
//  SHZoneDTO.h
//  SHModels
//
//  Created by Joel Pridgen on 4/6/19.
//  Copyright © 2019 Joel Gillette. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "P_StoryItem.h"
#import "ZoneInfoDictionary.h"

@import CoreData;

NS_ASSUME_NONNULL_BEGIN

@interface ZoneDTO : NSObject<P_StoryItem>
+(instancetype)newWithZoneDict:(ZoneInfoDictionary*)zoneInfoDict;
@property (copy,nonatomic) NSManagedObjectID *objectID;
@property (nonatomic) BOOL isFront;
@property (nonatomic) int32_t lvl;
@property (nonatomic) int32_t maxMonsters;
@property (nonatomic) int32_t monstersKilled;
@property (nullable, nonatomic, copy) NSString *suffix;
@property (nonatomic) int64_t uniqueId;
@property (nullable, nonatomic, copy) NSString *zoneKey;
@property (nonatomic,strong) ZoneInfoDictionary *zoneInfoDict;
@end

NS_ASSUME_NONNULL_END
