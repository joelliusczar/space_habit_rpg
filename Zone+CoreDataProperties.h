//
//  Zone+CoreDataProperties.h
//  HabitRPG2
//
//  Created by Joel Pridgen on 11/5/16.
//  Copyright © 2016 Joel Pridgen. All rights reserved.
//

#import "Zone+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Zone (CoreDataProperties)

+ (NSFetchRequest<Zone *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSNumber *isCurrentZone;
@property (nullable, nonatomic, copy) NSNumber *lvl;
@property (nullable, nonatomic, copy) NSNumber *maxMonsters;
@property (nullable, nonatomic, copy) NSNumber *monstersKilled;
@property (nullable, nonatomic, copy) NSNumber *previousZonePK;
@property (nullable, nonatomic, copy) NSNumber *suffixNumber;
@property (nullable, nonatomic, copy) NSNumber *uniqueId;
@property (nullable, nonatomic, copy) NSString *zoneKey;

@end

NS_ASSUME_NONNULL_END
