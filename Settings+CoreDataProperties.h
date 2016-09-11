//
//  Settings+CoreDataProperties.h
//  HabitRPG2
//
//  Created by Joel Pridgen on 9/10/16.
//  Copyright © 2016 Joel Pridgen. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Settings.h"

NS_ASSUME_NONNULL_BEGIN

@interface Settings (CoreDataProperties)

@property (nullable, nonatomic, retain) NSNumber *reminderHour;
@property (nullable, nonatomic, retain) NSNumber *dayStart;
@property (nullable, nonatomic, retain) NSNumber *deathGoldPenalty;
@property (nullable, nonatomic, retain) NSNumber *heroLvlPenalty;
@property (nullable, nonatomic, retain) NSNumber *zoneLvlPenalty;
@property (nullable, nonatomic, retain) NSNumber *permaDeath;
@property (nullable, nonatomic, retain) NSNumber *storyModeisOn;
@property (nullable, nonatomic, retain) NSDate *lastCheckinTime;
@property (nullable, nonatomic, retain) NSDate *createDate;

@end

NS_ASSUME_NONNULL_END
