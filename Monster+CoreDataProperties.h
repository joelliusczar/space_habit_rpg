//
//  Monster+CoreDataProperties.h
//  HabitRPG2
//
//  Created by Joel Pridgen on 11/5/16.
//  Copyright © 2016 Joel Pridgen. All rights reserved.
//

#import "Monster+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Monster (CoreDataProperties)

+ (NSFetchRequest<Monster *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *about;
@property (nullable, nonatomic, copy) NSNumber *baseXpReward;
@property (nullable, nonatomic, copy) NSNumber *lvl;
@property (nullable, nonatomic, copy) NSNumber *maxHp;
@property (nullable, nonatomic, copy) NSString *monsterName;
@property (nullable, nonatomic, copy) NSNumber *nowHp;

@end

NS_ASSUME_NONNULL_END
