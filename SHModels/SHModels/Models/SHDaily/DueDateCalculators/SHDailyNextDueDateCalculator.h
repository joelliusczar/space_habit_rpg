//
//	SHDailyNextDueDateCalculator.h
//	SHModels
//
//	Created by Joel Pridgen on 8/4/19.
//	Copyright © 2019 Joel Gillette. All rights reserved.
//

#import "SHDailyActiveDays.h"
@import Foundation;
@import SHCommon;
@import SHDatetime;

NS_ASSUME_NONNULL_BEGIN

@interface SHDailyNextDueDateCalculator : NSObject
@property (strong, nonatomic) SHDailyActiveDays *activeDaysContainer;
/*for properties, I prefer to use non-pointers because it's
	harder to track if the memory is no longer needed.
*/
@property (assign, nonatomic) struct SHDatetime useDate;
@property (assign, nonatomic) int32_t dayStartTime;
@property (strong,nonatomic) NSObject<SHDateProviderProtocol>* dateProvider;
+(instancetype)newWithActiveDays:(SHDailyActiveDays *)activeDaysContainer
	intervalType:(SHRateType)intervalType;
-(struct SHDatetime*)nextDueDate;
-(BOOL)isDateActive:(struct SHDatetime *)dt;
@end

NS_ASSUME_NONNULL_END
