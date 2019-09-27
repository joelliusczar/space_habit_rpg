//
//  SHDailyActiveDays.h
//  SHModels
//
//  Created by Joel Pridgen on 5/16/19.
//  Copyright © 2019 Joel Gillette. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SHRangeRateItem.h"
#import "SHListRateItemCollection.h"

typedef SHListRateItemCollection* _Nonnull (^shGetListRateCollection)(void);
typedef NSArray<SHRangeRateItem*>* _Nonnull (^shGetRangeRateArray)(void);

NS_ASSUME_NONNULL_BEGIN

@interface SHDailyActiveDays : NSObject

@property (strong,nonatomic, null_resettable) NSMutableDictionary *activeDaysDict;
@property (readonly,nonatomic) SHListRateItemCollection *monthlyActiveDays;
@property (readonly,nonatomic) SHListRateItemCollection *monthlyActiveDaysInv;
@property (readonly,nonatomic) SHListRateItemCollection *yearlyActiveDays;
@property (readonly,nonatomic) SHListRateItemCollection *yearlyActiveDaysInv;
@property (readonly,nonatomic) NSArray<SHRangeRateItem*> *weeklyActiveDays;
@property (readonly,nonatomic) NSArray<SHRangeRateItem*> *weeklyActiveDaysInv;

@property (assign,nonatomic) int32_t dailyIntervalSize;
@property (nonatomic) int32_t weeklyIntervalSize;
@property (assign,nonatomic) int32_t monthlyIntervalSize;
@property (assign,nonatomic) int32_t yearlyIntervalSize;
@property (assign,nonatomic) int32_t dailyIntervalSizeInv;
@property (assign,nonatomic) int32_t weeklyIntervalSizeInv;
@property (assign,nonatomic) int32_t monthlyIntervalSizeInv;
@property (assign,nonatomic) int32_t yearlyIntervalSizeInv;

@property (assign,nonatomic) NSUInteger weeklyDayStart;

@property (readonly,copy,nonatomic) shGetListRateCollection monthlyActiveDaysLazy;
@property (readonly,copy,nonatomic) shGetListRateCollection monthlyActiveDaysInvLazy;
@property (readonly,copy,nonatomic) shGetListRateCollection yearlyActiveDaysLazy;
@property (readonly,copy,nonatomic) shGetListRateCollection yearlyActiveDaysInvLazy;
@property (readonly,copy,nonatomic) shGetRangeRateArray weeklyActiveDaysLazy;
@property (readonly,copy,nonatomic) shGetRangeRateArray weeklyActiveDaysInvLazy;


-(instancetype)initWithActiveDaysJson:(nullable NSString*)activeDaysJson;
-(NSString*)activeDaysAsJson;
-(void)flipDayOfWeek:(NSUInteger)dayIdx forPolarity:(BOOL)isInverse;
@end

NS_ASSUME_NONNULL_END
