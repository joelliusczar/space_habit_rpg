//
//  Daily+DailyHelper.h
//  HabitRPG2
//
//  Created by Joel Pridgen on 6/4/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import "Daily+CoreDataClass.h"

@interface Daily (Helper)
+(Daily *)constructDaily;
+(NSFetchedResultsController *)getUnfinishedDailiesController:(NSDate *)todayStart;
+(NSFetchedResultsController *)getFinishedDailiesController:(NSDate *)todayStart;
+(NSMutableArray<RateValueItemDict *> *)buildWeek:(BOOL *)activeDays scaler:(int)scaler;
+(NSMutableArray<RateValueItemDict *> *)buildEmptyWeek;
+(void)setActivenessArray:(NSArray<RateValueItemDict *> *)week activeDays:(BOOL *)activeDays;
+(NSDate *)previousDueDate_WEEKLY:(NSDate *)lastDueDate checkinDate:(NSDate *)checkinDate
    week:(NSArray<RateValueItemDict *> *)week
    weekScaler:(NSUInteger)weekScaler;
+(NSArray<NSDate *> *)bothWeeklyDueDatesFromLastDueDate:(NSDate *)lastDueDate
    checkinDate:(NSDate *)checkinDate week:(NSArray<RateValueItemDict *> *)week
    weekScaler:(NSInteger)weekScaler;
+(NSDate *)nextDueDate_WEEKLY:(NSDate *)lastDueDate checkinDate:(NSDate *)checkinDate
    week:(NSArray<RateValueItemDict *> *)week
    weekScaler:(NSUInteger)weekScaler;

@end
