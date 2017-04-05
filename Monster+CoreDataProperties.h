//
//  Monster+CoreDataProperties.h
//  HabitRPG2
//
//  Created by Joel Pridgen on 4/4/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import "Monster+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Monster (CoreDataProperties)

+ (NSFetchRequest<Monster *> *)fetchRequest;

@property (nonatomic) int32_t lvl;
@property (nonatomic) int32_t maxHp;
@property (nonatomic) int32_t nowHp;
@property (nullable, nonatomic, copy) NSString *monsterKey;

@end

NS_ASSUME_NONNULL_END
