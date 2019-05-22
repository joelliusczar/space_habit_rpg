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

typedef SHListRateItemCollection*(^shGetListRateCollection)(void);
typedef NSArray<SHRangeRateItem*>*(^shGetRangeRateArray)(void);

NS_ASSUME_NONNULL_BEGIN

@interface SHDailyActiveDays : NSObject

@property (strong,nonatomic) NSMutableDictionary *activeDaysDict;
@property (strong,nonatomic) NSString *activeDaysJson;
@property (readonly,nonatomic) SHListRateItemCollection *monthlyActiveDays;
@property (readonly,nonatomic) SHListRateItemCollection *monthlyActiveDaysInv;
@property (readonly,nonatomic) SHListRateItemCollection *yearlyActiveDays;
@property (readonly,nonatomic) SHListRateItemCollection *yearlyActiveDaysInv;
@property (readonly,nonatomic) NSArray<SHRangeRateItem*> *weeklyActiveDays;
@property (readonly,nonatomic) NSArray<SHRangeRateItem*> *weeklyActiveDaysInv;

@property (readonly,copy,nonatomic) shGetListRateCollection monthlyActiveDaysLazy;
@property (readonly,copy,nonatomic) shGetListRateCollection monthlyActiveDaysInvLazy;
@property (readonly,copy,nonatomic) shGetListRateCollection yearlyActiveDaysLazy;
@property (readonly,copy,nonatomic) shGetListRateCollection yearlyActiveDaysInvLazy;
@property (readonly,copy,nonatomic) shGetRangeRateArray weeklyActiveDaysLazy;
@property (readonly,copy,nonatomic) shGetRangeRateArray weeklyActiveDaysInvLazy;

-(instancetype)initWithActiveDaysDict:(NSMutableDictionary*)activeDaysDict;
-(instancetype)initWithActiveDaysJson:(NSString*)activeDaysJson;
-(void)flipDayOfWeek:(NSUInteger)dayIdx forPolarity:(BOOL)isInverse andRate:(int32_t)rate;
@end

NS_ASSUME_NONNULL_END
