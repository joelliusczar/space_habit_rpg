//
//	SHDaily+CoreDataClass.m
//	
//
//	Created by Joel Pridgen on 4/14/19.
//
//

#import "SHDaily.h"
#import "SHRangeRateItem.h"
#import "SHConfig.h"
#import "SHDailyNextDueDateCalculator.h"
#import "SHDailyMaxDaysBeforeSpanCalculator.h"
@import SHGlobal;
@import SHData;

@implementation SHDaily

@synthesize activeDaysContainer = _activeDaysContainer;
-(SHDailyActiveDays *)activeDaysContainer{
	if(nil == _activeDaysContainer){
		_activeDaysContainer = [[SHDailyActiveDays alloc] initWithActiveDaysJson:self.activeDays];
	}
	return _activeDaysContainer;
}


-(int32_t)rate{
	switch(self.rateType){
		case SH_YEARLY_RATE:
			return self.activeDaysContainer.yearlyIntervalSize;
		case SH_YEARLY_RATE_INVERSE:
			return self.activeDaysContainer.yearlyIntervalSizeInv;
		case SH_MONTHLY_RATE:
			return self.activeDaysContainer.monthlyIntervalSize;
		case SH_MONTHLY_RATE_INVERSE:
			return self.activeDaysContainer.monthlyIntervalSizeInv;
		case SH_WEEKLY_RATE:
			return self.activeDaysContainer.weeklyIntervalSize;
		case SH_WEEKLY_RATE_INVERSE:
			return self.activeDaysContainer.weeklyIntervalSizeInv;
		case SH_DAILY_RATE:
			return 1;
		case SH_DAILY_RATE_INVERSE:
			return 1;
	}
	return 1;
}


-(NSDate *)nextDueDate{

	SHConfig *config = [[SHConfig alloc] init];
	SHDailyNextDueDateCalculator *calculator = [[SHDailyNextDueDateCalculator alloc]
		initWithActiveDays:self.activeDaysContainer
		lastActivationDateTime:self.lastActivationDateTime
		lastUpdateDateTime:self.lastUpdateDateTime
		dayStartTime:config.dayStartTime];
	calculator.dateProvider = self.dateProvider;
	switch(self.rateType){
		case SH_YEARLY_RATE:
		case SH_YEARLY_RATE_INVERSE:
		case SH_MONTHLY_RATE:
		case SH_MONTHLY_RATE_INVERSE:
		case SH_WEEKLY_RATE:
			return [calculator nextDueDate_WEEKLY];
		case SH_WEEKLY_RATE_INVERSE:
		case SH_DAILY_RATE:
		case SH_DAILY_RATE_INVERSE:
			return nil;
	}
	return nil;
}


-(NSInteger)daysUntilDue{
	NSUInteger dayStart = 0;
	SHConfig *config = [[SHConfig alloc] init];
	dayStart = config.dayStartTime;
	NSDate *today = self.dateProvider.date;
	NSDate *roundedDownToday = [today dayStart];
	NSDate *todayFromStartTime = [roundedDownToday timeAfterSeconds:dayStart];
	NSDate *nextDueDate = self.nextDueDate;
	return (NSInteger)[NSDate daysBetween:todayFromStartTime to:nextDueDate];
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

-(BOOL)isCompleted{
	NSInteger dayStartTime = 0;
	SHConfig *config = [[SHConfig alloc] init];
	dayStartTime = config.dayStartTime;
	NSDate *today = [self.dateProvider.date.dayStart timeAfterSeconds:dayStartTime];
	return nil != self.lastActivationDateTime &&
		self.lastActivationDateTime.timeIntervalSince1970 >= today.timeIntervalSince1970;
}

@synthesize dateProvider = _dateProvider;

-(NSObject<SHDateProviderProtocol>*)dateProvider{
	if(nil == _dateProvider) {
		_dateProvider = [[SHDefaultDateProvider alloc] init];
	}
	return _dateProvider;
}



@end
