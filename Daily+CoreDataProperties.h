//
//  Daily+CoreDataProperties.h
//  HabitRPG2
//
//  Created by Joel Pridgen on 11/5/16.
//  Copyright © 2016 Joel Pridgen. All rights reserved.
//

#import "Daily+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Daily (CoreDataProperties)

+ (NSFetchRequest<Daily *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSNumber *activeDaysHash;
@property (nullable, nonatomic, copy) NSString *dailyName;
@property (nullable, nonatomic, copy) NSNumber *difficulty;
@property (nullable, nonatomic, copy) NSDate *lastActivationTime;
@property (nullable, nonatomic, copy) NSDate *nextDueTime;
@property (nullable, nonatomic, copy) NSString *note;
@property (nullable, nonatomic, copy) NSNumber *rate;
@property (nullable, nonatomic, copy) NSDate *rollbackActivationTime;
@property (nullable, nonatomic, copy) NSNumber *streakLength;
@property (nullable, nonatomic, copy) NSNumber *urgency;

@end

NS_ASSUME_NONNULL_END
