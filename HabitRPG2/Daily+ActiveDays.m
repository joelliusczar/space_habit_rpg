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
    
    NSInteger ordinalA = a[ORDINAL_WEEK_KEY].integerValue;
    NSInteger ordinalB = b[ORDINAL_WEEK_KEY].integerValue;
    
    NSInteger dayOfWeekA = a[DAY_OF_WEEK_KEY].integerValue;
    NSInteger dayOfWeekB = b[DAY_OF_WEEK_KEY].integerValue;
    
    return ordinalA > ordinalB || (ordinalA == ordinalB && dayOfWeekA >= dayOfWeekB);
};


bestMatchPredicate yearlyBestMatch = ^BOOL(RateValueItemDict *a,RateValueItemDict *b){
    
    NSInteger monthA = a[MONTH_KEY].integerValue;
    NSInteger monthB = b[MONTH_KEY].integerValue;
    
    NSInteger dayOfMonthA = a[DAY_OF_MONTH_KEY].integerValue;
    NSInteger dayOfMonthB = b[DAY_OF_MONTH_KEY].integerValue;
    
    return monthA > monthB || (monthA == monthB && dayOfMonthA >= dayOfMonthB);
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
    self.isTouched = YES;
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
    self.isTouched = YES;
    NSArray *array = [self getActiveDaysForRateType:triKey.rateType];
    NSMutableDictionary *dict = array[triKey.index];
    dict[triKey.key] = value;
}
  
    
-(BOOL)flipDayOfWeek_w:(NSString *)key setTo:(BOOL)isOn for:(BOOL)isInverse{
    self.isTouched = YES;
    RateType rateType = isInverse?WEEKLY_RATE_INVERSE:WEEKLY_RATE;
    ActiveDaysTriKey *triKey = [[ActiveDaysTriKey alloc] initWithRateType:rateType key:key index:0];
    [self setActiveDay:triKey withValue:[NSNumber numberWithBool:isOn]];
    return isOn;
}


-(NSInteger)addMonthlyItem:(BOOL)isInverse
                   ordinal:(NSInteger)ordinal
                   dayOfWeekNum:(NSInteger)weekdayNum{
    
    self.isTouched = YES;
    RateValueItemDict *monthlyItem = [NSDictionary dictionaryWithObjectsAndKeys:
                                 [NSNumber numberWithInteger:ordinal],ORDINAL_WEEK_KEY
                                 ,[NSNumber numberWithInteger:weekdayNum],DAY_OF_WEEK_KEY
                                 ,nil];
    RateType rateType = setRateTypeInversion(MONTHLY_RATE,isInverse);
    NSMutableArray<RateValueItemDict *> *activeDays = [self getActiveDaysForRateType:rateType];
    NSUInteger index = [activeDays findPlaceFor:monthlyItem whereBestFits:monthlyBestMatch];
    if(index == activeDays.count){
        [activeDays addObject:monthlyItem];
        return index;
    }
    if(!areMonthlyRateValueItemsEqual(monthlyItem,activeDays[index])){
        [activeDays insertObject:monthlyItem atIndex:index];
        return index;
    }
    return -1;
}


-(NSInteger)addYearlyItem:(BOOL)isInverse
                 monthNum:(NSInteger)monthNum
                 dayOfMonth:(NSInteger)monthDay{
    self.isTouched = YES;
    RateValueItemDict *yearlyItem = [NSDictionary dictionaryWithObjectsAndKeys:
                                 [NSNumber numberWithInteger:monthNum],MONTH_KEY
                                 ,[NSNumber numberWithInteger:monthDay],DAY_OF_MONTH_KEY
                                 ,nil];
    RateType rateType = setRateTypeInversion(YEARLY_RATE,isInverse);
    NSMutableArray<RateValueItemDict *> *activeDays = [self getActiveDaysForRateType:rateType];
    NSUInteger index = [activeDays findPlaceFor:yearlyItem whereBestFits:yearlyBestMatch];
    if(index == activeDays.count){
        [activeDays addObject:yearlyItem];
        return 0;
    }
    if(!areYearlyRateValueItemsEqual(yearlyItem,activeDays[index])){
        [activeDays insertObject:yearlyItem atIndex:index];
        return index;
    }
    return -1;
}


-(void)deleteRateValueItem:(RateType)rateType atIndex:(NSInteger)index{
    self.isTouched = YES;
    NSMutableArray *activeDays = [self getActiveDaysForRateType:rateType];
    [activeDays removeObjectAtIndex:index];
    
}

@end
