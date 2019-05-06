//
//  SHRateTypeHelper.h
//  HabitRPG2
//
//  Created by Joel Pridgen on 9/4/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#ifndef RateTypeHelper_h
#define RateTypeHelper_h

#import <SHGlobal/SHConstants.h>
#import "SHModelConstants.h"

SHRateType shExtractBaseRateType(SHRateType rateType);
SHRateType shInvertRateType(SHRateType rateType);
BOOL shIsInverseRateType(SHRateType rateType);
BOOL shAreSameBaseRateTypes(SHRateType a,SHRateType b);
NSString* shGetRateTypeKey(SHRateType rateType);
SHRateType shSetRateTypeInversion(SHRateType rateType,BOOL isInverse);
BOOL shAreMonthlyRateValueItemsEqual(SHRateValueItemDict *a,SHRateValueItemDict *b);
BOOL shAreYearlyRateValueItemsEqual(SHRateValueItemDict *a,SHRateValueItemDict *b);
NSString * shGetFormatString(SHRateType rateType, NSInteger rate);
NSString * shGetRateUnitName(SHRateType rateType,BOOL isPlural);
#endif /* RateTypeHelper_h */

