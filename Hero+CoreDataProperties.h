//
//  Hero+CoreDataProperties.h
//  HabitRPG2
//
//  Created by Joel Pridgen on 11/15/16.
//  Copyright © 2016 Joel Pridgen. All rights reserved.
//

#import "Hero+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Hero (CoreDataProperties)

+ (NSFetchRequest<Hero *> *)fetchRequest;

@property (nonatomic) double gold;
@property (nonatomic) int32_t lvl;
@property (nonatomic) int32_t maxHp;
@property (nonatomic) int32_t maxXp;
@property (nonatomic) int32_t nowHp;
@property (nonatomic) int32_t nowXp;
@property (nullable, nonatomic, copy) NSString *shipName;

@end

NS_ASSUME_NONNULL_END
