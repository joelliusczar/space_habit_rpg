//
//  SHDailyDTO.h
//  SHModels
//
//  Created by Joel Pridgen on 4/13/19.
//  Copyright © 2019 Joel Gillette. All rights reserved.
//

#import <SHCommon/SHCommon.h>
#import "SHModelError.h"
#import "SHListRateItemCollection.h"
#import "SHRangeRateItem.h"
@import CoreData;

NS_ASSUME_NONNULL_BEGIN

@interface SHDailyDTO : SHObject<NSCopying>

@property (nonatomic) BOOL isTouched;

@property (strong,nonatomic) NSManagedObjectID *objectID;
@property (readonly,nonatomic) SHListRateItemCollection *monthlyActiveDays;
@property (readonly,nonatomic) SHListRateItemCollection *monthlyActiveDaysInv;
@property (readonly,nonatomic) SHListRateItemCollection *yearlyActiveDays;
@property (readonly,nonatomic) SHListRateItemCollection *yearlyActiveDaysInv;
@property (readonly,nonatomic) NSArray<SHRangeRateItem*> *weeklyActiveDays;
@property (readonly,nonatomic) NSArray<SHRangeRateItem*> *weeklyActiveDaysInv;
@property (readonly,nonatomic) NSUInteger daysUntilDue;
@property (strong,nonatomic) NSMutableDictionary *activeDaysDict;
@property (nullable, nonatomic, copy) NSString *activeDays;
@property (nullable, nonatomic, copy) NSDate *activeFromDate;
@property (nullable, nonatomic, copy) NSDate *activeToDate;
@property (nonatomic) int32_t customUserOrder;
@property (nonatomic) int32_t cycleStartTime;
@property (nullable, nonatomic, copy) NSString *dailyName;
@property (nonatomic) int32_t difficulty;
@property (nonatomic) BOOL isActive;
@property (nullable, nonatomic, copy) NSDate *lastActivationDateTime;
@property (nullable, nonatomic, copy) NSDate *lastDueDateTime;
@property (nullable, nonatomic, copy) NSDate *lastUpdateDateTime;
@property (nullable, nonatomic, copy) NSString *note;
@property (nonatomic) int32_t rate;
@property (nonatomic) int32_t rateType;
@property (nullable, nonatomic, copy) NSDate *rollbackActivationDateTime;
@property (nonatomic) int32_t streakLength;
@property (nonatomic) int32_t urgency;


@property (nonatomic) NSUInteger dayStart;

-(void)setupDefaults;
-(void)flipDayOfWeek:(NSUInteger)dayIdx;

@end

NS_ASSUME_NONNULL_END
