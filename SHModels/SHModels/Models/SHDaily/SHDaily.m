//
//	SHDaily+CoreDataClass.m
//	
//
//	Created by Joel Pridgen on 4/14/19.
//
//

#import "SHDaily.h"
#import "SHConfig.h"
#import "SHDailyMaxDaysBeforeSpanCalculator.h"
#import "SHDailyEvent.h"
@import SHSpecial_C;

@interface SHDaily ()

@end

@implementation SHDaily

@synthesize activeDaysContainer = _activeDaysContainer;
-(SHDailyActiveDays *)activeDaysContainer{
	if(nil == _activeDaysContainer){
		_activeDaysContainer = [[SHDailyActiveDays alloc] initWithActiveDaysJson:self.activeDays];
	}
	return _activeDaysContainer;
}


/*If we do not have an actual last due date then we assume that whatever reference date
we do have is on an active week even if the reference date is beginning of the
week and long interval size causes the calculated last due date to be many weeks before.
This also applies if the active days got changed. #activeDayMath

#TODO: these priority flags still need to be set in code
*/
-(struct SHDatetime*)selectUseDateProperty {
	if(self.lastActivationDateTime &&
		!self.activeFromHasPriority &&
		!self.lastUpdateHasPriority)
	{
		struct SHDatetime *dt = [self.lastActivationDateTime SH_toSHDatetime];
		SH_dtSetTimezoneOffset(dt, self.tzOffsetLastActivationDateTime);
		return dt;
	}
	if(self.activeFromDate && !self.lastUpdateHasPriority) {
		struct SHDatetime *dt = [self.activeFromDate SH_toSHDatetime];
		//this may need its own tz property but tzOffsetLastUpdateDateTime is good alternative
		SH_dtSetTimezoneOffset(dt, self.tzOffsetLastUpdateDateTime);
		return dt;
	}
	assert(self.lastUpdateDateTime);
	struct SHDatetime *dt = [self.lastUpdateDateTime SH_toSHDatetime];
	SH_dtSetTimezoneOffset(dt, self.tzOffsetLastUpdateDateTime);
	return dt;
}



@synthesize calculator = _calculator;
-(SHDailyNextDueDateCalculator *)calculator {
	int32_t dayStartTime = 0;
	if(nil != self.cycleStartTime) {
		dayStartTime = self.cycleStartTime.intValue;
	}
	else {
		dayStartTime = SHConfig.dayStartTime;
	}
	_calculator = [SHDailyNextDueDateCalculator
		newWithActiveDays:self.activeDaysContainer intervalType:self.rateType];
	_calculator.dateProvider = self.dateProvider;
	_calculator.dayStartTime = dayStartTime;
	struct SHDatetime *selectedDateProperty = [self selectUseDateProperty];
	_calculator.useDate = *selectedDateProperty;
	SH_freeSHDatetime(selectedDateProperty, ALLOC_COUNT);
	return _calculator;
}


-(BOOL)isActiveToday {
	//I'm just gonna use the normal day start here.
	//because I can imagine users getting confused by that
	#warning implement
	return false;
	//return [self.calculator isDateActive:self.dateProvider.date];
}

-(NSInteger)rate{
	switch(self.rateType){
		case SH_YEARLY_RATE:
			return self.activeDaysContainer.yearlyActiveDays.intervalSize;
		case SH_YEARLY_RATE_INVERSE:
			return self.activeDaysContainer.yearlyActiveDaysInv.intervalSize;
		case SH_MONTHLY_RATE:
			return self.activeDaysContainer.monthlyActiveDays.intervalSize;
		case SH_MONTHLY_RATE_INVERSE:
			return self.activeDaysContainer.monthlyActiveDaysInv.intervalSize;
		case SH_WEEKLY_RATE:
			return self.activeDaysContainer.weeklyActiveDays.intervalSize;
		case SH_WEEKLY_RATE_INVERSE:
			return self.activeDaysContainer.weeklyActiveDaysInv.intervalSize;
		case SH_DAILY_RATE:
			return self.activeDaysContainer.dailyRateItem.intervalSize;
		case SH_DAILY_RATE_INVERSE:
			return self.activeDaysContainer.dailyRateItemInv.intervalSize;
	}
	return 1;
}


-(struct SHDatetime *)nextDueDate{
	return [self.calculator nextDueDate];
}


-(NSInteger)daysUntilDue{
	NSUInteger dayStart = 0;
	dayStart = SHConfig.dayStartTime;
	NSDate *today = self.dateProvider.date;
	#warning fix
	return 0;
//	NSDate *roundedDownToday = [today dayStart];
//	NSDate *todayFromStartTime = [roundedDownToday timeAfterSeconds:dayStart];
//	NSDate *todayUTCWithStartTime = [todayFromStartTime dateInTimezone:
//		[NSTimeZone timeZoneForSecondsFromGMT:0]];
//	NSDate *nextDueDate = self.nextDueDate;
//	return (NSInteger)[NSDate daysBetween:todayUTCWithStartTime to:nextDueDate];
}


-(NSInteger)maxDaysBeforeSpan{
	SHDailyMaxDaysBeforeSpanCalculator *calculator = [[SHDailyMaxDaysBeforeSpanCalculator alloc]
		initWithActiveDays:self.activeDaysContainer
		rate: self.rate];
	switch(self.rateType){
		case SH_YEARLY_RATE:
		case SH_YEARLY_RATE_INVERSE:
		case SH_MONTHLY_RATE:
		case SH_MONTHLY_RATE_INVERSE:
			return 2147483647;
		case SH_WEEKLY_RATE:
			return [calculator maxDaysBeforeSpan_WEEKLY];
		case SH_WEEKLY_RATE_INVERSE:
		case SH_DAILY_RATE:
		case SH_DAILY_RATE_INVERSE:
			return 0;
	}
	return 0;
}


-(NSString*)title{
	return self.dailyName;
}


-(void)setTitle:(NSString *)title {
	self.dailyName = title;
}


-(NSDate*)lastTouched {
	return self.lastUpdateDateTime;
}


-(void)setLastTouched:(NSDate *)lastTouched {
	self.lastUpdateDateTime = lastTouched;
}


-(NSUInteger)reminderCount{
	return self.daily_remind.count;
}


-(void)addNewReminder:(SHReminder *)reminder{
	[self addDaily_remindObject:reminder];
}


-(void)removeReminderAtIndex:(NSUInteger)index{
	[self removeObjectFromDaily_remindAtIndex:index];
}


- (SHReminder *)reminderAtIndex:(NSUInteger)index {
	return self.daily_remind[index];
}


-(void)setupInitialState{
	self.activeDays = SH_ALL_DAYS_JSON;
	self.rateType = SH_WEEKLY_RATE;
	self.dailyName = @"";
	self.difficulty = 3;
	self.urgency = 3;
	self.note = @"";
	self.streakLength = 0;
	self.activeFromDate = nil;
	self.activeToDate = nil;
	self.cycleStartTime = 0;
}


-(NSMutableDictionary*)mapable{
	return [NSDictionary objectToDictionary:self];
}


-(SHDailyStatus)calcStatus {
	struct SHDatetime *today = self.dateProvider.userTodayStart;
	struct SHDatetime *prevUseDate = [self selectUseDateProperty];
	bool isDue;
	SH_isDateALTDateB(prevUseDate, today, &isDue);
	SHDailyStatus selection = SH_DAILY_STATUS_UNKNOWN;
	if(isDue) {
		if(self.isActiveToday) {
			selection = SH_DAILY_STATUS_DUE;
		}
		selection = SH_DAILY_STATUS_NOT_DUE;
	}
	selection = SH_DAILY_STATUS_COMPLETE;
	SH_freeSHDatetime(today, 1);
	SH_freeSHDatetime(prevUseDate, 1);
	return selection;
}


-(void)updateDailyStatus {
	self.status = (int32_t)[self calcStatus];
}


@synthesize dateProvider = _dateProvider;

-(NSObject<SHDateProviderProtocol>*)dateProvider{
	if(nil == _dateProvider) {
		_dateProvider = [[SHDefaultDateProvider alloc] init];
	}
	return _dateProvider;
}


-(NSArray<SHDailyEvent *> *)lastActivations:(NSInteger)count {
	NSFetchRequest<SHDailyEvent*> *fetchRequest = SHDailyEvent.fetchRequest;
	fetchRequest.sortDescriptors = @[[NSSortDescriptor
		sortDescriptorWithKey:@"eventDatetime" ascending:NO]];
	fetchRequest.fetchLimit = count;
	fetchRequest.fetchBatchSize = count;
	fetchRequest.predicate = [NSPredicate predicateWithFormat:@"event_daily == %@",self];
	return (NSArray<SHDailyEvent *>*)[self.managedObjectContext
		getItemsWithRequest:fetchRequest];
}


@end
