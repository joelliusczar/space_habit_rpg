//
//  SHDaily+CoreDataClass.m
//  
//
//  Created by Joel Pridgen on 4/14/19.
//
//

#import "SHDaily.h"
#import <SHGlobal/SHConstants.h>
#import <SHCore_C/SHDaily_C.h>
#import "SHRangeRateItem.h"
#import "SHConfig.h"
#import <SHCommon/NSDate+DateHelper.h>
#import <SHData/NSManagedObjectContext+Helper.h>

@implementation SHDaily

@synthesize activeDaysContainer = _activeDaysContainer;
-(SHDailyActiveDays *)activeDaysContainer{
  if(nil == _activeDaysContainer){
    _activeDaysContainer = [[SHDailyActiveDays alloc] initWithActiveDaysJson:self.activeDays];
  }
  return _activeDaysContainer;
}


static void convertObjCRateItemToC(NSArray<SHRangeRateItem*>* rateItems, SHRateValueItem *rvi){
  for(int i = 0; i < SH_DAYS_IN_WEEK; i++){
    [rateItems[i] copyIntoCStruct:&rvi[i]];
  }
}


-(NSDate*)nextDueDate_WEEKLY{
  NSDate *lastCheckinDate = self.lastActivationDateTime?
    self.lastActivationDateTime:
    self.lastUpdateDateTime;
  SHDatetime *lastCheckinDt = calloc(1, sizeof(SHDatetime));
  SHDatetime *checkinDt = calloc(1, sizeof(SHDatetime));
  SHDatetime ans;
  memset(&ans,0,sizeof(SHDatetime));
  SHError *error = calloc(1, sizeof(SHError));
  shTryTimestampToDt(lastCheckinDate.timeIntervalSince1970,0,lastCheckinDt,error);
  shTryTimestampToDt(NSDate.date.timeIntervalSince1970,0,checkinDt,error);
  SHRateValueItem *rvi = calloc(SH_DAYS_IN_WEEK, sizeof(SHRateValueItem));
  convertObjCRateItemToC(self.activeDaysContainer.weeklyActiveDays,rvi);
  shNextDueDate_WEEKLY(lastCheckinDt,checkinDt,rvi,self.rate,&ans,error);
  double dueDateTimestamp = shDtToTimestamp(&ans, error);
  NSDate *nextDueDate = [NSDate dateWithTimeIntervalSince1970:dueDateTimestamp];
  shFreeSHDatetime(lastCheckinDt);
  shFreeSHDatetime(checkinDt);
  shDisposeSHError(error);
  shFreeSHRateValueItem(rvi);
  return nextDueDate;
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
  switch(self.rateType){
    case SH_YEARLY_RATE:
    case SH_YEARLY_RATE_INVERSE:
    case SH_MONTHLY_RATE:
    case SH_MONTHLY_RATE_INVERSE:
    case SH_WEEKLY_RATE:
      return [self nextDueDate_WEEKLY];
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
    request.sortDescriptors = shBasicSortDescArray(@"dayStart");
    NSArray *results = [self.managedObjectContext getItemsWithRequest:request];
    NSAssert(results.count == 1,@"There should be exactly one config object");
    SHConfig *config = (SHConfig*)results[0];
    dayStart = config.dayStartHour;
  }];
  NSDate *roundedDownToday = [[NSDate date] setHour:dayStart minute:0 second:0];
  return (int)[NSDate daysBetween:roundedDownToday to:self.nextDueTime];
}


-(NSString*)taskTitle{
  return self.dailyName;
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

@end
