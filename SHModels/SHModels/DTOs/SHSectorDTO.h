//
//  SHSectorDTO.h
//  SHModels
//
//  Created by Joel Pridgen on 4/6/19.
//  Copyright © 2019 Joel Gillette. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SHStoryItemProtocol.h"
#import "SHSectorInfoDictionary.h"
#import <SHCommon/SHObject.h>

@import CoreData;

NS_ASSUME_NONNULL_BEGIN

@interface SHSectorDTO : SHObject<SHStoryItemProtocol,NSCopying>
+(instancetype)newWithSectorDict:(SHSectorInfoDictionary*)sectorInfoDict;
@property (readonly,nonatomic) NSMutableDictionary *mapable;
@property (copy,nonatomic) NSManagedObjectID *objectID;
@property (nonatomic) BOOL isFront;
@property (nonatomic) int32_t lvl;
@property (nonatomic) int32_t maxMonsters;
@property (nonatomic) int32_t monstersKilled;
@property (nullable, nonatomic, copy) NSString *suffix;
@property (nonatomic) int64_t uniqueId;
@property (nullable, nonatomic, copy) NSString *sectorKey;
@property (nonatomic,strong) SHSectorInfoDictionary *sectorInfoDict;
-(BOOL)shouldIgnoreProperty:(NSString *)propName;
@end

NS_ASSUME_NONNULL_END
