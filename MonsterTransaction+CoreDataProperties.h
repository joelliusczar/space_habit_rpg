//
//  MonsterTransaction+CoreDataProperties.h
//  HabitRPG2
//
//  Created by Joel Pridgen on 5/3/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import "MonsterTransaction+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface MonsterTransaction (CoreDataProperties)

+ (NSFetchRequest<MonsterTransaction *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSDate *endDate;
@property (nonatomic) int32_t lvl;
@property (nullable, nonatomic, copy) NSString *monsterKey;
@property (nullable, nonatomic, copy) NSDate *startDate;
@property (nullable, nonatomic, copy) NSString *misc;

@end

NS_ASSUME_NONNULL_END
