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
#import <SHGlobal/SHConstants.h>
#import <SHCommon/NSDate+DateHelper.h>
#import <SHData/NSManagedObjectContext+Helper.h>
#import "NSManagedObjectContext+SHModelHelper.h"

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


-(NSDate *)nextDueTime{
	SHDailyNextDueDateCalculator *calculator = [[SHDailyNextDueDateCalculator alloc]
		initWithActiveDays:self.activeDaysContainer
		lastActivationDateTime:self.lastActivationDateTime
		lastUpdateDateTime:self.lastUpdateDateTime
		rate:self.rate];
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


-(NSInteger)maxDaysBefore{
	__block NSUInteger dayStart = 0;
	[self.managedObjectContext performBlockAndWait:^{
		NSFetchRequest *request = SHConfig.fetchRequest;
		request.sortDescriptors = shBasicSortDescArray(@"dayStartHour");
		NSArray *results = [self.managedObjectContext getItemsWithRequest:request];
		NSAssert(results.count == 1,@"There should be exactly one config object");
		SHConfig *config = (SHConfig*)results[0];
		dayStart = config.dayStartHour;
	}];
	NSDate *roundedDownToday = [[NSDate date] setHour:dayStart minute:0 second:0];
	return (int)[NSDate daysBetween:roundedDownToday to:self.nextDueTime];
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


-(NSMutableDictionary*)simpleMapable{
	return [NSDictionary objectToDictionary:self];
}

-(BOOL)isCompleted{
	__block NSInteger dayStartHour = 0;
	[self.managedObjectContext performBlockAndWait:^{
		SHConfig *config = self.managedObjectContext.sh_globalConfig;
		dayStartHour = config.dayStartHour;
	}];
	NSDate *today = [NSDate.date.dayStart timeAfterHours:dayStartHour minutes:0 seconds:0];
	return nil == self.lastActivationDateTime || self.lastActivationDateTime.timeIntervalSince1970 < today.timeIntervalSince1970;
}

@end
