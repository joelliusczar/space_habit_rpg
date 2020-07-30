//
//	SHDaily+CoreDataClass.m
//	
//
//	Created by Joel Pridgen on 4/14/19.
//
//

#import "SHDaily_x.h"
#import "SHConfig.h"
#import "SHDailyMaxDaysBeforeSpanCalculator.h"
#import "SHDailyEvent.h"
@import SHSpecial_C;

static NSSet<NSString*> *_calculatorWatchPropertySet = nil;
static id<SHDateProviderProtocol> _dateProvider;

@interface SHDaily_x ()

@end

@implementation SHDaily_x


+(id<SHDateProviderProtocol>)dateProvider{
	if(nil == _dateProvider) {
		_dateProvider = [[SHDefaultDateProvider alloc] init];
	}
	return _dateProvider;
}

+(void)setDateProvider:(id<SHDateProviderProtocol>)dateProvider {
	_dateProvider = dateProvider;
}


+(void)initialize {
	_calculatorWatchPropertySet = [NSSet setWithArray:@[
		@"intervalType",
		@"activeFromDateTime",
		@"lastActivationDateTime",
		@"lastUpdateDateTime",
		@"cycleStartTime"]];
}


//@synthesize activeDaysContainer = _activeDaysContainer;
//-(SHDailyActiveDays *)activeDaysContainer{
//	if(nil == _activeDaysContainer){
//		_activeDaysContainer = [[SHDailyActiveDays alloc] initWithActiveDaysJson:self.activeDays];
//	}
//	return _activeDaysContainer;
//}


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
	if(self.activeFromDateTime && !self.lastUpdateHasPriority) {
		struct SHDatetime *dt = [self.activeFromDateTime SH_toSHDatetime];
		//this may need its own tz property but tzOffsetLastUpdateDateTime is good alternative
		SH_dtSetTimezoneOffset(dt, self.tzOffsetLastUpdateDateTime);
		return dt;
	}
	assert(self.lastUpdateDateTime);
	struct SHDatetime *dt = [self.lastUpdateDateTime SH_toSHDatetime];
	SH_dtSetTimezoneOffset(dt, self.tzOffsetLastUpdateDateTime);
	return dt;
}



//@synthesize calculator = _calculator;
//-(SHDailyNextDueDateCalculator *)calculator {
//	if(nil != _calculator) {
//		return _calculator;
//	}
//	int32_t dayStartTime = 0;
//	if(nil != self.cycleStartTime) {
//		dayStartTime = self.cycleStartTime.intValue;
//	}
//	else {
//		dayStartTime = SHConfig.dayStartTime;
//	}
//	_calculator = [SHDailyNextDueDateCalculator
//		newWithActiveDays:self.activeDaysContainer intervalType:self.intervalType];
//	_calculator.dateProvider = SHDaily.dateProvider;
//	_calculator.dayStartTime = dayStartTime;
//	struct SHDatetime *selectedDateProperty = [self selectUseDateProperty];
//	_calculator.useDate = *selectedDateProperty;
//	SH_freeSHDatetime(selectedDateProperty, SH_ALLOC_COUNT);
//	return _calculator;
//}
//
//
//-(BOOL)isActiveToday {
//	return [self.calculator isDateActive:SHDaily.dateProvider.dateSHDt];
//}
//
//-(NSInteger)intervalSize{
//	switch(self.intervalType){
//		case SH_YEARLY_INTERVAL:
//			return self.activeDaysContainer.yearlyActiveDays.intervalSize;
//		case SH_YEARLY_INTERVAL_INVERSE:
//			return self.activeDaysContainer.yearlyActiveDaysInv.intervalSize;
//		case SH_MONTHLY_INTERVAL:
//			return self.activeDaysContainer.monthlyActiveDays.intervalSize;
//		case SH_MONTHLY_INTERVAL_INVERSE:
//			return self.activeDaysContainer.monthlyActiveDaysInv.intervalSize;
//		case SH_WEEKLY_INTERVAL:
//			return self.activeDaysContainer.weeklyActiveDays.intervalSize;
//		case SH_WEEKLY_INTERVAL_INVERSE:
//			return self.activeDaysContainer.weeklyActiveDaysInv.intervalSize;
//		case SH_DAILY_INTERVAL:
//			return self.activeDaysContainer.dailyRateItem.intervalSize;
//		case SH_DAILY_INTERVAL_INVERSE:
//			return self.activeDaysContainer.dailyRateItemInv.intervalSize;
//	}
//	return 1;
//}


//-(struct SHDatetime *)nextDueDate{
//	return [self.calculator nextDueDate];
//}
//
//
//-(NSInteger)daysUntilDue{
//	struct SHDatetime *todayStartLocal = [SHDaily.dateProvider userTodayStart];
//	struct SHDatetime *nextDueDateLocal = [self.calculator nextDueDate];
//	if(!nextDueDateLocal) {
//		return SH_NOT_FOUND;
//	}
//	int64_t daysUntilDue = 0;
//	SHErrorCode status = SH_NO_ERROR;
//	status = SH_dateDiffDays(todayStartLocal, nextDueDateLocal, &daysUntilDue);
//	SH_freeSHDatetime(todayStartLocal, 1);
//	SH_freeSHDatetime(nextDueDateLocal, 1);
//	if(status != SH_NO_ERROR) {
//		return SH_NOT_FOUND;
//	}
//	return daysUntilDue;
//}
//
//
//-(NSInteger)maxDaysBeforeSpan{
//	SHDailyMaxDaysBeforeSpanCalculator *calculator = [[SHDailyMaxDaysBeforeSpanCalculator alloc]
//		initWithActiveDays:self.activeDaysContainer
//		rate: self.intervalSize];
//	switch(self.intervalType){
//		case SH_YEARLY_INTERVAL:
//		case SH_YEARLY_INTERVAL_INVERSE:
//		case SH_MONTHLY_INTERVAL:
//		case SH_MONTHLY_INTERVAL_INVERSE:
//			return 2147483647;
//		case SH_WEEKLY_INTERVAL:
//			return [calculator maxDaysBeforeSpan_WEEKLY];
//		case SH_WEEKLY_INTERVAL_INVERSE:
//		case SH_DAILY_INTERVAL:
//		case SH_DAILY_INTERVAL_INVERSE:
//			return 0;
//	}
//	return 0;
//}


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
	return 0;
}


//-(void)addNewReminder:(SHReminder *)reminder{
//	[self addDaily_remindObject:reminder];
//}
//
//
//-(void)removeReminderAtIndex:(NSUInteger)index{
//	[self removeObjectFromDaily_remindAtIndex:index];
//}
//
//
//- (SHReminder *)reminderAtIndex:(NSUInteger)index {
//	return self.daily_remind[index];
//}


-(void)setupInitialState{
	self.activeDays = SH_ALL_DAYS_JSON;
	//self.intervalType = SH_WEEKLY_INTERVAL;
	self.dailyName = @"";
	self.difficulty = 3;
	self.urgency = 3;
	self.note = @"";
	self.streakLength = 0;
	self.activeFromDateTime = nil;
	self.activeToDateTime = nil;
	self.cycleStartTime = 0;
}


-(NSMutableDictionary*)mapable{
	return [NSDictionary objectToDictionary:self];
}


//-(SHDailyStatus)calcStatus {
//	struct SHDatetime *today = SHDaily_x.dateProvider.userTodayStart;
//	struct SHDatetime *savedPrevDate = [self selectUseDateProperty];
//	bool isDue;
//	SH_isDateXBeforeDateY(savedPrevDate, today, &isDue);
//	SHDailyStatus selection = SH_DAILY_STATUS_UNKNOWN;
//	if(isDue) {
//		if(self.isActiveToday) {
//			selection = SH_DAILY_STATUS_DUE;
//		}
//		selection = SH_DAILY_STATUS_NOT_DUE;
//	}
//	selection = SH_DAILY_STATUS_COMPLETE;
//	SH_freeSHDatetime(today, 1);
//	SH_freeSHDatetime(savedPrevDate, 1);
//	return selection;
//}


-(void)updateDailyStatus {
	//self.status = (int32_t)[self calcStatus];
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


-(void)addObservers {
	for(NSString *key in _calculatorWatchPropertySet) {
		[self addObserver:self forKeyPath:key options:NSKeyValueObservingOptionNew context:nil];
	}
	[SHConfig addObserver:self forKeyPath:@"dayStartTime" options:NSKeyValueObservingOptionNew context:nil];
	[SHConfig addObserver:self forKeyPath:@"weeklyStartDay" options:NSKeyValueObservingOptionNew context:nil];
}


-(void)awakeFromFetch {
	[super awakeFromFetch];
	[self addObservers];
}


-(void)awakeFromInsert {
	[super awakeFromInsert];
	[self addObservers];
}


-(void)didTurnIntoFault {
	[super didTurnIntoFault];
	[SHConfig safeRemoveObserver:self forKeyPath:@"dayStartTime" context:nil];
	[SHConfig safeRemoveObserver:self forKeyPath:@"weeklyStartDay" context:nil];
}


-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object
 change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
	(void)object; (void)change; (void)context;
	if([_calculatorWatchPropertySet containsObject:keyPath] || object == SHConfig.class) {
		//_calculator = nil;
	}
}


@end
