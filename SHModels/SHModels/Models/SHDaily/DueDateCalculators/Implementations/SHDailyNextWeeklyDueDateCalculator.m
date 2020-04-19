//
//  SHDailyNextWeeklyDueDateCalculator.m
//  SHModels
//
//  Created by Joel Pridgen on 4/12/20.
//  Copyright © 2020 Joel Gillette. All rights reserved.
//

#import "SHDailyNextWeeklyDueDateCalculator.h"
#import "SHConfig.h"
@import SHCommon;
@import SHSpecial_C;

@implementation SHDailyNextWeeklyDueDateCalculator


-(instancetype)initWithRateItemList:(SHWeeklyRateItemList *)activeDays {
	if(self = [super init]){
		_activeDays = activeDays;
	}
	return self;
}


-(NSDate *)calcBackupDateForReferenceDate:(SHDatetime *)referenceDate {
	int32_t weekStartDayOffset = SHConfig.weeklyStartDay;
	SHError error;
	memset(&error, 0, sizeof(SHError));
	int32_t weekdayIdx = SH_getWeekdayIndexOffsetForStartDayIdx(referenceDate, weekStartDayOffset, &error);
	if(self.activeDays[weekdayIdx].isDayActive) {
	 return referenceDate;
	}
	NSUInteger prevDayIdx = [self.activeDays findPrevActiveDayIdx:weekdayIdx];
	BOOL isCurrentWeekActive = weekdayIdx > prevDayIdx;
	NSInteger diff = weekdayIdx - prevDayIdx;
	if(isCurrentWeekActive) {
		return [referenceDate dateAfterYears:0 months:0 days:-diff];
	}
	int64_t daysAgo = sh_calcDaysAgoDayWasActive((int32_t)prevDayIdx,
		self.activeDays.intervalSize);
	return [referenceDate dateAfterYears:0 months:0 days:-(daysAgo + diff)];
}


- (NSDate * _Nonnull)nextDueDateForLoginDate:(NSDate *)loginDate {
	NSDate *lastCheckinDate = [self calcBackupLastCheckinDate];
	SHDatetime *lastCheckinDt = [lastCheckinDate toSHDatetime];
	SHDatetime *checkinDt = [loginDate toSHDatetime];
	SHDatetime ans;
	memset(&ans,0,sizeof(SHDatetime));
	SHError *error = calloc(ALLOC_COUNT, sizeof(SHError));
	
	SHRateValueItem *rvi =  [self.activeDays convertObjCRateItemToC];
	sh_nextDueDate_WEEKLY(lastCheckinDt,checkinDt,rvi,
		self.activeDays.intervalSize,
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


-(NSDate*)nextDueDate {
	return [self nextDueDateForLoginDate: self.dateProvider.date];
}


-(BOOL)isDateActive:(NSDate *)dateInQuestion {
	SHDatetime *checkinDate = [dateInQuestion toSHDatetime];
	SHDatetime *lastDueDate = [[self calcBackupLastCheckinDate] toSHDatetime];
	SHRateValueItem *rvi =  [self.activeDays convertObjCRateItemToC];
	int64_t intervalSize = self.activeDays.intervalSize;
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


-(BOOL)isWeekActiveForDate:(SHDatetime *)dateInQuestion {
	NSInteger weeklyStartDayOffset = SHConfig.weeklyStartDay;
	SHDatetime cursorDt;
	SHError error;
	memset(&error, 0, sizeof(SHError));
	SHDatetime *lastCheckinDate = [[self calcBackupLastCheckinDate] toSHDatetime];
	SHDatetime *previousDueDate = calloc(ALLOC_COUNT, sizeof(SHDatetime));
	SHRateValueItem *rvi =  [self.activeDays convertObjCRateItemToC];
	int64_t intervalSize = self.activeDays.intervalSize;
	BOOL result = NO;
	int32_t timeShiftCount = 1;
	if(SH_areSameWeekWithDayOffset(dateInQuestion, lastCheckinDate, weeklyStartDayOffset, &error) {
		return YES;
	}
	if(!SH_tryCalcWeekStartWithDayOffset(dateInQuestion, &error, weeklyStartDayOffset, &cursorDt)) {
		goto cleanup;
	}
	if(!sh_previousDueDate_WEEKLY(lastCheckinDate, cursorDt, rvi, intervalSize, self.dayStartTime,
		previousDueDate, &error))
	{
		goto cleanup;
	}
	for(int32_t idx = 0; idx < SH_DAYS_IN_WEEK; idx++) {
		shTryAddDaysToDtInPlace(cursorDt, idx, SH_TIME_ADJUST_NO_OPTION, &error);
		if(sh_isDateADueDate_WEEKLY(cursorDt, previousDueDate, rvi, intervalSize, self.dayStartTime, &error )) {
			result = YES;
			break;
		}
		if(error.isError) {
			break;
		}
	}
	cleanup:
	shFreeSHDatetime(lastCheckinDate, timeShiftCount);
	shFreeSHDatetime(previousDueDate, timeShiftCount);
	shFreeSHRateValueItem(rvi);
	if(error.isError) {
		@throw [NSException encounterSHError:&error];
	}
	return result;
}


-(NSUInteger)calcMissedDaysWithLastLoginDate:(NSDate*)lastLoginDate {
	NSDate *prevNextDueDate = [self nextDueDateForLoginDate:SHConfig.lastProcessingDateTime];
	NSDate *todayStart = SHConfig.userTodayStart;
	NSInteger intervalSize = self.activeDays.intervalSize;
	NSInteger weekStartDayIdx = SHConfig.weeklyStartDay;
	NSUInteger prevWeekdayIdx = [prevNextDueDate SH_getWeekdayIndexOffsetForStartDayIdx:weekStartDayIdx];
	NSUInteger checkinWeekdayIdx = [lastLoginDate SH_getWeekdayIndexOffsetForStartDayIdx:weekStartDayIdx];
	if(intervalSize < 1) {
		@throw [NSException oddException:@"interval size should be at least 1"];
	}
	else if(intervalSize == 1 && [prevNextDueDate SH_isSameWeekAs:todayStart withDayOffset: weekStartDayIdx]) {
		return [self.activeDays activeDaysInRange:
			NSMakeRange(prevWeekdayIdx, checkinWeekdayIdx - prevWeekdayIdx)];
	}
	NSUInteger fullWeekCount = [NSDate SH_fullWeeksBetween:prevNextDueDate to:lastLoginDate
		withWeekStartOffset:weekStartDayIdx];
	NSUInteger week1ActiveDaysCount = [self.activeDays activeDaysInRange:
		NSMakeRange(prevWeekdayIdx, SH_DAYS_IN_WEEK - prevWeekdayIdx)];
	NSUInteger lastWeekActiveDaysCount = [self.activeDays activeDaysInRange:
		NSMakeRange(0, checkinWeekdayIdx)];
	NSUInteger fullWeekActiveDaysCount = [self.activeDays activeDaysInRange:
		NSMakeRange(0, SH_DAYS_IN_WEEK)];
		//self.activeDays.
	
	return 0;
}

@end
