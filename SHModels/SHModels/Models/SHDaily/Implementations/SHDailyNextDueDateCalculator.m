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
@import SHSpecial_C;
@import SHCommon;

@implementation SHDailyNextDueDateCalculator


-(NSObject<SHDateProviderProtocol>*)dateProvider{
	if(nil == _dateProvider){
		_dateProvider = [[SHDefaultDateProvider alloc] init];
	}
	return _dateProvider;
}


-(instancetype)initWithActiveDays:(SHDailyActiveDays *)activeDaysContainer
	dayStartTime:(NSInteger)dayStartTime
{
	if(self = [super init]) {
		_activeDaysContainer = activeDaysContainer;
		_dayStartTime = dayStartTime;
	}
	return self;
}



-(NSDate *)calcBackupDateForReferenceDate:(NSDate *)referenceDate {
	NSUInteger weekdayIdx = [referenceDate getWeekdayIndex];
	if(self.activeDaysContainer.weeklyActiveDays[weekdayIdx].isDayActive) {
	 return referenceDate;
	}
	NSUInteger prevDayIdx = [self.activeDaysContainer.weeklyActiveDays findPrevActiveDayIdx:weekdayIdx];
	BOOL isCurrentWeekActive = weekdayIdx > prevDayIdx;
	NSInteger diff = weekdayIdx - prevDayIdx;
	if(isCurrentWeekActive) {
		return [referenceDate dateAfterYears:0 months:0 days:-diff];
	}
	int64_t daysAgo = sh_calcDaysAgoDayWasActive((int32_t)prevDayIdx,
		self.activeDaysContainer.weeklyActiveDays.intervalSize);
	return [referenceDate dateAfterYears:0 months:0 days:-(daysAgo + diff)];
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


- (NSDate * _Nonnull)nextDueDateForLoginDate_WEEKLY:(NSDate *)loginDate {
	NSDate *lastCheckinDate = [self calcBackupLastCheckinDate];
	SHDatetime *lastCheckinDt = [lastCheckinDate toSHDatetime];
	SHDatetime *checkinDt = [loginDate toSHDatetime];
	SHDatetime ans;
	memset(&ans,0,sizeof(SHDatetime));
	SHError *error = calloc(ALLOC_COUNT, sizeof(SHError));
	
	SHRateValueItem *rvi =  [self.activeDaysContainer.weeklyActiveDays convertObjCRateItemToC];
	sh_nextDueDate_WEEKLY(lastCheckinDt,checkinDt,rvi,
		self.activeDaysContainer.weeklyActiveDays.intervalSize,
		self.dayStartTime, &ans, error);
	double dueDateTimestamp = shDtToTimestamp(&ans, error);
	NSDate *nextDueDate = [NSDate dateWithTimeIntervalSince1970:dueDateTimestamp];
	int32_t timeShiftCount = 1;
	shFreeSHDatetime(lastCheckinDt, timeShiftCount);
	shFreeSHDatetime(checkinDt, timeShiftCount);
	shDisposeSHError(error);
	shFreeSHRateValueItem(rvi);
	return nextDueDate;
}

-(NSDate*)nextDueDate_WEEKLY{
	return [self nextDueDateForLoginDate_WEEKLY: self.dateProvider.date];
}


-(BOOL)isDateActive:(NSDate *)dateInQuestion {
	SHDatetime *checkinDate = [dateInQuestion toSHDatetime];
	SHDatetime *lastDueDate = [[self calcBackupLastCheckinDate] toSHDatetime];
	SHRateValueItem *rvi =  [self.activeDaysContainer.weeklyActiveDays convertObjCRateItemToC];
	int64_t intervalSize = self.activeDaysContainer.weeklyActiveDays.intervalSize;
	SHError error;
	memset(&error, 0, sizeof(SHError));
	bool result = sh_isDateADueDate_WEEKLY(checkinDate, lastDueDate, rvi,
		intervalSize, self.dayStartTime, &error);
	int32_t timeShiftCount = 1;
	shFreeSHDatetime(checkinDate, timeShiftCount);
	shFreeSHDatetime(lastDueDate, timeShiftCount);
	shFreeSHRateValueItem(rvi);
	return result;
}


-(NSUInteger)calcMissedDays_WEEKLY_withLastLoginDate:(NSDate*)lastLoginDate {
//	NSDate *prevNextDueDate = [self nextDueDateForLoginDate_WEEKLY:SHConfig.lastProcessingDateTime];
//	NSDate *todayStart = SHConfig.userTodayStart;
//	NSInteger intervalSize = self.activeDaysContainer.weeklyActiveDays.intervalSize;
//	NSUInteger prevWeekdayIdx = [prevNextDueDate getWeekdayIndex];
//	NSUInteger checkinWeekdayIdx = [lastLoginDate getWeekdayIndex];
//	//NSUInteger fullWeekCount = [NSDate SH_fu];
//	if(intervalSize < 1) {
//		@throw [NSException oddException:@"interval size should be at least 1"];
//	}
//	else if(intervalSize == 1) {
//		if([prevNextDueDate SH_isSameWeekAs:todayStart]) {
//			return [self.activeDaysContainer.weeklyActiveDays activeDaysInRange:
//				NSMakeRange(prevWeekdayIdx, checkinWeekdayIdx - prevWeekdayIdx)];
//		}
//		NSUInteger week1ActiveDaysCount = [self.activeDaysContainer.weeklyActiveDays activeDaysInRange:
//			NSMakeRange(prevWeekdayIdx, SH_DAYS_IN_WEEK - prevWeekdayIdx)];
//		NSUInteger lastWeekActiveDaysCount = [self.activeDaysContainer.weeklyActiveDays activeDaysInRange:
//			NSMakeRange(0, checkinWeekdayIdx)];
//		NSUInteger fullWeekActiveDaysCount = [self.activeDaysContainer.weeklyActiveDays activeDaysInRange:
//			NSMakeRange(0, SH_DAYS_IN_WEEK)];
//		//self.activeDaysContainer.weeklyActiveDays.
//	}
	
	return 0;
}


-(NSUInteger)calcMissedDays:(SHRateType)intervalType withLastLoginDate:(NSDate*)lastLoginDate {
	switch(intervalType){
		case SH_YEARLY_RATE:
		case SH_YEARLY_RATE_INVERSE:
		case SH_MONTHLY_RATE:
		case SH_MONTHLY_RATE_INVERSE:
		case SH_WEEKLY_RATE:
			return [self calcMissedDays_WEEKLY_withLastLoginDate: lastLoginDate];
		case SH_WEEKLY_RATE_INVERSE:
		case SH_DAILY_RATE:
		case SH_DAILY_RATE_INVERSE:
			return 0;
	}
	return 0;
}

@end
