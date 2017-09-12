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


NSString* getRateTypeKey(RateType rateType){
    switch(rateType){
        case WEEKLY_RATE:
            return @"daysOfWeek";
        case WEEKLY_RATE_INVERSE:
            return @"daysOfWeek_INV";
        case MONTHLY_RATE:
            return @"daysOfMonth";
        case MONTHLY_RATE_INVERSE:
            return @"daysOfMonth_INV";
        case YEARLY_RATE:
            return @"daysOfYear";
        case YEARLY_RATE_INVERSE:
            return @"daysOfYear_INV";
        case DAILY_RATE:
        case DAILY_RATE_INVERSE:
            @throw [NSException exceptionWithName:@"can't go there" reason:@"I didn't know the code could go here" userInfo:nil];
        DEFAULT:
            return @"";
    }
}


RateType setRateTypeInversion(RateType rateType,BOOL isInverse){
    if(isInverse){
        return rateType|INVERSE_RATE_MODIFIER;
    }
    return rateType&~INVERSE_RATE_MODIFIER;
}


BOOL areMonthlyRateValueItemsEqual(RateValueItemDict *a,RateValueItemDict *b){
    return a[ORDINAL_WEEK_KEY].integerValue == b[ORDINAL_WEEK_KEY].integerValue &&
            a[DAY_OF_WEEK_KEY].integerValue == b[DAY_OF_WEEK_KEY].integerValue;
}


BOOL areYearlyRateValueItemsEqual(RateValueItemDict *a,RateValueItemDict *b){
    return a[MONTH_KEY].integerValue == b[MONTH_KEY].integerValue &&
            a[DAY_OF_MONTH_KEY].integerValue == b[DAY_OF_MONTH_KEY].integerValue;
}


NSString * getFormatString(RateType rateType, NSInteger rate){
    switch(rateType){
        case DAILY_RATE:
        return rate==1?@"Triggers every day":@"Triggers every %d days";
        case WEEKLY_RATE:
        return rate==1?@"Triggers every week":@"Triggers every %d weeks";
        case MONTHLY_RATE:
        return rate==1?@"Triggers every month":@"Triggers every %d months";
        case YEARLY_RATE:
        return rate==1?@"Triggers every year":@"Triggers every %d years";
        case DAILY_RATE_INVERSE:
        return rate==1?@"Skips every day":@"Skips every %d days";
        case WEEKLY_RATE_INVERSE:
        return rate==1?@"Skips checked days every week":@"Skips checked days every %d weeks";
        case MONTHLY_RATE_INVERSE:
        return rate==1?@"Skips every month":@"Skips every %d months";
        case YEARLY_RATE_INVERSE:
        return rate==1?@"Skips every year":@"Skips every %d years";
    }
}
