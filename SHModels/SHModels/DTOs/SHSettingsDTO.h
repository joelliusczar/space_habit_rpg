//
//  SHSettingsDTO.h
//  SHModels
//
//  Created by Joel Pridgen on 4/7/19.
//  Copyright © 2019 Joel Gillette. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SHCommon/SHObject.h>
@import CoreData;

NS_ASSUME_NONNULL_BEGIN

@interface SHSettingsDTO : SHObject<NSCopying>
@property (copy,nonatomic) NSManagedObjectID *objectID;
@property (nonatomic) int32_t gameState;
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
