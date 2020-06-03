//
//	RateTypeHelper.c
//	HabitRPG2
//
//	Created by Joel Pridgen on 9/4/17.
//	Copyright © 2017 Joel Pridgen. All rights reserved.
//

#include "SHIntervalTypeHelper.h"
//
SHIntervalType SH_extractBaseIntervalType(SHIntervalType rateType){
	return rateType & ~SH_INVERSE_INTERVAL_MODIFIER;
}


SHIntervalType SH_invertRateType(SHIntervalType rateType){
	return rateType ^ SH_INVERSE_INTERVAL_MODIFIER;
}


bool SH_isInverseRateType(SHIntervalType rateType){
	return (rateType & SH_INVERSE_INTERVAL_MODIFIER);
}


bool SH_areSameBaseIntervalTypes(SHIntervalType a,SHIntervalType b){
	return SH_extractBaseIntervalType(a) == SH_extractBaseIntervalType(b);
}


SHIntervalType SH_setIntervalTypeInversion(SHIntervalType rateType, bool isInverse){
	if(isInverse){
		return rateType | SH_INVERSE_INTERVAL_MODIFIER;
	}
	return rateType & ~SH_INVERSE_INTERVAL_MODIFIER;
}


