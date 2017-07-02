//
//  Monster+CoreDataProperties.h
//  HabitRPG2
//
//  Created by Joel Pridgen on 7/2/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import "Monster+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Monster (CoreDataProperties)

+ (NSFetchRequest<Monster *> *)fetchRequest;

@property (nonatomic) int32_t lvl;
@property (nullable, nonatomic, copy) NSString *monsterKey;
@property (nonatomic) int32_t nowHp;

@end

NS_ASSUME_NONNULL_END
