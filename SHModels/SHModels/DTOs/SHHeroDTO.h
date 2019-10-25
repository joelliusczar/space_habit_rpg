//
//  SHHeroDTO.h
//  SHModels
//
//  Created by Joel Pridgen on 4/6/19.
//  Copyright © 2019 Joel Gillette. All rights reserved.
//

@import Foundation;
@import SHCommon;
@import CoreData;

NS_ASSUME_NONNULL_BEGIN

@interface SHHeroDTO : SHObject<NSCopying>
@property (strong,nonatomic) NSManagedObjectID *objectID;
@property (nonatomic) double gold;
@property (nonatomic) int32_t lvl;
@property (nonatomic) int32_t maxHp;
@property (nonatomic) int32_t maxXp;
@property (nonatomic) int32_t nowHp;
@property (nonatomic) int32_t nowXp;
@property (nullable, nonatomic, copy) NSString *shipName;
@end

NS_ASSUME_NONNULL_END
