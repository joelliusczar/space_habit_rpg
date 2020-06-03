//
//  SHRateTypeHelper.h
//  HabitRPG2
//
//  Created by Joel Pridgen on 9/4/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#ifndef SHIntervalTypeHelper_h
#define SHIntervalTypeHelper_h

#import "SHModelConstants.h"
#import "SHDBDueDateConstants.h"


SHIntervalType SH_extractBaseIntervalType(SHIntervalType rateType);
SHIntervalType SH_invertRateType(SHIntervalType rateType);
bool SH_isInverseRateType(SHIntervalType rateType);
bool SH_areSameBaseIntervalTypes(SHIntervalType a, SHIntervalType b);
SHIntervalType SH_setIntervalTypeInversion(SHIntervalType rateType, bool isInverse);
#endif /* SHIntervalTypeHelper_h */

