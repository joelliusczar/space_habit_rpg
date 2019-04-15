//
//  SHDailyDTO.h
//  SHModels
//
//  Created by Joel Pridgen on 4/13/19.
//  Copyright © 2019 Joel Gillette. All rights reserved.
//

#import <SHCommon/SHCommon.h>
@import CoreData;

NS_ASSUME_NONNULL_BEGIN

@interface SHDailyDTO : SHObject<NSCopying>
@property (copy,nonatomic) NSManagedObjectID *objectID;
@property (nullable, nonatomic, copy) NSString *activeDays;
@property (nonatomic) int32_t customUserOrder;
@property (nullable, nonatomic, copy) NSDate *cycleStartTime;
@property (nullable, nonatomic, copy) NSString *dailyName;
@property (nonatomic) int32_t difficulty;
@property (nonatomic) BOOL isActive;
@property (nullable, nonatomic, copy) NSDate *lastActivationTime;
@property (nullable, nonatomic, copy) NSDate *lastUpdateTime;
@property (nullable, nonatomic, copy) NSString *note;
@property (nonatomic) int32_t rate;
@property (nonatomic) int32_t rateType;
@property (nullable, nonatomic, copy) NSDate *rollbackActivationTime;
@property (nonatomic) int32_t streakLength;
@property (nonatomic) int32_t urgency;
@property (nullable, nonatomic, copy) NSDate *lastDueTime;
@end

NS_ASSUME_NONNULL_END
