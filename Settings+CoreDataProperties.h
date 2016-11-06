//
//  Settings+CoreDataProperties.h
//  HabitRPG2
//
//  Created by Joel Pridgen on 11/5/16.
//  Copyright © 2016 Joel Pridgen. All rights reserved.
//

#import "Settings+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Settings (CoreDataProperties)

+ (NSFetchRequest<Settings *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSDate *createDate;
@property (nullable, nonatomic, copy) NSNumber *dayStart;
@property (nullable, nonatomic, copy) NSNumber *deathGoldPenalty;
@property (nullable, nonatomic, copy) NSNumber *heroLvlPenalty;
@property (nullable, nonatomic, copy) NSDate *lastCheckinTime;
@property (nullable, nonatomic, copy) NSNumber *permaDeath;
@property (nullable, nonatomic, copy) NSNumber *reminderHour;
@property (nullable, nonatomic, copy) NSNumber *storyModeisOn;
@property (nullable, nonatomic, copy) NSNumber *zoneLvlPenalty;

@end

NS_ASSUME_NONNULL_END
