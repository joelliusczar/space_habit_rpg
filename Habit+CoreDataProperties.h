//
//  Habit+CoreDataProperties.h
//  HabitRPG2
//
//  Created by Joel Pridgen on 11/5/16.
//  Copyright © 2016 Joel Pridgen. All rights reserved.
//

#import "Habit+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Habit (CoreDataProperties)

+ (NSFetchRequest<Habit *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSNumber *difficulty;
@property (nullable, nonatomic, copy) NSNumber *freeViolations;
@property (nullable, nonatomic, copy) NSString *frequencyCounts;
@property (nullable, nonatomic, copy) NSString *habitName;
@property (nullable, nonatomic, copy) NSNumber *neglectPunishReward;
@property (nullable, nonatomic, copy) NSString *note;
@property (nullable, nonatomic, copy) NSNumber *polarity;
@property (nullable, nonatomic, copy) NSNumber *urgency;

@end

NS_ASSUME_NONNULL_END
