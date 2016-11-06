//
//  Hero+CoreDataProperties.h
//  HabitRPG2
//
//  Created by Joel Pridgen on 11/5/16.
//  Copyright © 2016 Joel Pridgen. All rights reserved.
//

#import "Hero+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Hero (CoreDataProperties)

+ (NSFetchRequest<Hero *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSNumber *gold;
@property (nullable, nonatomic, copy) NSNumber *lvl;
@property (nullable, nonatomic, copy) NSNumber *maxHp;
@property (nullable, nonatomic, copy) NSNumber *maxXp;
@property (nullable, nonatomic, copy) NSNumber *nowHp;
@property (nullable, nonatomic, copy) NSNumber *nowXp;
@property (nullable, nonatomic, copy) NSString *shipName;

@end

NS_ASSUME_NONNULL_END
