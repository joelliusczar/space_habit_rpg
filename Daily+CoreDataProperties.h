//
//  Daily+CoreDataProperties.h
//  HabitRPG2
//
//  Created by Joel Pridgen on 9/12/16.
//  Copyright © 2016 Joel Pridgen. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Daily.h"

NS_ASSUME_NONNULL_BEGIN

@interface Daily (CoreDataProperties)

@property (nullable, nonatomic, retain) NSNumber *activeDaysHash;
@property (nullable, nonatomic, retain) NSString *dailyName;
@property (nullable, nonatomic, retain) NSNumber *difficulty;
@property (nullable, nonatomic, retain) NSDate *lastActivationTime;
@property (nullable, nonatomic, retain) NSString *note;
@property (nullable, nonatomic, retain) NSNumber *rate;
@property (nullable, nonatomic, retain) NSNumber *streakLength;
@property (nullable, nonatomic, retain) NSNumber *urgency;
@property (nullable, nonatomic, retain) NSDate *nextDueTime;

@end

NS_ASSUME_NONNULL_END
