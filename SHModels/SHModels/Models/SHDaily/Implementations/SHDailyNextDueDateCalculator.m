//
//	SHDailyNextDueDateCalculator.m
//	SHModels
//
//	Created by Joel Pridgen on 8/4/19.
//	Copyright © 2019 Joel Gillette. All rights reserved.
//

#import "SHDailyNextDueDateCalculator.h"
#import "SHWeeklyRateItemList.h"
#import "SHConfig.h"
#import "SHDailyNextWeeklyDueDateCalculator.h"
@import SHSpecial_C;
@import SHCommon;

@implementation SHDailyNextDueDateCalculator


-(NSObject<SHDateProviderProtocol>*)dateProvider{
	if(nil == _dateProvider){
		_dateProvider = [[SHDefaultDateProvider alloc] init];
	}
	return _dateProvider;
}


+(instancetype)newWithActiveDays:(SHDailyActiveDays *)activeDaysContainer intervalType:(SHRateType)intervalType {
	switch (intervalType) {
		case SH_WEEKLY_RATE:
			return [[SHDailyNextWeeklyDueDateCalculator alloc] initWithRateItemList:activeDaysContainer.weeklyActiveDays];
		default:
			@throw [NSException abstractException];
	}
}


-(NSDate *)calcBackupDateForReferenceDate:(NSDate *)referenceDate {
	(void)referenceDate;
	@throw [NSException abstractException];
}

/*If we do not have an actual last due date then we assume that whatever reference date
we do have is on an active week even if the reference date is beginning of the
week and long interval size causes the calculated last due date to be many weeks before.
This also applies if the active days got changed.
*/
-(NSDate*)calcBackupLastCheckinDate {
	if(self.lastActivationDateTime) {
		return [self calcBackupDateForReferenceDate:self.lastActivationDateTime];
	}
	if(self.activeFromDate) {
		return [self calcBackupDateForReferenceDate:self.activeFromDate];
	}
	return [self calcBackupDateForReferenceDate:self.lastUpdateDateTime];
}


-(NSDate*)nextDueDate{
	@throw [NSException abstractException];
}


-(BOOL)isDateActive:(NSDate *)dateInQuestion {
	(void)dateInQuestion;
	@throw [NSException abstractException];
}


-(NSUInteger)calcMissedDaysWithLastLoginDate:(NSDate*)lastLoginDate {
	(void)lastLoginDate;
	@throw [NSException abstractException];
}

@end
