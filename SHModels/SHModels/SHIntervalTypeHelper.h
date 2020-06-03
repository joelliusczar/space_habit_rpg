//
//  SHRateTypeHelper.h
//  HabitRPG2
//
//  Created by Joel Pridgen on 9/4/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#ifndef SHIntervalTypeHelper_h
#define SHIntervalTypeHelper_h

@import SHCommon;
#import "SHModelConstants.h"
#import "SHDBDueDateConstants.h"


SHIntervalType SH_extractBaseIntervalType(SHIntervalType rateType);
SHIntervalType SH_invertRateType(SHIntervalType rateType);
BOOL SH_isInverseRateType(SHIntervalType rateType);
BOOL SH_areSameBaseIntervalTypes(SHIntervalType a,SHIntervalType b);
NSString* SH_getIntervalTypeKey(SHIntervalType rateType);
NSString* SH_getIntervalTypeIntervalSizeKey(SHIntervalType rateType);
SHIntervalType SH_setIntervalTypeInversion(SHIntervalType rateType,BOOL isInverse);
BOOL shAreMonthlyRateValueItemsEqual(SHItervalItemDict *a,SHItervalItemDict *b);
BOOL shAreYearlyRateValueItemsEqual(SHItervalItemDict *a,SHItervalItemDict *b);
NSString * shGetRateUnitName(SHIntervalType rateType,BOOL isPlural);
NSArray<NSString *>* shRateTypeEnums(void);
#endif /* SHIntervalTypeHelper_h */

