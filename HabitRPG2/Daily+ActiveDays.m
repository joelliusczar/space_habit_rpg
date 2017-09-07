//
//  Daily+ActiveDays.m
//  HabitRPG2
//
//  Created by Joel Pridgen on 9/4/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import "Daily+ActiveDays.h"
#import "RateTypeHelper.h"
#import "NSMutableArray+Helper.h"

@implementation Daily (ActiveDays)


bestMatchPredicate monthlyBestMatch = ^BOOL(RateValueItemDict *a,RateValueItemDict *b){
    
    NSInteger ordinalA = a[ORDINAL_KEY].integerValue;
    NSInteger ordinalB = b[ORDINAL_KEY].integerValue;
    
    NSInteger dayOfWeekA = a[DAYS_OF_WEEK_KEY].integerValue;
    NSInteger dayOfWeekB = b[DAYS_OF_WEEK_KEY].integerValue;
    
    return ordinalA < ordinalB || (ordinalA == ordinalB && dayOfWeekA <= dayOfWeekB);
};


bestMatchPredicate yearlyBestMatch = ^BOOL(RateValueItemDict *a,RateValueItemDict *b){
    
    NSInteger monthA = a[MONTH_KEY].integerValue;
    NSInteger monthB = b[MONTH_KEY].integerValue;
    
    NSInteger dayOfMonthA = a[DAYS_OF_MONTH_KEY].integerValue;
    NSInteger dayOfMonthB = b[DAYS_OF_MONTH_KEY].integerValue;
    
    return monthA < monthB || (monthA == monthB && dayOfMonthA <= dayOfMonthB);
};


-(NSMutableArray<RateValueItemDict *> * )getActiveDaysForRateType:(RateType)rateType{
    NSString *rateTypeKey = getRateTypeKey(rateType);
    NSMutableArray *activeDays = self.activeDaysDict[rateTypeKey];
    if(!activeDays){
        if(rateType == WEEKLY_RATE){
            NSMutableDictionary *week = [self createActiveDaysWeek:YES];
            activeDays = [NSMutableArray arrayWithObject:week];
        }
        else if(rateType == WEEKLY_RATE_INVERSE){
            NSMutableDictionary *week = [self createActiveDaysWeek:NO];
            activeDays = [NSMutableArray arrayWithObject:week];
        }
        else{
            activeDays = [NSMutableArray array];
        }
        self.activeDaysDict[rateTypeKey] = activeDays;
    }
    return activeDays;
}

    
-(NSMutableDictionary *)createActiveDaysWeek:(BOOL)areActive{
    NSNumber *activeness = [NSNumber numberWithBool:areActive];
    return [NSMutableDictionary dictionaryWithObjectsAndKeys:
            @"SUN",activeness
            ,@"MON",activeness
            ,@"TUE",activeness
            ,@"WED",activeness
            ,@"THR",activeness
            ,@"FRI",activeness
            ,@"SAT",activeness
            ,nil];
}


-(void)setActiveDay:(ActiveDaysTriKey *)triKey withValue:(NSNumber *)value{
    NSArray *array = [self getActiveDaysForRateType:triKey.rateType];
    NSMutableDictionary *dict = array[triKey.index];
    dict[triKey.key] = value;
}
  
    
-(BOOL)flipDayOfWeek_w:(NSString *)key setTo:(BOOL)isOn for:(BOOL)isInverse{
    RateType rateType = isInverse?WEEKLY_RATE_INVERSE:WEEKLY_RATE;
    ActiveDaysTriKey *triKey = [[ActiveDaysTriKey alloc] initWithRateType:rateType key:key index:0];
    [self setActiveDay:triKey withValue:[NSNumber numberWithBool:isOn]];
    return isOn;
}

    
-(void)addActiveDay:(RateType)rateType withValues:(NSDictionary *)values{
    NSMutableArray *activeDays = [self getActiveDaysForRateType:rateType];
    [activeDays addObject:values];
}


-(NSInteger)addMonthlyItem:(BOOL)isInverse ordinal:(NSInteger)ordinal dayOfWeekNum:(NSInteger)weekdayNum{

    RateValueItemDict *monthlyItem = [NSDictionary dictionaryWithObjectsAndKeys:
                                 ORDINAL_KEY,[NSNumber numberWithInteger:ordinal]
                                 ,DAYS_OF_WEEK_KEY,[NSNumber numberWithInteger:weekdayNum]
                                 ,nil];
    RateType rateType = setRateTypeInversion(MONTHLY_RATE,isInverse);
    NSMutableArray<RateValueItemDict *> *activeDays = [self getActiveDaysForRateType:rateType];
    NSInteger index = [activeDays findPlaceFor:monthlyItem whereBestFits:monthlyBestMatch];
    if(!areMonthlyRateValueItemsEqual(monthlyItem,activeDays[index])){
        [activeDays insertObject:monthlyItem atIndex:index];
        return index;
    }
    return -1;
}


-(NSInteger)addYearlyItem:(BOOL)isInverse monthNum:(NSInteger)monthNum dayOfMonth:(NSInteger)monthDay{
    
    RateValueItemDict *yearlyItem = [NSDictionary dictionaryWithObjectsAndKeys:
                                 MONTH_KEY,[NSNumber numberWithInteger:monthNum]
                                 ,DAYS_OF_MONTH_KEY,[NSNumber numberWithInteger:monthDay]
                                 ,nil];
    RateType rateType = setRateTypeInversion(YEARLY_RATE,isInverse);
    NSMutableArray<RateValueItemDict *> *activeDays = [self getActiveDaysForRateType:rateType];
    NSInteger index = [activeDays findPlaceFor:yearlyItem whereBestFits:yearlyBestMatch];
    if(!areYearlyRateValueItemsEqual(yearlyItem,activeDays[index])){
        [activeDays insertObject:yearlyItem atIndex:index];
        return index;
    }
    return -1;
}

@end
