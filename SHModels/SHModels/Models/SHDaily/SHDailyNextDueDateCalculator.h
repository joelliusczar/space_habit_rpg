//
//	SHDailyNextDueDateCalculator.h
//	SHModels
//
//	Created by Joel Pridgen on 8/4/19.
//	Copyright © 2019 Joel Gillette. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SHDailyActiveDays.h"
#import <SHCommon/SHDateProviderProtocol.h>

NS_ASSUME_NONNULL_BEGIN

@interface SHDailyNextDueDateCalculator : NSObject
@property (strong,nonatomic) SHDailyActiveDays *activeDaysContainer;
@property (strong,nonatomic) NSDate* lastActivationDateTime;
@property (strong,nonatomic) NSDate* lastUpdateDateTime;
@property (assign,nonatomic) int32_t dayStartTime;
@property (strong,nonatomic) NSObject<SHDateProviderProtocol>* dateProvider;
-(instancetype)initWithActiveDays:(SHDailyActiveDays *)activeDaysContainer
	lastActivationDateTime:(NSDate *)lastActivationDateTime
	lastUpdateDateTime:(NSDate *)lastUpdateDateTime
	dayStartTime:(int32_t)dayStartTime;
-(NSDate*)nextDueDate_WEEKLY;

@end

NS_ASSUME_NONNULL_END
