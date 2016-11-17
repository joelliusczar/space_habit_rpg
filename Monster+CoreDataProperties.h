//
//  Monster+CoreDataProperties.h
//  HabitRPG2
//
//  Created by Joel Pridgen on 11/15/16.
//  Copyright © 2016 Joel Pridgen. All rights reserved.
//

#import "Monster+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Monster (CoreDataProperties)

+ (NSFetchRequest<Monster *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *about;
@property (nonatomic) int32_t baseXpReward;
@property (nonatomic) int32_t lvl;
@property (nonatomic) int32_t maxHp;
@property (nullable, nonatomic, copy) NSString *monsterName;
@property (nonatomic) int32_t nowHp;

@end

NS_ASSUME_NONNULL_END
