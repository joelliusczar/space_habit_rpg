//
//  RateTypeHelper.h
//  HabitRPG2
//
//  Created by Joel Pridgen on 9/4/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#ifndef RateTypeHelper_h
#define RateTypeHelper_h

#include "constants.h"

RateType extractBaseRateType(RateType rateType);
RateType invertRateType(RateType rateType);
BOOL isInverseRateType(RateType rateType);
BOOL areSameBaseRateTypes(RateType a,RateType b);

#endif /* RateTypeHelper_h */
