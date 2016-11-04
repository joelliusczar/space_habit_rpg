//
//  Habit+CoreDataProperties.h
//  HabitRPG2
//
//  Created by Joel Pridgen on 11/1/16.
//  Copyright © 2016 Joel Pridgen. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Habit.h"

NS_ASSUME_NONNULL_BEGIN

@interface Habit (CoreDataProperties)

@property (nonatomic) int16_t difficulty;
@property (nonatomic) int32_t freeViolations;
@property (nullable, nonatomic, retain) NSString *frequencyCounts;
@property (nullable, nonatomic, retain) NSString *habitName;
@property (nonatomic) BOOL neglectPunishReward;
@property (nullable, nonatomic, retain) NSString *note;
@property (nonatomic) BOOL polarity;
@property (nonatomic) int16_t urgency;

@end

NS_ASSUME_NONNULL_END
