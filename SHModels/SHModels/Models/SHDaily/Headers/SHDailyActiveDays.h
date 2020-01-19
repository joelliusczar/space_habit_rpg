//
//  SHDailyActiveDays.h
//  SHModels
//
//  Created by Joel Pridgen on 5/16/19.
//  Copyright © 2019 Joel Gillette. All rights reserved.
//

#import "SHWeeklyRateItem.h"
#import "SHMonthlyYearlyRateItemList.h"
#import "SHWeeklyRateItemList.h"
#import "SHDailyRateItem.h"
#import "SHIntervalItemFormat.h"
@import Foundation;

typedef SHMonthlyYearlyRateItemList* _Nonnull (^shGetListRateCollection)(void);
typedef SHWeeklyRateItemList* _Nonnull (^shGetRangeRateArray)(void);

NS_ASSUME_NONNULL_BEGIN

@interface SHDailyActiveDays : NSObject

@property (strong, nonatomic, null_resettable) NSMutableDictionary *activeDaysDict;
@property (readonly, nonatomic) SHMonthlyYearlyRateItemList *monthlyActiveDays;
@property (readonly, nonatomic) SHMonthlyYearlyRateItemList *monthlyActiveDaysInv;
@property (readonly, nonatomic) SHMonthlyYearlyRateItemList *yearlyActiveDays;
@property (readonly, nonatomic) SHMonthlyYearlyRateItemList *yearlyActiveDaysInv;
@property (readonly, nonatomic) SHWeeklyRateItemList *weeklyActiveDays;
@property (readonly, nonatomic) SHWeeklyRateItemList *weeklyActiveDaysInv;
@property (readonly, nonatomic) SHDailyRateItem *dailyRateItem;
@property (readonly, nonatomic) SHDailyRateItem *dailyRateItemInv;


-(instancetype)initWithActiveDaysJson:(nullable NSString*)activeDaysJson;
-(NSString*)activeDaysAsJson;
-(nullable SHIntervalItemFormat *)selectRateItemCollection:(SHRateType)rateType;
@end

NS_ASSUME_NONNULL_END
