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
	lastActivationDateTime:(NSDate *)lastActivationDateTime
	lastUpdateDateTime:(NSDate *)lastUpdateDateTime
	dayStartTime:(NSInteger)dayStartTime
{
	if(self = [super init]) {
		_activeDaysContainer = activeDaysContainer;
		_utcLastActivationDateTime = lastActivationDateTime;
		_utcLastUpdateDateTime = lastUpdateDateTime;
		_dayStartTime = dayStartTime;
	}
	return self;
}


static void convertObjCRateItemToC(SHWeeklyRateItemList* rateItems, SHRateValueItem *rvi){
	for(int i = 0; i < SH_DAYS_IN_WEEK; i++){
		[rateItems[i] copyIntoCStruct:&rvi[i]];
	}
}


- (NSDate * _Nonnull)calcBackupDateForInactiveDate:(NSDate *)inactiveDate {
	if([self isDateActive:inactiveDate]) {
	 return inactiveDate;
	}
	int32_t weekdayIdx = (int32_t)[inactiveDate getWeekdayIndexUTC];
	int32_t prevDayIdx = (int32_t)[self.activeDaysContainer.weeklyActiveDays findPrevActiveDayIdx:weekdayIdx];
	BOOL isCurrentWeekActive = weekdayIdx > prevDayIdx;
	int32_t diff = weekdayIdx - prevDayIdx;
	if(isCurrentWeekActive) {
		return [inactiveDate dateAfterYears:0 months:0 days:-diff];
	}
	int64_t daysAgo = sh_calcDaysAgoDayWasActive(prevDayIdx,
		self.activeDaysContainer.weeklyActiveDays.intervalSize);
	return [inactiveDate dateAfterYears:0 months:0 days:-(daysAgo + diff)];
}

-(NSDate*)calcBackupLastCheckinDate {
	if(self.utcActiveFromDate) {
		return [self calcBackupDateForInactiveDate:self.utcActiveFromDate];
	}
	return [self calcBackupDateForInactiveDate:self.utcLastUpdateDateTime];
}


-(NSDate*)nextDueDate_WEEKLY{
	NSDate *lastCheckinDate = self.utcLastActivationDateTime?
		self.utcLastActivationDateTime:
		[self calcBackupLastCheckinDate];
	SHDatetime *lastCheckinDt = [lastCheckinDate toSHDatetimeUTC];
	SHDatetime *checkinDt = [self.dateProvider.date toSHDatetimeUTC];
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
	SHDatetime *dt = [dateInQuestion toSHDatetime];
	SHDatetime *checkinDt = [self.dateProvider.date toSHDatetimeUTC];
	SHRateValueItem *rvi =  [self.activeDaysContainer.weeklyActiveDays convertObjCRateItemToC];
	int64_t intervalSize = self.activeDaysContainer.weeklyActiveDays.intervalSize;
	SHError error;
	memset(&error, 0, sizeof(SHError));
	bool result = sh_isDateADueDate_WEEKLY(dt, checkinDt, rvi,
		intervalSize, self.dayStartTime, &error);
	int32_t timeShiftCount = 1;
	shFreeSHDatetime(dt, timeShiftCount);
	shFreeSHRateValueItem(rvi);
	return result;
}


@end
