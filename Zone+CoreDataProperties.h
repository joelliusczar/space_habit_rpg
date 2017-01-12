//
//  Zone+CoreDataProperties.h
//  HabitRPG2
//
//  Created by Joel Pridgen on 1/12/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import "Zone+CoreDataClass.h"
#import "Hero+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Zone (CoreDataProperties)

+ (NSFetchRequest<Zone *> *)fetchRequest;

@property (nonatomic) int32_t lvl;
@property (nonatomic) int32_t maxMonsters;
@property (nonatomic) int32_t monstersKilled;
@property (nonatomic) int32_t suffixNumber;
@property (nonatomic) int64_t uniqueId;
@property (nullable, nonatomic, copy) NSString *zoneKey;
@property (nullable, nonatomic, retain) Hero *hero_link;
@property (nullable, nonatomic, retain) NSSet<Zone *> *nextZones;
@property (nullable, nonatomic, retain) Zone *previousZone;
@property (nullable, nonatomic, retain) Zone *previousZoneInverse;

@end

@interface Zone (CoreDataGeneratedAccessors)

- (void)addNextZonesObject:(Zone *)value;
- (void)removeNextZonesObject:(Zone *)value;
- (void)addNextZones:(NSSet<Zone *> *)values;
- (void)removeNextZones:(NSSet<Zone *> *)values;

@end

NS_ASSUME_NONNULL_END
