//
//  SHDailyNextWeeklyDueDateCalculator.h
//  SHModels
//
//  Created by Joel Pridgen on 4/12/20.
//  Copyright © 2020 Joel Gillette. All rights reserved.
//

#import "SHDailyNextDueDateCalculator.h"
#import "SHWeeklyRateItemList.h"

NS_ASSUME_NONNULL_BEGIN

@interface SHDailyNextWeeklyDueDateCalculator : SHDailyNextDueDateCalculator
@property (strong, nonatomic) SHWeeklyRateItemList *activeDays;
-(instancetype)initWithRateItemList:(SHWeeklyRateItemList *)activeDays;
-(BOOL)isWeekActiveForDate:(SHDatetime *)dateInQuestion;
@end

NS_ASSUME_NONNULL_END
