//
//  RateTypeHelper.c
//  HabitRPG2
//
//  Created by Joel Pridgen on 9/4/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#include "SHRateTypeHelper.h"
//
SHRateType shExtractBaseRateType(SHRateType rateType){
    return rateType&~SH_INVERSE_RATE_MODIFIER;
}


SHRateType shInvertRateType(SHRateType rateType){
    return rateType^SH_INVERSE_RATE_MODIFIER;
}


BOOL shIsInverseRateType(SHRateType rateType){
    return (rateType&SH_INVERSE_RATE_MODIFIER);
}


BOOL shAreSameBaseRateTypes(SHRateType a,SHRateType b){
    return shExtractBaseRateType(a) == shExtractBaseRateType(b);
}


NSString* shGetRateTypeKey(SHRateType rateType){
  switch(rateType){
    case SH_WEEKLY_RATE:
      return @"daysOfWeek";
    case SH_WEEKLY_RATE_INVERSE:
      return @"daysOfWeek_INV";
    case SH_MONTHLY_RATE:
      return @"daysOfMonth";
    case SH_MONTHLY_RATE_INVERSE:
      return @"daysOfMonth_INV";
    case SH_YEARLY_RATE:
      return @"daysOfYear";
    case SH_YEARLY_RATE_INVERSE:
      return @"daysOfYear_INV";
    case SH_DAILY_RATE:
    case SH_UNDETERMINED_RATE:
    case SH_DAILY_RATE_INVERSE:
        @throw [NSException exceptionWithName:@"can't go there" reason:@"I didn't know the code could go here" userInfo:nil];
    
  }
}


SHRateType shSetRateTypeInversion(SHRateType rateType,BOOL isInverse){
    if(isInverse){
        return rateType|SH_INVERSE_RATE_MODIFIER;
    }
    return rateType&~SH_INVERSE_RATE_MODIFIER;
}


BOOL shAreMonthlyRateValueItemsEqual(SHRateItemDict *a,SHRateItemDict *b){
    return a[SH_ORDINAL_WEEK_KEY].integerValue == b[SH_ORDINAL_WEEK_KEY].integerValue &&
            a[SH_DAY_OF_WEEK_KEY].integerValue == b[SH_DAY_OF_WEEK_KEY].integerValue;
}


BOOL shAreYearlyRateValueItemsEqual(SHRateItemDict *a,SHRateItemDict *b){
    return a[SH_MONTH_KEY].integerValue == b[SH_MONTH_KEY].integerValue &&
            a[SH_DAY_OF_MONTH_KEY].integerValue == b[SH_DAY_OF_MONTH_KEY].integerValue;
}


NSString * shGetRateUnitName(SHRateType rateType,BOOL isPlural){
  SHRateType baseType = shExtractBaseRateType(rateType);
  switch (baseType) {
    case SH_DAILY_RATE:
      return isPlural ? @"days" : @"day";
      break;
    case SH_WEEKLY_RATE:
      return isPlural ? @"weeks" : @"week";
    case SH_YEARLY_RATE:
      return isPlural ? @"years" : @"year";
    default:
      return @"gibberish";
  }
}


NSString * shGetFormatString(SHRateType rateType, NSInteger rate){
  switch(rateType){
    case SH_DAILY_RATE:
      return rate==1?@"Triggers every day":@"Triggers every %d days";
    case SH_WEEKLY_RATE:
      return rate==1?@"Triggers every week":@"Triggers every %d weeks";
    case SH_MONTHLY_RATE:
      return rate==1?@"Triggers every month":@"Triggers every %d months";
    case SH_YEARLY_RATE:
      return rate==1?@"Triggers every year":@"Triggers every %d years";
    case SH_DAILY_RATE_INVERSE:
      return rate==1?@"Skips every day":@"Skips every %d days";
    case SH_WEEKLY_RATE_INVERSE:
      return rate==1?@"Skips checked days every week":@"Skips checked days every %d weeks";
    case SH_MONTHLY_RATE_INVERSE:
      return rate==1?@"Skips every month":@"Skips every %d months";
    case SH_YEARLY_RATE_INVERSE:
      return rate==1?@"Skips every year":@"Skips every %d years";
    case SH_UNDETERMINED_RATE:
      return @"You've reached an invalid state";
  }
}
