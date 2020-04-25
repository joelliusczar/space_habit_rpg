//
//  SHDailyNextWeeklyDueDateCalculator.h
//  SHModels
//
//  Created by Joel Pridgen on 4/12/20.
//  Copyright © 2020 Joel Gillette. All rights reserved.
//

#import "SHDailyNextDueDateCalculator.h"
#import "SHWeekIntervalItemList.h"
@import SHDatetime;

NS_ASSUME_NONNULL_BEGIN

@interface SHDailyNextWeeklyDueDateCalculator : SHDailyNextDueDateCalculator
@property (strong, nonatomic) SHWeekIntervalItemList *activeDays;
-(instancetype)initWithRateItemList:(SHWeekIntervalItemList *)activeDays;
@end

NS_ASSUME_NONNULL_END
