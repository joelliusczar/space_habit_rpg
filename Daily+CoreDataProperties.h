//
//  Daily+CoreDataProperties.h
//  HabitRPG2
//
//  Created by Joel Pridgen on 6/4/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import "Daily+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Daily (CoreDataProperties)

+ (NSFetchRequest<Daily *> *)fetchRequest;

@property (nonatomic) int32_t activeDaysHash;
@property (nullable, nonatomic, copy) NSString *dailyName;
@property (nonatomic) int32_t difficulty;
@property (nonatomic) BOOL isActive;
@property (nullable, nonatomic, copy) NSDate *lastActivationTime;
@property (nullable, nonatomic, copy) NSDate *nextDueTime;
@property (nullable, nonatomic, copy) NSString *note;
@property (nonatomic) int32_t rate;
@property (nullable, nonatomic, copy) NSDate *rollbackActivationTime;
@property (nonatomic) int32_t streakLength;
@property (nonatomic) int32_t urgency;
@property (nonatomic) int32_t customUserOrder;

@end

NS_ASSUME_NONNULL_END
