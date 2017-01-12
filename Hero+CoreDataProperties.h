//
//  Hero+CoreDataProperties.h
//  HabitRPG2
//
//  Created by Joel Pridgen on 1/8/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import "Hero+CoreDataClass.h"
#import "Zone+CoreDataClass.h"


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
@property (nullable, nonatomic, retain) Zone *zone_link;

@end

NS_ASSUME_NONNULL_END
