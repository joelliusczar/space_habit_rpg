//
//  SHConfigDTO.h
//  SHModels
//
//  Created by Joel Pridgen on 4/7/19.
//  Copyright © 2019 Joel Gillette. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SHCommon/SHObject.h>
@import CoreData;

NS_ASSUME_NONNULL_BEGIN

@interface SHConfigDTO : SHObject<NSCopying>
@property (strong,nonatomic) NSManagedObjectID *objectID;
@property (nonatomic) int32_t gameState;
@property (nonatomic) BOOL allowReport;
@property (nullable, nonatomic, copy) NSDate *createDateTime;
@property (nonatomic) int32_t dayStart;
@property (nonatomic) float deathGoldPenalty;
@property (nonatomic) int32_t heroLvlPenalty;
@property (nonatomic) BOOL invertColors;
@property (nonatomic) BOOL isPasscodeProtected;
@property (nullable, nonatomic, copy) NSDate *lastCheckinDateTime;
@property (nullable, nonatomic, copy) NSDate *lastUpdateDateTime;
@property (nonatomic) BOOL permaDeath;
@property (nonatomic) int32_t reminderHour;
@property (nonatomic) BOOL storyModeisOn;
@property (nullable, nonatomic, copy) NSString *userId;
@property (nonatomic) int32_t sectorLvlPenalty;

@end

NS_ASSUME_NONNULL_END
