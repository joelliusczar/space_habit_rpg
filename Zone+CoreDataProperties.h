//
//  Zone+CoreDataProperties.h
//  HabitRPG2
//
//  Created by Joel Pridgen on 11/1/16.
//  Copyright © 2016 Joel Pridgen. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Zone.h"

NS_ASSUME_NONNULL_BEGIN

@interface Zone (CoreDataProperties)

@property (nonatomic) BOOL isCurrentZone;
@property (nonatomic) int32_t lvl;
@property (nonatomic) int32_t maxMonsters;
@property (nonatomic) int32_t monstersKilled;
@property (nonatomic) int32_t previousZonePK;
@property (nonatomic) int32_t suffixNumber;
@property (nullable, nonatomic, retain) NSString *zoneKey;
@property (nullable, nonatomic, retain) NSString *uniqueId;

@end

NS_ASSUME_NONNULL_END
