//
//  Settings+CoreDataProperties.h
//  HabitRPG2
//
//  Created by Joel Pridgen on 2/6/18.
//  Copyright © 2018 Joel Pridgen. All rights reserved.
//
//

#import "Settings+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Settings (CoreDataProperties)

+ (NSFetchRequest<Settings *> *)fetchRequest;

@property (nonatomic) BOOL allowReport;
@property (nullable, nonatomic, copy) NSDate *createDate;
@property (nonatomic) int32_t dayStart;
@property (nonatomic) float deathGoldPenalty;
@property (nonatomic) int32_t heroLvlPenalty;
@property (nonatomic) BOOL invertColors;
@property (nonatomic) BOOL isPasscodeProtected;
@property (nullable, nonatomic, copy) NSDate *lastCheckinDate;
@property (nullable, nonatomic, copy) NSDate *lastUpdateTime;
@property (nonatomic) BOOL permaDeath;
@property (nonatomic) int32_t reminderHour;
@property (nonatomic) BOOL storyModeisOn;
@property (nullable, nonatomic, copy) NSString *userId;
@property (nonatomic) int32_t zoneLvlPenalty;

@end

NS_ASSUME_NONNULL_END
