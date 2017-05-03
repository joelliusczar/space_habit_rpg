//
//  HabitTransaction+CoreDataProperties.h
//  HabitRPG2
//
//  Created by Joel Pridgen on 5/2/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import "HabitTransaction+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface HabitTransaction (CoreDataProperties)

+ (NSFetchRequest<HabitTransaction *> *)fetchRequest;

@property (nonatomic) int32_t action;
@property (nullable, nonatomic, copy) NSDate *activationTime;
@property (nullable, nonatomic, retain) Habit *transaction_habit;

@end

NS_ASSUME_NONNULL_END
