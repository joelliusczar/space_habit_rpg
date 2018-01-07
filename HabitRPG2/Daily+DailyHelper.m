//
//  Daily+DailyHelper.m
//  HabitRPG2
//
//  Created by Joel Pridgen on 6/4/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import "Daily+DailyHelper.h"
#import "Daily+CoreDataClass.h"
#import "constants.h"
#import "CommonUtilities.h"
#import "P_CustomSwitch.h"
#import "SingletonCluster.h"
#import "NSDate+DateHelper.h"

@implementation Daily (Helper)

+(Daily *)constructDaily{
    return (Daily *)[SHData constructEmptyEntity:Daily.entity InContext:nil];
}

//TODO: days of week 0-6, mon: 0 - sun: 6
//TODO: every x days, 1 day of week: ((7+active day) -dayofweektoday) % 7


+(NSArray<NSSortDescriptor *> *)buildFetchDescriptors{
    NSSortDescriptor *sortByUserOrder = [[NSSortDescriptor alloc]
                                       initWithKey:@"customUserOrder" ascending:NO];
    NSSortDescriptor *sortByUrgency = [[NSSortDescriptor alloc]
                                       initWithKey:@"urgency" ascending:NO];
    NSSortDescriptor *sortByDifficulty = [[NSSortDescriptor alloc]
                                          initWithKey:@"difficulty" ascending:YES];
    return [NSArray arrayWithObjects:sortByUserOrder,sortByUrgency,sortByDifficulty, nil];
}


+(NSFetchedResultsController *)getUnfinishedDailiesController:(NSDate *)todayStart{
    NSPredicate *filter = [NSPredicate predicateWithFormat:@"isActive = 1"
                           " AND (lastActivationTime = NULL"
                           " OR lastActivationTime < %@)"
                           ,todayStart];
    NSFetchedResultsController *resultsController = [SHData getItemFetcher:Daily.fetchRequest
                                                                predicate:filter
                                                                sortBy:[Daily buildFetchDescriptors]];
    return resultsController;
}


+(NSFetchedResultsController *)getFinishedDailiesController:(NSDate *)todayStart{
    NSPredicate *filter = [NSPredicate predicateWithFormat:@"isActive = 1 AND lastActivationTime >= %@",todayStart];
    NSArray *descriptors = @[[[NSSortDescriptor alloc]
                              initWithKey:@"lastActivationTime"
                              ascending:NO]];
    NSFetchedResultsController *resultsController = [SHData getItemFetcher:Daily.fetchRequest
                                                        predicate: filter
                                                        sortBy:descriptors];
    return resultsController;
}

NSUInteger calcWeeklyDateRange(NSInteger offset,int scaler){
    return (SHCONST.DAYS_IN_WEEK +offset)
    + (scaler -1)*SHCONST.DAYS_IN_WEEK;
}

+(NSMutableArray<RateValueItemDict *> *)buildEmptyWeek{
    NSMutableArray *week = [NSMutableArray array];
    for(NSUInteger i = 0;i < SHCONST.DAYS_IN_WEEK;i++){
        [week addObject: @{IS_DAY_ACTIVE_KEY:@(NO)
                           ,BACKRANGE_KEY: @(0)
                           ,FORRANGE_KEY: @(0)
                           }];
    }
    return week;
}

void setDayCounts(NSUInteger *daysCounts,BOOL *activeDays,NSUInteger counter,BOOL isReverse){
    for(NSUInteger dayIdx = 0;dayIdx < SHCONST.DAYS_IN_WEEK;dayIdx++){
        NSUInteger useIdx = isReverse?SHCONST.DAYS_IN_WEEK -dayIdx -1:dayIdx;
        counter++;
        daysCounts[useIdx] = counter;
        if(activeDays[useIdx]){
            counter = 0;
        }
    }
}


NSArray<RateValueItemDict *> *buildWeek(NSUInteger *daysAheadCounts
                                        ,NSUInteger *daysBeforeCounts
                                        ,BOOL *activeDays){
    NSMutableArray *accumulator = [NSMutableArray array];
    for(NSUInteger dayIdx = 0;dayIdx < SHCONST.DAYS_IN_WEEK;dayIdx++){
        [accumulator addObject:@{
           IS_DAY_ACTIVE_KEY: @(activeDays[dayIdx])
           ,BACKRANGE_KEY:@(daysBeforeCounts[dayIdx])
           ,FORRANGE_KEY:@(daysAheadCounts[dayIdx])
        }];
    }
    return accumulator;
}


#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wunused-parameter"

+(NSArray<RateValueItemDict *> *)buildWeek:(BOOL *)activeDays scaler:(int)scaler{
    NSAssert(scaler > 0, @"scaler must be greater than 0");
    BOOL (^isDayActive)(NSString *,NSUInteger, BOOL *) =
        ^BOOL(NSString *key,NSUInteger idx,BOOL *stop){
            return activeDays[idx];
        };

    NSUInteger lastIdx = [SHCONST.WEEKDAY_KEYS
                          indexOfObjectWithOptions:NSEnumerationReverse
                          passingTest:isDayActive];
    if(lastIdx == NSNotFound){
        return [Daily buildEmptyWeek];
    }
    NSUInteger daysBefore = (SHCONST.DAYS_IN_WEEK -lastIdx)
        + (scaler -1)*SHCONST.DAYS_IN_WEEK -1;
    NSUInteger daysBeforeCounts[SHCONST.DAYS_IN_WEEK];
    setDayCounts(daysBeforeCounts,activeDays,daysBefore,NO);
    
    NSUInteger firstIdx = [SHCONST.WEEKDAY_KEYS
                           indexOfObjectPassingTest:isDayActive];
    NSUInteger daysAhead = firstIdx + (scaler -1)*SHCONST.DAYS_IN_WEEK;
    NSUInteger daysAheadCounts[SHCONST.DAYS_IN_WEEK];
    setDayCounts(daysAheadCounts,activeDays,daysAhead,YES);
    
    return buildWeek(daysAheadCounts,daysBeforeCounts,activeDays);
}

#pragma clang diagnostic pop


+(void)setActivenessArray:(NSArray<RateValueItemDict *> *)week activeDays:(BOOL *)activeDays{
    NSUInteger idx = 0;
    for(RateValueItemDict *dict in week){
        activeDays[idx] = dict[IS_DAY_ACTIVE_KEY].boolValue;
        idx++;
    }
}

+(NSMutableSet<NSString *> *)weekToKeySet:(NSArray<RateValueItemDict *> *)activeDays{
    NSMutableArray *keys = [NSMutableArray array];
    NSUInteger idx = 0;
    for(RateValueItemDict *dict in activeDays){
        if(dict[IS_DAY_ACTIVE_KEY].boolValue){
            [keys addObject:SHCONST.WEEKDAY_KEYS[idx]];
        }
    }
    return [NSMutableSet setWithArray:keys];
}


/*TODO: do lastDueTime need to be converted to todayStart and if so I guess that should be
updated to all dailies
 */
+(NSDate *)previousDueTime_WEEKLY:(NSDate *)lastDueTime checkinTime:(NSDate *)checkinTime
                       week:(NSArray<RateValueItemDict *> *)week
                       weekScaler:(NSUInteger)weekScaler{
    
    NSAssert(lastDueTime&&week&&checkinTime,@"parameters cannot be null");
    NSAssert(checkinTime.timeIntervalSince1970 > lastDueTime.timeIntervalSince1970,
             @"checkinTime must be greater than lastDueTime");
    NSAssert(weekScaler > 0,@"week scaler cannot be less than 1");
    NSUInteger lastDayIdx = [lastDueTime getWeekdayIndex];
    NSDate *firstDayOfFirstWeek = [lastDueTime dateAfterYears:0 months:0 days:-1*lastDayIdx];
    NSUInteger daySpan = [NSDate daysBetween:firstDayOfFirstWeek to:checkinTime];
    NSUInteger checkinDayIdx = [checkinTime getWeekdayIndex];
    NSUInteger prevSunToFirstSpan = daySpan - checkinDayIdx; //move to beginig of week
    NSUInteger sunOfPrevActiveWeek = prevSunToFirstSpan - (prevSunToFirstSpan % (SHCONST.DAYS_IN_WEEK * weekScaler));
    NSUInteger prevDayIdx = SHCONST.DAYS_IN_WEEK;
    for(NSUInteger i = 0;i < SHCONST.DAYS_IN_WEEK;i++){
        NSUInteger dayIdx = (SHCONST.DAYS_IN_WEEK + checkinDayIdx -i -1) % SHCONST.DAYS_IN_WEEK;
        if(week[dayIdx][IS_DAY_ACTIVE_KEY].boolValue){
            prevDayIdx = dayIdx;
            break;
        }
    }
    NSAssert(prevDayIdx < SHCONST.DAYS_IN_WEEK,@"no days are active");
    return [firstDayOfFirstWeek dateAfterYears:0 months:0 days:sunOfPrevActiveWeek + prevDayIdx];
}

@end
