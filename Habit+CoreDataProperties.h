//
//  Habit+CoreDataProperties.h
//  HabitRPG2
//
//  Created by Joel Pridgen on 9/10/16.
//  Copyright © 2016 Joel Pridgen. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Habit.h"

NS_ASSUME_NONNULL_BEGIN

@interface Habit (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *habitName;
@property (nullable, nonatomic, retain) NSString *note;
@property (nullable, nonatomic, retain) NSNumber *polarity;
@property (nullable, nonatomic, retain) NSNumber *urgency;
@property (nullable, nonatomic, retain) NSNumber *difficulty;
@property (nullable, nonatomic, retain) NSNumber *freeViolations;
@property (nullable, nonatomic, retain) NSNumber *neglectPunishReward;
@property (nullable, nonatomic, retain) NSString *frequencyCounts;

@end

NS_ASSUME_NONNULL_END
