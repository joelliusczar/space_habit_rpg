//
//	RateTypeHelper.c
//	HabitRPG2
//
//	Created by Joel Pridgen on 9/4/17.
//	Copyright © 2017 Joel Pridgen. All rights reserved.
//

#include "SHRateTypeHelper.h"
//
SHIntervalType shExtractBaseRateType(SHIntervalType rateType){
	return rateType&~SH_INVERSE_INTERVAL_MODIFIER;
}


SHIntervalType shInvertRateType(SHIntervalType rateType){
	return rateType^SH_INVERSE_INTERVAL_MODIFIER;
}


BOOL shIsInverseRateType(SHIntervalType rateType){
	return (rateType&SH_INVERSE_INTERVAL_MODIFIER);
}


BOOL shAreSameBaseRateTypes(SHIntervalType a,SHIntervalType b){
	return shExtractBaseRateType(a) == shExtractBaseRateType(b);
}


NSString* shGetRateTypeIntervalSizeKey(SHIntervalType rateType){
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
		@throw [NSException exceptionWithName:@"can't go there" reason:@"I didn't know the code could go here" userInfo:nil];
	
	}
}


NSString* shGetRateTypeKey(SHIntervalType rateType){
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


SHIntervalType shSetRateTypeInversion(SHIntervalType rateType,BOOL isInverse){
	if(isInverse){
		return rateType|SH_INVERSE_INTERVAL_MODIFIER;
	}
	return rateType&~SH_INVERSE_INTERVAL_MODIFIER;
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
	SHIntervalType baseType = shExtractBaseRateType(rateType);
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


NSString * shGetFormatString(SHIntervalType rateType, NSInteger rate){
	switch(rateType){
	case SH_DAILY_INTERVAL:
		return rate==1?@"Triggers every day":@"Triggers every %d days";
	case SH_WEEKLY_INTERVAL:
		return rate==1?@"Triggers every week":@"Triggers every %d weeks";
	case SH_MONTHLY_INTERVAL:
		return rate==1?@"Triggers every month":@"Triggers every %d months";
	case SH_YEARLY_INTERVAL:
		return rate==1?@"Triggers every year":@"Triggers every %d years";
	case SH_DAILY_INTERVAL_INVERSE:
		return rate==1?@"Skips every day":@"Skips every %d days";
	case SH_WEEKLY_INTERVAL_INVERSE:
		return rate==1?@"Skips checked days every week":@"Skips checked days every %d weeks";
	case SH_MONTHLY_INTERVAL_INVERSE:
		return rate==1?@"Skips every month":@"Skips every %d months";
	case SH_YEARLY_INTERVAL_INVERSE:
		return rate==1?@"Skips every year":@"Skips every %d years";
	case SH_UNDETERMINED_INTERVAL:
		return @"You've reached an invalid state";
	}
}

NSArray<NSString *>* shRateTypeEnums() {
	return @[
			shGetRateTypeKey(SH_WEEKLY_INTERVAL), //0
			shGetRateTypeKey(SH_MONTHLY_INTERVAL), //1
			shGetRateTypeKey(SH_YEARLY_INTERVAL), //2
			shGetRateTypeKey(SH_WEEKLY_INTERVAL_INVERSE), //3
			shGetRateTypeKey(SH_MONTHLY_INTERVAL_INVERSE), //4
			shGetRateTypeKey(SH_YEARLY_INTERVAL_INVERSE), //5
			shGetRateTypeIntervalSizeKey(SH_DAILY_INTERVAL), //6
			shGetRateTypeIntervalSizeKey(SH_WEEKLY_INTERVAL), //7
			shGetRateTypeIntervalSizeKey(SH_MONTHLY_INTERVAL), //8
			shGetRateTypeIntervalSizeKey(SH_YEARLY_INTERVAL), //9
			shGetRateTypeIntervalSizeKey(SH_DAILY_INTERVAL_INVERSE), //10
			shGetRateTypeIntervalSizeKey(SH_WEEKLY_INTERVAL_INVERSE), //11
			shGetRateTypeIntervalSizeKey(SH_MONTHLY_INTERVAL_INVERSE), //12
			shGetRateTypeIntervalSizeKey(SH_YEARLY_INTERVAL_INVERSE), //13
		];
}
