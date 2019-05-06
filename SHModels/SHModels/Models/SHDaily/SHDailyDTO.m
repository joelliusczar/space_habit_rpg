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

@implementation SHDailyDTO


-(id)copyWithZone:(NSZone *)zone{
  (void)zone;
  return [self dtoCopy];
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

@end
