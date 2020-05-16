//
//  SHRateTypeHelper.h
//  HabitRPG2
//
//  Created by Joel Pridgen on 9/4/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#ifndef RateTypeHelper_h
#define RateTypeHelper_h

@import SHCommon;
#import "SHModelConstants.h"


SHIntervalType shExtractBaseRateType(SHIntervalType rateType);
SHIntervalType shInvertRateType(SHIntervalType rateType);
BOOL shIsInverseRateType(SHIntervalType rateType);
BOOL shAreSameBaseRateTypes(SHIntervalType a,SHIntervalType b);
NSString* shGetRateTypeKey(SHIntervalType rateType);
NSString* shGetRateTypeIntervalSizeKey(SHIntervalType rateType);
SHIntervalType shSetRateTypeInversion(SHIntervalType rateType,BOOL isInverse);
BOOL shAreMonthlyRateValueItemsEqual(SHItervalItemDict *a,SHItervalItemDict *b);
BOOL shAreYearlyRateValueItemsEqual(SHItervalItemDict *a,SHItervalItemDict *b);
NSString * shGetFormatString(SHIntervalType rateType, NSInteger rate);
NSString * shGetRateUnitName(SHIntervalType rateType,BOOL isPlural);
NSArray<NSString *>* shRateTypeEnums(void);
#endif /* RateTypeHelper_h */

