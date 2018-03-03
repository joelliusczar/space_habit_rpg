//
//  Daily+DailyHelper.m
//  HabitRPG2
//
//  Created by Joel Pridgen on 6/4/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import "Daily+DailyHelper.h"
#import "Daily+CoreDataClass.h"
#import <SHGlobal/Constants.h>
#import <SHCommon/CommonUtilities.h>
#import <SHCommon/SingletonCluster.h>
#import <SHCommon/NSDate+DateHelper.h>
#import <SHGlobal/CommonTypeDefs.h>
#import <SHData/SingletonCluster+Data.h>

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
    for(NSUInteger i = 0;i < SHCONST.DAYS_IN_WEEK;i++){
        if(week){
            activeDays[i] = week[i][IS_DAY_ACTIVE_KEY].boolValue;
            continue;
        }
        activeDays[i] = YES;
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

NSInteger distanceFromActiveWeek(NSUInteger weekNum,NSUInteger weekScaler){
    return weekNum % (weekScaler * SHCONST.DAYS_IN_WEEK);
}

NSInteger offsetForSameWeek(bool isActiveWeek,NSUInteger inputDayIdx,NSUInteger prevDayIdx){
    /*
     if checkin day is in active week but before all active days
     push it back a week so that it get's the last active day of
     the previous active weeks
     */
    return prevDayIdx > inputDayIdx || (prevDayIdx == inputDayIdx && isActiveWeek)
        ?SHCONST.DAYS_IN_WEEK:0;
}

NSUInteger findPrevDayIdxInWeek(BOOL isActiveWeek,NSUInteger checkinDayIdx
    ,NSArray<RateValueItemDict *> *week)
{
    NSUInteger prevDayIdx = SHCONST.DAYS_IN_WEEK;
    for(NSUInteger i = 0;i < SHCONST.DAYS_IN_WEEK;i++){
        //if active week use active day before today
        //if not active week just use last active day in week
        NSUInteger reverseDayIdx = isActiveWeek?
          (SHCONST.DAYS_IN_WEEK + checkinDayIdx -i -1) % SHCONST.DAYS_IN_WEEK:
          SHCONST.DAYS_IN_WEEK - i -1;
        if(week[reverseDayIdx][IS_DAY_ACTIVE_KEY].boolValue){
            prevDayIdx = reverseDayIdx;
            break;
        }
    }
    NSCAssert(prevDayIdx < SHCONST.DAYS_IN_WEEK,@"no days are active");
    return prevDayIdx;
}

NSUInteger findNextDayIdx(NSUInteger checkinDayIdx,NSArray<RateValueItemDict *> *week){
    for(NSUInteger i = 0;i < SHCONST.DAYS_IN_WEEK;i++){
        NSUInteger dayIdx = (SHCONST.DAYS_IN_WEEK + checkinDayIdx + i)
            % SHCONST.DAYS_IN_WEEK;
        if(week[dayIdx][IS_DAY_ACTIVE_KEY].boolValue){
            return dayIdx;
        }
    }
    @throw [NSException
        exceptionWithName:NSInternalInconsistencyException
            reason:@"no active days" userInfo:nil];
}


/*TODO: do lastDueDate need to be converted to todayStart and if so I guess that should be
TODO: lastDueDate should always be at least in the same week as actual active days
updated to all dailies
 Assume that dates are in GMT, otherwise things get fucky
 Edge cases that I had to fix:
 1)if the checkinDate is in the active week there is an active day after checkindate
 that week then it would erroneously return a future date as a the previousduedate
 2) checkinDate was in a non active week but its day of the week was between active days
 (ex, tues and between an active mon and wed) then it would return the previous monday
 rather the previous wednesday as the previousduedate when it should have been wednesday.
 3)checkindate was itself an active day and it was returning itself as the previousDueDate
 
 */
+(NSDate *)previousDueDate_WEEKLY:(NSDate *)lastDueDate checkinDate:(NSDate *)checkinDate
    week:(NSArray<RateValueItemDict *> *)week
    weekScaler:(NSUInteger)weekScaler
{
    NSAssert(lastDueDate&&week&&checkinDate,@"parameters cannot be null");
    NSAssert(unixTime(checkinDate) > unixTime(lastDueDate),
             @"checkinDate must be greater than lastDueDate");
    NSAssert(weekScaler > 0,@"week scaler cannot be less than 1");
    
    NSUInteger lastDayIdx = [lastDueDate getWeekdayIndex];
    NSDate *firstDayOfFirstWeek = [lastDueDate dateAfterYears:0 months:0 days:-1*lastDayIdx];
    NSUInteger daySpan = [NSDate daysBetween:firstDayOfFirstWeek to:checkinDate];
    NSUInteger checkinDayIdx = [checkinDate getWeekdayIndex];
    NSUInteger firstSunToPrevSunSpan = daySpan - checkinDayIdx; //move to begining of week
    BOOL isActiveWeek = distanceFromActiveWeek(firstSunToPrevSunSpan,weekScaler) == 0;
    NSUInteger prevDayIdx = findPrevDayIdxInWeek(isActiveWeek,checkinDayIdx,week);
    firstSunToPrevSunSpan -= (offsetForSameWeek(isActiveWeek,checkinDayIdx,prevDayIdx));
    NSUInteger sunOfPrevActiveWeek =
        firstSunToPrevSunSpan - distanceFromActiveWeek(firstSunToPrevSunSpan,weekScaler);
    NSDate *result = [firstDayOfFirstWeek dateAfterYears:0
        months:0 days:sunOfPrevActiveWeek + prevDayIdx];
    NSAssert(unixTime(result) <= unixTime(checkinDate),@"error in calculation");
    return result;
}

+(NSArray<NSDate *> *)bothWeeklyDueDatesFromLastDueDate:(NSDate *)lastDueDate
    checkinDate:(NSDate *)checkinDate
    week:(NSArray<RateValueItemDict *> *)week
    weekScaler:(NSInteger)weekScaler
{
    NSDate *previousDate = [Daily previousDueDate_WEEKLY:lastDueDate
        checkinDate:checkinDate week:week weekScaler:weekScaler];
    NSUInteger prevDayIdx = [previousDate getWeekdayIndex];
    NSDate *firstDayOfPrevWeek = [previousDate dateAfterYears:0 months:0
        days: -1*prevDayIdx];
    NSUInteger daySpan = [NSDate daysBetween:firstDayOfPrevWeek to:checkinDate];
    NSUInteger checkinDayIdx = [checkinDate getWeekdayIndex];
    NSUInteger prevSunToThisSunSpan = daySpan - checkinDayIdx;
    NSInteger weekCount = (distanceFromActiveWeek(prevSunToThisSunSpan,weekScaler)
        / SHCONST.DAYS_IN_WEEK);
    NSUInteger nextActiveWeek = prevSunToThisSunSpan +
        (((weekScaler - weekCount) % weekScaler) * SHCONST.DAYS_IN_WEEK);
    NSUInteger weekStartIdx = weekCount == 0 ? checkinDayIdx : 0;
    NSUInteger nextDayIdx = findNextDayIdx(weekStartIdx,week);
    NSUInteger sameWeekOffset = nextDayIdx < checkinDayIdx && weekCount == 0 ? weekScaler * SHCONST.DAYS_IN_WEEK: 0;
    NSDate *result = [firstDayOfPrevWeek
        dateAfterYears:0 months:0 days:nextActiveWeek + nextDayIdx + sameWeekOffset];
    return @[previousDate,result];
}

+(NSDate *)nextDueDate_WEEKLY:(NSDate *)lastDueDate checkinDate:(NSDate *)checkinDate
    week:(NSArray<RateValueItemDict *> *)week
    weekScaler:(NSUInteger)weekScaler
{
     return [Daily bothWeeklyDueDatesFromLastDueDate:lastDueDate checkinDate:checkinDate
             week:week weekScaler:weekScaler][1];
}

@end
