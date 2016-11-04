//
//  Daily+CoreDataProperties.h
//  HabitRPG2
//
//  Created by Joel Pridgen on 11/1/16.
//  Copyright © 2016 Joel Pridgen. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Daily.h"

NS_ASSUME_NONNULL_BEGIN

@interface Daily (CoreDataProperties)

@property (nonatomic) int32_t activeDaysHash;
@property (nullable, nonatomic, retain) NSString *dailyName;
@property (nonatomic) int16_t difficulty;
@property (nonatomic) NSTimeInterval lastActivationTime;
@property (nonatomic) NSTimeInterval nextDueTime;
@property (nullable, nonatomic, retain) NSString *note;
@property (nonatomic) int32_t rate;
@property (nonatomic) NSTimeInterval rollbackActivationTime;
@property (nonatomic) int32_t streakLength;
@property (nonatomic) int16_t urgency;

@end

NS_ASSUME_NONNULL_END
