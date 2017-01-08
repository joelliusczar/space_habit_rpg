//
//  Habit+CoreDataProperties.h
//  HabitRPG2
//
//  Created by Joel Pridgen on 11/15/16.
//  Copyright © 2016 Joel Pridgen. All rights reserved.
//

#import "Habit+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Habit (CoreDataProperties)

+ (NSFetchRequest<Habit *> *)fetchRequest;

@property (nonatomic) int16_t difficulty;
@property (nonatomic) int32_t freeViolations;
@property (nullable, nonatomic, copy) NSString *frequencyCounts; //TODO: create a class for this and a get method
@property (nullable, nonatomic, copy) NSString *habitName;
@property (nonatomic) BOOL isActive;
@property (nonatomic) BOOL neglectPunishReward;
@property (nullable, nonatomic, copy) NSString *note;
@property (nonatomic) BOOL polarity;
@property (nonatomic) int16_t urgency;

@end

NS_ASSUME_NONNULL_END
