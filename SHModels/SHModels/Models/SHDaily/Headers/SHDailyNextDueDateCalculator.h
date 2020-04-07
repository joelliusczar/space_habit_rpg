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

NS_ASSUME_NONNULL_BEGIN

@interface SHDailyNextDueDateCalculator : NSObject
@property (strong, nonatomic) SHDailyActiveDays *activeDaysContainer;
@property (strong, nonatomic, nullable) NSDate* lastActivationDateTime;
@property (strong, nonatomic) NSDate* lastUpdateDateTime;
@property (assign, nonatomic) NSInteger dayStartTime;
@property (strong, nonatomic) NSDate* activeFromDate;
@property (strong,nonatomic) NSObject<SHDateProviderProtocol>* dateProvider;
-(instancetype)initWithActiveDays:(SHDailyActiveDays *)activeDaysContainer
	dayStartTime:(NSInteger)dayStartTime;
-(NSDate*)nextDueDate_WEEKLY;
-(NSDate*)calcBackupLastCheckinDate;
-(BOOL)isDateActive:(NSDate *)dateInQuestion;
@end

NS_ASSUME_NONNULL_END
