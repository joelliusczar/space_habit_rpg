//
//  DailySubTask+CoreDataProperties.h
//  HabitRPG2
//
//  Created by Joel Pridgen on 6/17/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import "DailySubTask+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface DailySubTask (CoreDataProperties)

+ (NSFetchRequest<DailySubTask *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *dailySubTaskName;
@property (nonatomic) int32_t activeDaysHash;
@property (nonatomic) int32_t difficulty;
@property (nonatomic) int32_t urgency;
@property (nullable, nonatomic, copy) NSDate *lastActivationTime;
@property (nonatomic) int32_t rate;
@property (nullable, nonatomic, retain) Daily *subtask_daily;

@end

NS_ASSUME_NONNULL_END
