//
//  Settings+CoreDataProperties.h
//  HabitRPG2
//
//  Created by Joel Pridgen on 11/15/16.
//  Copyright © 2016 Joel Pridgen. All rights reserved.
//

#import "Settings+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Settings (CoreDataProperties)

+ (NSFetchRequest<Settings *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSDate *createDate;
@property (nonatomic) int16_t dayStart;
@property (nonatomic) float deathGoldPenalty;
@property (nonatomic) int16_t heroLvlPenalty;
@property (nullable, nonatomic, copy) NSDate *lastCheckinTime;
@property (nonatomic) BOOL permaDeath;
@property (nonatomic) int16_t reminderHour;
@property (nonatomic) BOOL storyModeisOn;
@property (nonatomic) int16_t zoneLvlPenalty;

@end

NS_ASSUME_NONNULL_END
