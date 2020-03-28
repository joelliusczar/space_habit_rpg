//
//	SHDailyNextDueDateCalculator.m
//	SHModels
//
//	Created by Joel Pridgen on 8/4/19.
//	Copyright © 2019 Joel Gillette. All rights reserved.
//

#import "SHDailyNextDueDateCalculator.h"
#import "SHWeeklyRateItemList.h"
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



-(NSDate * _Nonnull)calcBackupDateForReferenceDate:(NSDate *)referenceDate {
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


-(NSDate*)nextDueDate_WEEKLY{
	NSDate *lastCheckinDate = [self calcBackupLastCheckinDate];
	SHDatetime *lastCheckinDt = [lastCheckinDate toSHDatetime];
	SHDatetime *checkinDt = [self.dateProvider.date toSHDatetime];
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


@end
