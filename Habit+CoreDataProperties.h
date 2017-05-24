//
//  Habit+CoreDataProperties.h
//  HabitRPG2
//
//  Created by Joel Pridgen on 5/23/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import "Habit+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Habit (CoreDataProperties)

+ (NSFetchRequest<Habit *> *)fetchRequest;

@property (nonatomic) int32_t difficulty;
@property (nonatomic) int32_t freeViolations;
@property (nullable, nonatomic, copy) NSString *frequencyCounts;
@property (nullable, nonatomic, copy) NSString *habitName;
@property (nonatomic) BOOL isActive;
@property (nonatomic) BOOL isGood;
@property (nonatomic) BOOL neglectPunishReward;
@property (nullable, nonatomic, copy) NSString *note;
@property (nonatomic) int32_t urgency;

@end

NS_ASSUME_NONNULL_END
