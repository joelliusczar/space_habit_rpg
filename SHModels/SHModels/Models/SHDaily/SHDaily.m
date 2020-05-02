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
This also applies if the active days got changed.
*/
-(NSDate*)selectUseDateProperty {
	if(self.lastActivationDateTime) {
		return self.lastActivationDateTime;
	}
	if(self.activeFromDate) {
		return self.activeFromDate;
	}
	assert(self.lastUpdateDateTime);
	return self.lastUpdateDateTime;
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
	struct SHDatetime *selectedDateProperty = [[self selectUseDateProperty] SH_toSHDatetime];
	_calculator.useDate = *selectedDateProperty;
	SH_freeSHDatetime(selectedDateProperty);
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


-(NSDate*)calcBackupLastCheckinDate:(NSTimeInterval*)tzOffsetPtr {
	#warning figure this shit out
	return nil;
//	if(self.lastActivationDateTime) {
//		*tzOffsetPtr = self.tzOffsetLastActivationDateTime;
//		return [self.calculator calcBackupDateForReferenceDate:self.lastActivationDateTime];
//	}
//	if(self.activeFromDate) {
//		*tzOffsetPtr = self.dateProvider.localTzOffset;
//		return [self.calculator calcBackupDateForReferenceDate:self.activeFromDate];
//	}
//	*tzOffsetPtr = self.tzOffsetLastUpdateDateTime;
//	return [self.calculator calcBackupDateForReferenceDate:self.lastUpdateDateTime];
}


-(SHDailyStatus)calcStatus {
	NSTimeInterval todayTS = SHConfig.userTodayStart.timeIntervalSince1970;
	NSTimeInterval tzOffset = 0;
	NSTimeInterval lastCheckinTS = [self calcBackupLastCheckinDate: &tzOffset].timeIntervalSince1970;
	NSTimeInterval offsetLastCheckinTS = lastCheckinTS - tzOffset;
	if(offsetLastCheckinTS < todayTS) {
		if(self.isActiveToday) {
			return SH_DAILY_STATUS_DUE;
		}
		return SH_DAILY_STATUS_NOT_DUE;
	}
	return SH_DAILY_STATUS_COMPLETE;;
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
