//
//  RateTypeHelper.c
//  HabitRPG2
//
//  Created by Joel Pridgen on 9/4/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#include "RateTypeHelper.h"
//
RateType extractBaseRateType(RateType rateType){
    return rateType&~INVERSE_RATE_MODIFIER;
}


RateType invertRateType(RateType rateType){
    return rateType^INVERSE_RATE_MODIFIER;
}


BOOL isInverseRateType(RateType rateType){
    return (rateType&INVERSE_RATE_MODIFIER);
}


BOOL areSameBaseRateTypes(RateType a,RateType b){
    return extractBaseRateType(a) == extractBaseRateType(b);
}
