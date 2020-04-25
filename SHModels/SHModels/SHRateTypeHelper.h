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


SHRateType shExtractBaseRateType(SHRateType rateType);
SHRateType shInvertRateType(SHRateType rateType);
BOOL shIsInverseRateType(SHRateType rateType);
BOOL shAreSameBaseRateTypes(SHRateType a,SHRateType b);
NSString* shGetRateTypeKey(SHRateType rateType);
NSString* shGetRateTypeIntervalSizeKey(SHRateType rateType);
SHRateType shSetRateTypeInversion(SHRateType rateType,BOOL isInverse);
BOOL shAreMonthlyRateValueItemsEqual(SHItervalItemDict *a,SHItervalItemDict *b);
BOOL shAreYearlyRateValueItemsEqual(SHItervalItemDict *a,SHItervalItemDict *b);
NSString * shGetFormatString(SHRateType rateType, NSInteger rate);
NSString * shGetRateUnitName(SHRateType rateType,BOOL isPlural);
NSArray<NSString *>* shRateTypeEnums(void);
#endif /* RateTypeHelper_h */

