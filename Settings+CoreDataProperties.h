//
//  Settings+CoreDataProperties.h
//  HabitRPG2
//
//  Created by Joel Pridgen on 5/3/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import "Settings+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Settings (CoreDataProperties)

+ (NSFetchRequest<Settings *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSDate *createDate;
@property (nonatomic) int32_t dayStart;
@property (nonatomic) float deathGoldPenalty;
@property (nonatomic) int32_t heroLvlPenalty;
@property (nonatomic) BOOL isPasscodeProtected;
@property (nullable, nonatomic, copy) NSDate *lastCheckinTime;
@property (nonatomic) BOOL permaDeath;
@property (nonatomic) int32_t reminderHour;
@property (nonatomic) BOOL storyModeisOn;
@property (nonatomic) int32_t zoneLvlPenalty;
@property (nonatomic) BOOL invertColors;

@end

NS_ASSUME_NONNULL_END
