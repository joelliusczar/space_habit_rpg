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
@property (assign, nonatomic, nullable) SHDatetime* lastActivationDateTime;
@property (assign, nonatomic) SHDatetime* lastUpdateDateTime;
@property (assign, nonatomic) NSInteger dayStartTime;
@property (assign, nonatomic) SHDatetime* activeFromDate;
@property (strong,nonatomic) NSObject<SHDateProviderProtocol>* dateProvider;
+(instancetype)newWithActiveDays:(SHDailyActiveDays *)activeDaysContainer
	intervalType:(SHRateType)intervalType;
-(NSDate*)nextDueDate;
-(NSDate*)calcBackupLastCheckinDate;
-(NSUInteger)calcMissedDaysWithLastLoginDate:(NSDate*)lastLoginDate;
-(BOOL)isDateActive:(NSDate *)dateInQuestion;
-(NSDate *)calcBackupDateForReferenceDate:(SHDatetime *)referenceDate;
@end

NS_ASSUME_NONNULL_END
