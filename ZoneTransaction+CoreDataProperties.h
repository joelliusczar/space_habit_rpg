//
//  ZoneTransaction+CoreDataProperties.h
//  HabitRPG2
//
//  Created by Joel Pridgen on 5/3/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import "ZoneTransaction+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface ZoneTransaction (CoreDataProperties)

+ (NSFetchRequest<ZoneTransaction *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSDate *endDate;
@property (nonatomic) int32_t lvl;
@property (nonatomic) int32_t maxMonsters;
@property (nonatomic) int64_t prevUniqueId;
@property (nullable, nonatomic, copy) NSDate *startDate;
@property (nullable, nonatomic, copy) NSString *suffix;
@property (nonatomic) int64_t uniqueId;
@property (nullable, nonatomic, copy) NSString *zoneKey;
@property (nullable, nonatomic, copy) NSString *misc;

@end

NS_ASSUME_NONNULL_END
