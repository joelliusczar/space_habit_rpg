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
	return rateType&~SH_INVERSE_INTERVAL_MODIFIER;
}


SHIntervalType SH_invertRateType(SHIntervalType rateType){
	return rateType^SH_INVERSE_INTERVAL_MODIFIER;
}


BOOL SH_isInverseRateType(SHIntervalType rateType){
	return (rateType & SH_INVERSE_INTERVAL_MODIFIER);
}


BOOL SH_areSameBaseIntervalTypes(SHIntervalType a,SHIntervalType b){
	return SH_extractBaseIntervalType(a) == SH_extractBaseIntervalType(b);
}


NSString* SH_getIntervalTypeIntervalSizeKey(SHIntervalType rateType){
	switch(rateType){
	case SH_WEEKLY_INTERVAL:
		return @"weeklyInterval";
	case SH_WEEKLY_INTERVAL_INVERSE:
		return @"weeklyIntervalInv";
	case SH_MONTHLY_INTERVAL:
		return @"monthlyInterval";
	case SH_MONTHLY_INTERVAL_INVERSE:
		return @"monthlyIntervalInv";
	case SH_YEARLY_INTERVAL:
		return @"yearlyInterval";
	case SH_YEARLY_INTERVAL_INVERSE:
		return @"yearlyIntervalInv";
	case SH_DAILY_INTERVAL:
		return @"dailyInterval";
	case SH_DAILY_INTERVAL_INVERSE:
		return @"dailyIntervalInv";
	case SH_UNDETERMINED_INTERVAL:
		@throw [NSException exceptionWithName:@"can't go there"
			reason:@"I didn't know the code could go here" userInfo:nil];
	
	}
}


NSString* SH_getIntervalTypeKey(SHIntervalType rateType){
	switch(rateType){
	case SH_WEEKLY_INTERVAL:
		return @"daysOfWeek";
	case SH_WEEKLY_INTERVAL_INVERSE:
		return @"daysOfWeek_INV";
	case SH_MONTHLY_INTERVAL:
		return @"daysOfMonth";
	case SH_MONTHLY_INTERVAL_INVERSE:
		return @"daysOfMonth_INV";
	case SH_YEARLY_INTERVAL:
		return @"daysOfYear";
	case SH_YEARLY_INTERVAL_INVERSE:
		return @"daysOfYear_INV";
	case SH_DAILY_INTERVAL:
	case SH_DAILY_INTERVAL_INVERSE:
	case SH_UNDETERMINED_INTERVAL:
		@throw [NSException exceptionWithName:@"can't go there" reason:@"I didn't know the code could go here" userInfo:nil];
	
	}
}


SHIntervalType SH_setIntervalTypeInversion(SHIntervalType rateType,BOOL isInverse){
	if(isInverse){
		return rateType | SH_INVERSE_INTERVAL_MODIFIER;
	}
	return rateType & ~SH_INVERSE_INTERVAL_MODIFIER;
}


BOOL shAreMonthlyRateValueItemsEqual(SHItervalItemDict *a,SHItervalItemDict *b){
	return a[SH_ORDINAL_WEEK_KEY].integerValue == b[SH_ORDINAL_WEEK_KEY].integerValue &&
			a[SH_DAY_OF_WEEK_KEY].integerValue == b[SH_DAY_OF_WEEK_KEY].integerValue;
}


BOOL shAreYearlyRateValueItemsEqual(SHItervalItemDict *a,SHItervalItemDict *b){
	return a[SH_MONTH_KEY].integerValue == b[SH_MONTH_KEY].integerValue &&
		a[SH_DAY_OF_MONTH_KEY].integerValue == b[SH_DAY_OF_MONTH_KEY].integerValue;
}


NSString * shGetRateUnitName(SHIntervalType rateType,BOOL isPlural){
	SHIntervalType baseType = SH_extractBaseIntervalType(rateType);
	switch (baseType) {
	case SH_DAILY_INTERVAL:
		return isPlural ? @"days" : @"day";
	case SH_WEEKLY_INTERVAL:
		return isPlural ? @"weeks" : @"week";
	case SH_YEARLY_INTERVAL:
		return isPlural ? @"years" : @"year";
	default:
		return @"gibberish";
	}
}


NSArray<NSString *>* shRateTypeEnums() {
	return @[
			SH_getIntervalTypeKey(SH_WEEKLY_INTERVAL), //0
			SH_getIntervalTypeKey(SH_MONTHLY_INTERVAL), //1
			SH_getIntervalTypeKey(SH_YEARLY_INTERVAL), //2
			SH_getIntervalTypeKey(SH_WEEKLY_INTERVAL_INVERSE), //3
			SH_getIntervalTypeKey(SH_MONTHLY_INTERVAL_INVERSE), //4
			SH_getIntervalTypeKey(SH_YEARLY_INTERVAL_INVERSE), //5
			SH_getIntervalTypeIntervalSizeKey(SH_DAILY_INTERVAL), //6
			SH_getIntervalTypeIntervalSizeKey(SH_WEEKLY_INTERVAL), //7
			SH_getIntervalTypeIntervalSizeKey(SH_MONTHLY_INTERVAL), //8
			SH_getIntervalTypeIntervalSizeKey(SH_YEARLY_INTERVAL), //9
			SH_getIntervalTypeIntervalSizeKey(SH_DAILY_INTERVAL_INVERSE), //10
			SH_getIntervalTypeIntervalSizeKey(SH_WEEKLY_INTERVAL_INVERSE), //11
			SH_getIntervalTypeIntervalSizeKey(SH_MONTHLY_INTERVAL_INVERSE), //12
			SH_getIntervalTypeIntervalSizeKey(SH_YEARLY_INTERVAL_INVERSE), //13
		];
}
