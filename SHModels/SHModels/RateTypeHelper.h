//
//  RateTypeHelper.h
//  HabitRPG2
//
//  Created by Joel Pridgen on 9/4/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#ifndef RateTypeHelper_h
#define RateTypeHelper_h

#include <SHGlobal/Constants.h>


RateType extractBaseRateType(RateType rateType);
RateType invertRateType(RateType rateType);
BOOL isInverseRateType(RateType rateType);
BOOL areSameBaseRateTypes(RateType a,RateType b);
NSString* getRateTypeKey(RateType rateType);
RateType setRateTypeInversion(RateType rateType,BOOL isInverse);
BOOL areMonthlyRateValueItemsEqual(RateValueItemDict *a,RateValueItemDict *b);
BOOL areYearlyRateValueItemsEqual(RateValueItemDict *a,RateValueItemDict *b);
NSString * getFormatString(RateType rateType, NSInteger rate);
#endif /* RateTypeHelper_h */
