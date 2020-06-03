//
//	SHDailyNextDueDateCalculator.m
//	SHModels
//
//	Created by Joel Pridgen on 8/4/19.
//	Copyright © 2019 Joel Gillette. All rights reserved.
//

//#import "SHDailyNextDueDateCalculator.h"
//#import "SHWeekIntervalItemList.h"
//#import "SHConfig.h"
//#import "SHDailyNextWeeklyDueDateCalculator.h"
//@import SHSpecial_C;
//@import SHCommon;
//
//@implementation SHDailyNextDueDateCalculator
//
//
//-(NSObject<SHDateProviderProtocol>*)dateProvider{
//	if(nil == _dateProvider){
//		_dateProvider = [[SHDefaultDateProvider alloc] init];
//	}
//	return _dateProvider;
//}
//
//
//+(instancetype)newWithActiveDays:(SHDailyActiveDays *)activeDaysContainer intervalType:(SHIntervalType)intervalType {
//	switch (intervalType) {
//		case SH_WEEKLY_INTERVAL:
//			return [[SHDailyNextWeeklyDueDateCalculator alloc] initWithRateItemList:activeDaysContainer.weeklyActiveDays];
//		default:
//			@throw [NSException abstractException];
//	}
//}
//
//
//-(NSDate *)calcBackupDateForReferenceDate:(struct SHDatetime *)referenceDate {
//	(void)referenceDate;
//	@throw [NSException abstractException];
//}
//
//
//-(struct SHDatetime*)nextDueDate{
//	@throw [NSException abstractException];
//}
//
//
//-(BOOL)isDateActive:(struct SHDatetime *)dt {
//	(void)dt;
//	@throw [NSException abstractException];
//}
//
//
//-(NSUInteger)calcMissedDaysWithLastLoginDate:(struct SHDatetime*)lastLoginDate {
//	(void)lastLoginDate;
//	@throw [NSException abstractException];
//}
//
//
//-(NSInteger)missedDays {
//	@throw [NSException abstractException];
//}
//
//@end
