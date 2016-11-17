//
//  Zone+CoreDataProperties.h
//  HabitRPG2
//
//  Created by Joel Pridgen on 11/15/16.
//  Copyright © 2016 Joel Pridgen. All rights reserved.
//

#import "Zone+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Zone (CoreDataProperties)

+ (NSFetchRequest<Zone *> *)fetchRequest;

@property (nonatomic) BOOL isCurrentZone;
@property (nonatomic) int32_t lvl;
@property (nonatomic) int32_t maxMonsters;
@property (nonatomic) int32_t monstersKilled;
@property (nonatomic) int64_t previousZonePK;
@property (nonatomic) int32_t suffixNumber;
@property (nonatomic) int64_t uniqueId;
@property (nullable, nonatomic, copy) NSString *zoneKey;

@end

NS_ASSUME_NONNULL_END
