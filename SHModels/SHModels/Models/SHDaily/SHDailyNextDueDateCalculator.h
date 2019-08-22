//
//	SHDailyNextDueDateCalculator.h
//	SHModels
//
//	Created by Joel Pridgen on 8/4/19.
//	Copyright © 2019 Joel Gillette. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SHDailyActiveDays.h"

NS_ASSUME_NONNULL_BEGIN

@interface SHDailyNextDueDateCalculator : NSObject
@property (strong,nonatomic) SHDailyActiveDays *activeDaysContainer;
@property (strong,nonatomic) NSDate* lastActivationDateTime;
@property (strong,nonatomic) NSDate* lastUpdateDateTime;
-(instancetype)initWithActiveDays:(SHDailyActiveDays *)activeDaysContainer
	lastActivationDateTime:(NSDate *)lastActivationDateTime
	lastUpdateDateTime:(NSDate *)lastUpdateDateTime
	rate:(int32_t)rate;
-(NSDate*)nextDueDate_WEEKLY;
@property (assign,nonatomic) int32_t rate;
@end

NS_ASSUME_NONNULL_END
