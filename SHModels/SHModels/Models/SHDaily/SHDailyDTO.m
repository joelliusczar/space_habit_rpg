//
//  SHDailyDTO.m
//  SHModels
//
//  Created by Joel Pridgen on 4/13/19.
//  Copyright © 2019 Joel Gillette. All rights reserved.
//

#import "SHDailyDTO.h"
#import <SHGlobal/SHConstants.h>
#import "SHRateTypeHelper.h"
#import <SHCommon/NSMutableDictionary+Helper.h>
#import <SHCore_C/SHDaily_C.h>
#import <SHDatetime/SHDatetime_struct.h>
#import <SHDatetime/SHDatetimeFuncs.h>
#import <SHCommon/NSDate+DateHelper.h>
#import <SHDatetime/SHDTConstants.h>


@implementation SHDailyDTO


-(id)copyWithZone:(NSZone *)zone{
  (void)zone;
  return [self dtoCopy];
}


-(SHListRateItemCollection*)buildActiveDays:(SHRateType)rateType majorKey:(NSString*)majorKey
  minorKey:(NSString*)minorKey
{
    NSMutableArray *raw = (NSMutableArray*)self.activeDaysDict[shGetRateTypeKey(rateType)];
    NSMutableArray* mapped = [raw mapItemsTo:^id (id item,NSUInteger idx){
      (void)idx;
      NSDictionary<NSString*,NSNumber*> *dict = (NSDictionary*)item;
      NSInteger major = dict[majorKey].integerValue;
      NSInteger minor = dict[minorKey].integerValue;
      SHListRateItem *rateItem = [[SHListRateItem alloc]
        initWithMajorOrdinal:major
        minorOrdinal:minor];
      
      return rateItem;
    }];
    return [[SHListRateItemCollection  alloc] initWithActiveDays:mapped];
}

@synthesize monthlyActiveDays = _monthlyActiveDays;
-(SHListRateItemCollection*)monthlyActiveDays{
  if(nil == _monthlyActiveDays){
    _monthlyActiveDays = [self buildActiveDays:SH_MONTHLY_RATE majorKey:SH_ORDINAL_WEEK_KEY
      minorKey:SH_DAY_OF_WEEK_KEY];
  }
  return _monthlyActiveDays;
}


@synthesize monthlyActiveDaysInv = _monthlyActiveDaysInv;
-(SHListRateItemCollection*)monthlyActiveDaysInv{
  if(nil == _monthlyActiveDaysInv){
    _monthlyActiveDaysInv = [self buildActiveDays:SH_MONTHLY_RATE_INVERSE
      majorKey:SH_ORDINAL_WEEK_KEY minorKey:SH_DAY_OF_WEEK_KEY];
  }
  return _monthlyActiveDaysInv;
}

@synthesize yearlyActiveDays = _yearlyActiveDays;
-(SHListRateItemCollection*)yearlyActiveDays{
  if(nil == _yearlyActiveDays){
    _yearlyActiveDays = [self buildActiveDays:SH_YEARLY_RATE
      majorKey:SH_MONTH_KEY minorKey:SH_DAY_OF_MONTH_KEY];
  }
  return _yearlyActiveDays;
}

@synthesize yearlyActiveDaysInv = _yearlyActiveDaysInv;
-(SHListRateItemCollection*)yearlyActiveDaysInv{
  if(nil == _yearlyActiveDaysInv){
    _yearlyActiveDaysInv = [self buildActiveDays:SH_YEARLY_RATE_INVERSE
      majorKey:SH_MONTH_KEY minorKey:SH_DAY_OF_MONTH_KEY];
  }
  return _yearlyActiveDaysInv;
}



-(NSArray<SHRangeRateItem*>*)buildWeeklyActiveDays:(BOOL)isInverse{
  SHRateType rateType = isInverse? SH_WEEKLY_RATE_INVERSE : SH_WEEKLY_RATE;
  NSMutableArray *raw = (NSMutableArray*)self.activeDaysDict[shGetRateTypeKey(rateType)];
  if(raw.count == 0){
    SHRangeRateItem *baseRateItem = [[SHRangeRateItem alloc] init];
    baseRateItem.isDayActive = YES;
    baseRateItem.forrange = 0;
    baseRateItem.backrange = 0;
    return @[baseRateItem, [baseRateItem copy],[baseRateItem copy],
      [baseRateItem copy],[baseRateItem copy],[baseRateItem copy],[baseRateItem copy]];
  }
  NSArray<SHRangeRateItem*> *mapped = [raw mapItemsTo:^id (id item,NSUInteger idx){
    (void)idx;
    NSDictionary<NSString*,NSNumber*> *dict = (NSDictionary*)item;
    SHRangeRateItem *rateItem = [[SHRangeRateItem alloc] init];
    rateItem.isDayActive = dict[SH_IS_DAY_ACTIVE_KEY].boolValue;
    rateItem.forrange = dict[SH_FORRANGE_KEY].integerValue;
    rateItem.backrange = dict[SH_BACKRANGE_KEY].integerValue;
    return rateItem;
  }];
  return mapped;
}


@synthesize weeklyActiveDays = _weeklyActiveDays;
-(NSArray<SHRangeRateItem*>*)weeklyActiveDays{
  if(nil == _weeklyActiveDays){
    _weeklyActiveDays = [self buildWeeklyActiveDays:NO];
  }
  return _weeklyActiveDays;
}

@synthesize weeklyActiveDaysInv = _weeklyActiveDaysInv;
-(NSArray<SHRangeRateItem*>*)weeklyActiveDaysInv{
  if(nil == _weeklyActiveDaysInv){
    _weeklyActiveDaysInv = [self buildWeeklyActiveDays:YES];
  }
  return _weeklyActiveDaysInv;
}


-(NSMutableDictionary *)activeDaysDict{
    if(nil==_activeDaysDict){
        _activeDaysDict = [NSMutableDictionary jsonStringToDict:_activeDays];
    }
    return _activeDaysDict;
}

-(void)setActiveFromDate:(NSDate *)activeFromDate{
  
  NSDate *roundedDate = [activeFromDate dayStart];
  BOOL isBadRange = roundedDate && self.activeToDate;
  isBadRange &= roundedDate.timeIntervalSince1970 > self.activeToDate.timeIntervalSince1970;
  if(isBadRange){
    return;
  }
  self.isTouched = YES;
  _activeFromDate = activeFromDate;
}


-(void)setActiveDays:(NSString *)activeDays{
  _activeDays = activeDays;
  _activeDaysDict = nil;
}


-(void)setActiveToDate:(NSDate *)activeToDate{
  NSDate *roundedDate = [activeToDate dayStart];
  BOOL isBadRange = roundedDate && self.activeFromDate;
  isBadRange &= roundedDate.timeIntervalSince1970 < self.activeFromDate.timeIntervalSince1970;
  if(isBadRange){
    return;
  }
  self.isTouched = YES;
  _activeToDate = activeToDate;
}


-(void)setDailyName:(NSString *)dailyName{
  self.isTouched = YES;
  _dailyName = dailyName;
}


-(void)setCustomUserOrder:(int32_t)customUserOrder{
  self.isTouched = YES;
  
  _customUserOrder = customUserOrder;
}


-(void)setCycleStartTime:(int32_t)cycleStartTime{
  if(cycleStartTime < 0){
    return;
  }
  BOOL isValid = NO;
  SHRateType baseType = shExtractBaseRateType(self.rateType);
  switch (baseType) {
    case SH_WEEKLY_RATE:
      isValid = cycleStartTime < 7;
      break;
    case SH_MONTHLY_RATE:
      isValid = cycleStartTime < 31;
      break;
    case SH_YEARLY_RATE:
      isValid = cycleStartTime < 366;
    default:
      break;
  }
  
  if(isValid){
    self.isTouched = YES;
    _cycleStartTime = cycleStartTime;
  }
}


int checkImportanceRange(int importance){
    if(importance > 10){
        return 10;
    }
    if(importance < 0){
        return 0;
    }
    return importance;
}

-(void)setDifficulty:(int32_t)difficulty{
  self.isTouched = YES;
  _difficulty = checkImportanceRange(difficulty);
}


-(void)setIsActive:(BOOL)isActive{
  self.isTouched = YES;
  _isActive = isActive;
}


-(void)setNote:(NSString *)note{
  self.isTouched = YES;
  _note = note;
}


-(void)setRate:(int32_t)rate{
/*
  examples:
  rate = 5, rate type is week:
  activates every 5th week
*/
  self.isTouched = YES;
  if(rate > 366){
      rate = 366;
  }
  if(rate < 1){
      rate = 1;
  }
  _rate = rate;
}


-(void)setRateType:(int32_t)rateType{
  self.isTouched = YES;
  _rateType = rateType;
}


-(void)setUrgency:(int32_t)urgency{
  self.isTouched = YES;
  _urgency = checkImportanceRange(urgency);
}


-(void)setStreakLength:(int32_t)streakLength{
  self.isTouched = YES;
  _streakLength = streakLength;
}


//This method is not really necessary but using it will help my flow in
//viewDidLoad so that I didn't have a weird flag in there denoting that the
//model already existed. Besides, this makes things sorta more explicit
-(void)setupDefaults{
    _activeDays = SH_ALL_DAYS_JSON;
    _rateType = SH_WEEKLY_RATE;
    _dailyName = @"";
    _difficulty = 3;
    _urgency = 3;
    _note = @"";
    _rate = 1;
    _streakLength = 0;
    _activeFromDate = nil;
    _activeToDate = nil;
    _cycleStartTime = 0;
}


static void setActivenessArray(NSArray<SHRangeRateItem*> *week,BOOL *activenessArray){
  for(int i = 0;i < SH_DAYS_IN_WEEK;i++){
        if(week){ //default to all days active
            activenessArray[i] = week[i].isDayActive;
            continue;
        }
        activenessArray[i] = YES;
    }
}


static NSMutableArray<SHRangeRateItem*>* convertCRateItemToObjC(SHRateValueItem *rvi){
  NSMutableArray *converted = [NSMutableArray array];
  for(int i = 0; i < SH_DAYS_IN_WEEK; i++){
    SHRangeRateItem *rateItem = [[SHRangeRateItem alloc] init];
    [rateItem copyFromCStruct:&rvi[i]];
    [converted addObject:rateItem];
  }
  return converted;
}


static void convertObjCRateItemToC(NSArray<SHRangeRateItem*>* rateItems, SHRateValueItem *rvi){
  for(int i = 0; i < SH_DAYS_IN_WEEK; i++){
    [rateItems[i] copyIntoCStruct:&rvi[i]];
  }
}


-(void)flipDayOfWeek:(NSUInteger)dayIdx{
  self.isTouched = YES;
  BOOL isInverse = shIsInverseRateType(self.rateType);
  NSArray<SHRangeRateItem*> *weekInfo = isInverse ? self.weeklyActiveDaysInv : self.weeklyActiveDays;
  BOOL activeDays[SH_DAYS_IN_WEEK];
  setActivenessArray(weekInfo,activeDays);
  activeDays[dayIdx] = !activeDays[dayIdx];
  SHRateValueItem rvi[SH_DAYS_IN_WEEK];
  memset(rvi,0,sizeof(SHRateValueItem) * SH_DAYS_IN_WEEK);
  shBuildWeek(activeDays,self.rate,rvi);
  NSMutableArray<SHRangeRateItem*>* updWeek = convertCRateItemToObjC(rvi);
  if(isInverse){
    _weeklyActiveDaysInv = updWeek;
  }
  else{
    _weeklyActiveDays = updWeek;
  }
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


-(NSDate *)nextDueTime_DAILY:(NSDate *)checkinDate{
    NSDate *checkinDateStart = [NSCalendar.currentCalendar startOfDayForDate:checkinDate];
    NSDate *nextDueDateStart = [checkinDateStart dateAfterYears:0 months:0 days:self.rate];
    return [nextDueDateStart timeAfterHours:self.dayStart minutes:0 seconds:0];
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
  convertObjCRateItemToC(self.weeklyActiveDays,rvi);
  shNextDueDate_WEEKLY(lastCheckinDt,checkinDt,rvi,self.rate,&ans,error);
  double dueDateTimestamp = shDtToTimestamp(&ans, error);
  NSDate *nextDueDate = [NSDate dateWithTimeIntervalSince1970:dueDateTimestamp];
  shFreeSHDatetime(lastCheckinDt);
  shFreeSHDatetime(checkinDt);
  shDisposeSHError(error);
  shFreeSHRateValueItem(rvi);
  return nextDueDate;
}



-(NSUInteger)daysUntilDue{
  NSDate *roundedDownToday = [[NSDate date] setHour:self.dayStart minute:0 second:0];
  return (int)[NSDate daysBetween:roundedDownToday to:self.nextDueTime];
}

@end
