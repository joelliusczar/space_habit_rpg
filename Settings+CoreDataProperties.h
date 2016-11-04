//
//  Settings+CoreDataProperties.h
//  HabitRPG2
//
//  Created by Joel Pridgen on 11/1/16.
//  Copyright © 2016 Joel Pridgen. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Settings.h"

NS_ASSUME_NONNULL_BEGIN

@interface Settings (CoreDataProperties)

@property (nonatomic) NSTimeInterval createDate;
@property (nonatomic) int16_t dayStart;
@property (nonatomic) float deathGoldPenalty;
@property (nonatomic) int16_t heroLvlPenalty;
@property (nonatomic) NSTimeInterval lastCheckinTime;
@property (nonatomic) BOOL permaDeath;
@property (nonatomic) int16_t reminderHour;
@property (nonatomic) BOOL storyModeisOn;
@property (nonatomic) int16_t zoneLvlPenalty;

@end

NS_ASSUME_NONNULL_END
