//
//  SHDailyActiveDays.m
//  SHModels
//
//  Created by Joel Pridgen on 5/16/19.
//  Copyright © 2019 Joel Gillette. All rights reserved.
//

#import "SHDailyActiveDays.h"
#import "SHListRateItem.h"
#import "SHRateTypeHelper.h"
#import "SHModelConstants.h"
#import <SHCommon/NSDictionary+SHHelper.h>
#import <SHCommon/NSArray+SHHelper.h>
#import <SHCore_C/SHDaily_C.h>


@interface SHDailyActiveDays ()
@property (assign,nonatomic) BOOL shouldRebuildDictAndJson;
@end

@implementation SHDailyActiveDays


-(instancetype)initWithActiveDaysDict:(NSMutableDictionary*)activeDaysDict{
  if(self = [super init]){
    _activeDaysDict = activeDaysDict;
  }
  return self;
}


-(instancetype)initWithActiveDaysJson:(NSString*)activeDaysJson{
  if(self = [super init]){
    _activeDaysJson = activeDaysJson;
  }
  return self;
}


-(NSString*)activeDaysJson{
  if(nil == _activeDaysJson){
    _activeDaysJson = [_activeDaysDict dictToString];
  }
  return _activeDaysJson;
}


-(NSMutableDictionary*)activeDaysDict{
  if(nil == _activeDaysDict){
    NSString *str = _activeDaysJson ? _activeDaysJson : SH_ALL_DAYS_JSON;
    _activeDaysDict = [NSDictionary jsonStringToDict:str];
  }
  return _activeDaysDict;
}


static SHRangeRateItem* mapDictToWeekly(id item, NSUInteger idx){
  (void)idx;
  NSDictionary<NSString*,NSNumber*> *dict = (NSDictionary*)item;
  SHRangeRateItem *rateItem = [[SHRangeRateItem alloc] init];
  rateItem.isDayActive = dict[SH_IS_DAY_ACTIVE_KEY].boolValue;
  rateItem.forrange = dict[SH_FORRANGE_KEY].integerValue;
  rateItem.backrange = dict[SH_BACKRANGE_KEY].integerValue;
  return rateItem;
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
  NSArray<SHRangeRateItem*> *mapped = [raw mapItemsTo_f:mapDictToWeekly];
  return mapped;
}


static SHListRateItem* mapDictToMonthlyYearly(id item, NSUInteger idx){
  (void)idx;
  NSDictionary<NSString*,NSNumber*> *dict = (NSDictionary*)item;
  NSInteger major = dict[SH_MAJOR_ORDINAL].integerValue;
  NSInteger minor = dict[SH_MINOR_ORDINAL].integerValue;
  SHListRateItem *rateItem = [[SHListRateItem alloc]
    initWithMajorOrdinal:major
    minorOrdinal:minor];

  return rateItem;
}


-(SHListRateItemCollection*)buildActiveDays:(SHRateType)rateType{
    NSMutableArray *raw = (NSMutableArray*)self.activeDaysDict[shGetRateTypeKey(rateType)];
    NSMutableArray* mapped = [raw mapItemsTo_f:mapDictToMonthlyYearly];
    return [[SHListRateItemCollection  alloc] initWithActiveDays:mapped];
}


@synthesize monthlyActiveDays = _monthlyActiveDays;
-(SHListRateItemCollection*)monthlyActiveDays{
  if(nil == _monthlyActiveDays){
    _monthlyActiveDays = [self buildActiveDays:SH_MONTHLY_RATE];
  }
  return _monthlyActiveDays;
}


-(shGetListRateCollection)monthlyActiveDaysLazy{
  __weak typeof(self) weakSelf = self;
  return ^SHListRateItemCollection* (){
    typeof(weakSelf) bSelf = weakSelf;
    if(nil == bSelf) return nil;
    return bSelf.monthlyActiveDays;
  };
}


@synthesize monthlyActiveDaysInv = _monthlyActiveDaysInv;
-(SHListRateItemCollection*)monthlyActiveDaysInv{
  if(nil == _monthlyActiveDaysInv){
    _monthlyActiveDaysInv = [self buildActiveDays:SH_MONTHLY_RATE_INVERSE];
  }
  return _monthlyActiveDaysInv;
}


-(shGetListRateCollection)monthlyActiveDaysInvLazy{
  __weak typeof(self) weakSelf = self;
  return ^SHListRateItemCollection*(){
    typeof(weakSelf) bSelf = weakSelf;
    if(nil == bSelf) return nil;
    return bSelf.monthlyActiveDaysInv;
  };
}


@synthesize yearlyActiveDays = _yearlyActiveDays;
-(SHListRateItemCollection*)yearlyActiveDays{
  if(nil == _yearlyActiveDays){
    _yearlyActiveDays = [self buildActiveDays:SH_YEARLY_RATE];
  }
  return _yearlyActiveDays;
}


-(shGetListRateCollection)yearlyActiveDaysLazy{
  __weak typeof(self) weakSelf = self;
  return ^SHListRateItemCollection* (){
    typeof(weakSelf) bSelf = weakSelf;
    if(nil == bSelf) return nil;
    return bSelf.yearlyActiveDays;
  };
}


@synthesize yearlyActiveDaysInv = _yearlyActiveDaysInv;
-(SHListRateItemCollection*)yearlyActiveDaysInv{
  if(nil == _yearlyActiveDaysInv){
    _yearlyActiveDaysInv = [self buildActiveDays:SH_YEARLY_RATE_INVERSE];
  }
  return _yearlyActiveDaysInv;
}


-(shGetListRateCollection)yearlyActiveDaysInvLazy{
  __weak typeof(self) weakSelf = self;
  return ^SHListRateItemCollection* (){
    typeof(weakSelf) bSelf = weakSelf;
    if(nil == bSelf) return nil;
    return bSelf.yearlyActiveDaysInv;
  };
}


@synthesize weeklyActiveDays = _weeklyActiveDays;
-(NSArray<SHRangeRateItem*>*)weeklyActiveDays{
  if(nil == _weeklyActiveDays){
    _weeklyActiveDays = [self buildWeeklyActiveDays:NO];
  }
  return _weeklyActiveDays;
}


-(shGetRangeRateArray)weeklyActiveDaysLazy{
  __weak typeof(self) weakSelf = self;
  return ^NSArray<SHRangeRateItem*>* (){
    typeof(weakSelf) bSelf = weakSelf;
    if(nil == bSelf) return nil;
    return bSelf.weeklyActiveDays;
  };
}


@synthesize weeklyActiveDaysInv = _weeklyActiveDaysInv;
-(NSArray<SHRangeRateItem*>*)weeklyActiveDaysInv{
  if(nil == _weeklyActiveDaysInv){
    _weeklyActiveDaysInv = [self buildWeeklyActiveDays:YES];
  }
  return _weeklyActiveDaysInv;
}


-(shGetRangeRateArray)weeklyActiveDaysInvLazy{
  __weak typeof(self) weakSelf = self;
  return ^NSArray<SHRangeRateItem*>* (){
    typeof(weakSelf) bSelf = weakSelf;
    if(nil == bSelf) return nil;
    return bSelf.weeklyActiveDaysInv;
  };
}


-(int32_t)weeklyIntervalSize{
  int32_t size = ((NSNumber *)self.activeDaysDict[@"weeklyInterval"]).intValue;
  return size;
}


-(void)setWeeklyIntervalSize:(int32_t)weeklyIntervalSize{
  self.activeDaysDict[@"weeklyInterval"] = @(weeklyIntervalSize);
}


-(int32_t)monthlyIntervalSize{
  return ((NSNumber *)self.activeDaysDict[@"monthlyInterval"]).intValue;
}


-(void)setMonthlyIntervalSize:(int32_t)monthlyIntervalSize{
  self.activeDaysDict[@"monthlyInterval"] = @(monthlyIntervalSize);
}


-(int32_t)yearlyIntervalSize{
  return ((NSNumber *)self.activeDaysDict[@"yearlyInterval"]).intValue;
}


-(void)setYearlyIntervalSize:(int32_t)yearlyIntervalSize{
  self.activeDaysDict[@"yearlyInterval"] = @(yearlyIntervalSize);
}


-(int32_t)weeklyIntervalSizeInv{
  return ((NSNumber *)self.activeDaysDict[@"weeklyIntervalInv"]).intValue;
}


-(void)setWeeklyIntervalSizeInv:(int32_t)weeklyIntervalSizeInv{
  self.activeDaysDict[@"weeklyIntervalInv"] = @(weeklyIntervalSizeInv);
}


-(int32_t)monthlyIntervalSizeInv{
  return ((NSNumber *)self.activeDaysDict[@"monthlyIntervalInv"]).intValue;
}


-(void)setMonthlyIntervalSizeInv:(int32_t)monthlyIntervalSizeInv{
  self.activeDaysDict[@"monthlyIntervalInv"] = @(monthlyIntervalSizeInv);
}


-(int32_t)yearlyIntervalSizeInv{
  return ((NSNumber *)self.activeDaysDict[@"yearlyIntervalInv"]).intValue;
}


-(void)setYearlyIntervalSizeInv:(int32_t)yearlyIntervalSizeInv{
  self.activeDaysDict[@"yearlyIntervalInv"] = @(yearlyIntervalSizeInv);
}


-(int32_t)dailyIntervalSize{
  return ((NSNumber *)self.activeDaysDict[@"dailyInterval"]).intValue;
}


-(void)setDailyIntervalSize:(int32_t)dailyIntervalSize{
  self.activeDaysDict[@"dailyInterval"] = @(dailyIntervalSize);
}


-(int32_t)dailyIntervalSizeInv{
  return ((NSNumber *)self.activeDaysDict[@"dailyIntervalInv"]).intValue;
}


-(void)setDailyIntervalSizeInv:(int32_t)dailyIntervalSizeInv{
  self.activeDaysDict[@"dailyIntervalInv"] = @(dailyIntervalSizeInv);
}

-(void)rebuildDictAndJson{
  if(self.shouldRebuildDictAndJson){
    self.activeDaysDict = [self buildDict];
    self.activeDaysJson = [self.activeDaysDict dictToString];
    self.shouldRebuildDictAndJson = NO;
  }
}


static NSDictionary* mapWeeklyToDict(id item,NSUInteger idx){
  (void)idx;
  SHRangeRateItem *rateItem = (SHRangeRateItem*)item;
  SHRateItemDict *dict = @{
    SH_IS_DAY_ACTIVE_KEY : @(rateItem.isDayActive),
    SH_FORRANGE_KEY : @(rateItem.forrange),
    SH_BACKRANGE_KEY : @(rateItem.backrange)
  };
  return dict;
}


static NSDictionary* mapMonthlyYearlyToDict(SHListRateItem *item,NSUInteger idx){
  (void)idx;
  SHRateItemDict *dict = @{
    SH_MAJOR_ORDINAL : @(item.majorOrdinal),
    SH_MINOR_ORDINAL : @(item.minorOrdinal)
  };
  return dict;
}

-(NSMutableDictionary*)buildDict{
  //using the direct instance variables and checking for null
  //because if I've not changed a sub section, I don't want to
  //map it to an object just to remap it back to a dictionary
  NSMutableArray<SHRateItemDict*>* weekly = _weeklyActiveDays ?
    [_weeklyActiveDays mapItemsTo_f:mapWeeklyToDict] :
    _activeDaysDict[shGetRateTypeKey(SH_WEEKLY_RATE)];
  NSMutableArray<SHRateItemDict*>* monthly = _monthlyActiveDays ?
    [_monthlyActiveDays mapItemsTo_f:mapMonthlyYearlyToDict] :
    _activeDaysDict[shGetRateTypeKey(SH_MONTHLY_RATE)];
  NSMutableArray<SHRateItemDict*>* yearly = _yearlyActiveDays ?
    [_yearlyActiveDays mapItemsTo_f:mapMonthlyYearlyToDict] :
    _activeDaysDict[shGetRateTypeKey(SH_YEARLY_RATE)];
  
  NSMutableArray<SHRateItemDict*>* weeklyInv = _weeklyActiveDaysInv ?
    [_weeklyActiveDaysInv mapItemsTo_f:mapWeeklyToDict]:
    _activeDaysDict[shGetRateTypeKey(SH_WEEKLY_RATE_INVERSE)];
  NSMutableArray<SHRateItemDict*>* monthlyInv = _monthlyActiveDaysInv ?
    [_monthlyActiveDaysInv mapItemsTo_f:mapMonthlyYearlyToDict] :
    _activeDaysDict[shGetRateTypeKey(SH_MONTHLY_RATE_INVERSE)];
  NSMutableArray<SHRateItemDict*>* yearlyInv = _yearlyActiveDaysInv ?
    [_yearlyActiveDaysInv mapItemsTo_f:mapMonthlyYearlyToDict] :
    _activeDaysDict[shGetRateTypeKey(SH_YEARLY_RATE_INVERSE)];
  
  NSMutableDictionary *dict = [NSMutableDictionary
    dictionaryWithObjects:@[
      weekly,monthly,yearly,
      weeklyInv,monthlyInv,yearlyInv
    ]
    forKeys:@[
      shGetRateTypeKey(SH_WEEKLY_RATE),shGetRateTypeKey(SH_MONTHLY_RATE),
      shGetRateTypeKey(SH_YEARLY_RATE),shGetRateTypeKey(SH_WEEKLY_RATE_INVERSE),
      shGetRateTypeKey(SH_MONTHLY_RATE_INVERSE),shGetRateTypeKey(SH_YEARLY_RATE_INVERSE)
    ]];
    
    return dict;
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


-(void)flipDayOfWeek:(NSUInteger)dayIdx forPolarity:(BOOL)isInverse{
  NSArray<SHRangeRateItem*> *weekInfo = isInverse ? self.weeklyActiveDaysInv : self.weeklyActiveDays;
  int32_t rate = isInverse ? self.weeklyIntervalSizeInv : self.weeklyIntervalSize;
  BOOL activeDays[SH_DAYS_IN_WEEK];
  setActivenessArray(weekInfo,activeDays);
  activeDays[dayIdx] = !activeDays[dayIdx];
  SHRateValueItem rvi[SH_DAYS_IN_WEEK];
  memset(rvi,0,sizeof(SHRateValueItem) * SH_DAYS_IN_WEEK);
  shBuildWeek(activeDays,rate,rvi);
  NSMutableArray<SHRangeRateItem*>* updWeek = convertCRateItemToObjC(rvi);
  if(isInverse){
    _weeklyActiveDaysInv = updWeek;
  }
  else{
    _weeklyActiveDays = updWeek;
  }
}

@end
