//
//	SHDailyMaxDaysBeforeSpanCalculator.h
//	SHModels
//
//	Created by Joel Pridgen on 8/4/19.
//	Copyright © 2019 Joel Gillette. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SHDailyActiveDays.h"

NS_ASSUME_NONNULL_BEGIN

@interface SHDailyMaxDaysBeforeSpanCalculator : NSObject
@property (strong,nonatomic) SHDailyActiveDays *activeDaysContainer;
@property (assign,nonatomic) int32_t rate;
-(instancetype)initWithActiveDays:(SHDailyActiveDays *)activeDaysContainer
	rate:(int32_t)rate;
-(NSInteger)maxDaysBeforeSpan_WEEKLY;
@end

NS_ASSUME_NONNULL_END
