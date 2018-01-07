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
#import "NSDate+DateHelper.h"
#import "constants.h"
#import "Daily+DailyHelper.h"

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
    NSMutableArray *week = self.activeDaysDict[rateTypeKey];
    BOOL activeDays[SHCONST.DAYS_IN_WEEK];
    if(!week){
        if(rateType == WEEKLY_RATE || rateType == WEEKLY_RATE_INVERSE){
            [Daily setActivenessArray:nil activeDays:activeDays];
            week = [Daily buildWeek:activeDays scaler:self.rate];
        }
        else{
            week = [NSMutableArray array];
        }
        self.activeDaysDict[rateTypeKey] = week;
    }
    return week;
}

    
-(void)flipDayOfWeek_w:(NSUInteger)dayIdx for:(BOOL)isInverse{
    self.isTouched = YES;
    RateType rateType = isInverse?WEEKLY_RATE_INVERSE:WEEKLY_RATE;
    NSMutableArray *week = [self getActiveDaysForRateType:rateType];
    BOOL activeDays[SHCONST.DAYS_IN_WEEK];
    [Daily setActivenessArray:week activeDays:activeDays];
    activeDays[dayIdx] = !activeDays[dayIdx];
    week = [Daily buildWeek:activeDays scaler:self.rate];
    self.activeDaysDict[getRateTypeKey(rateType)] = week;
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


-(NSDate *)nextDueTime_DAILY:(NSDate *)checkinDate{
    NSDate *checkinDateStart = [SharedGlobal.inUseCalendar startOfDayForDate:checkinDate];
    NSDate *nextDueDateStart = [checkinDateStart dateAfterYears:0 months:0 days:self.rate];
    return [nextDueDateStart timeAfterHours:SHSettings.dayStart minutes:0 seconds:0];
}


-(NSDate *)nextDueTime_DAILY_INVERSE:(NSDate *)checkinDate{
    return nil;
}

/*
 if a task is due thr and you activate it monday, it will not penalty you
 thr but you activate again tuesday, it will not stack. So, come next thr
 if you have not activated after friday, it will hurt you.
 if activation time is before the time when it should be due...
 case for prev activation first time calling this method
 */
//-(NSDate *)nextDueTime_WEEKLY:(NSDate *)checkinDate{
//    RateValueItemDict *activeDays = [self getActiveDaysForRateType:WEEKLY_RATE][0];
//    NSUInteger todayIdx = (NSUInteger)[[NSDate date] getWeekdayIndex] +1;
//
//    
//    for(NSUInteger dayIdx = 0;dayIdx < WEEKDAY_KEYS.count;dayIdx++){
//
//        if(activeDays[WEEKDAY_KEYS[dayIdx]].boolValue){
//
//        }
//
//        if(activeDays[WEEKDAY_KEYS[nextDayIdx]].boolValue){
//            NSInteger daySpan = (NSInteger)(nextDayIdx - dayIdx);
//            daySpan += self.rate >1?((self.rate -1)*7):0;
//            if()
//            break;
//        }
//    }
//
//}

@end
