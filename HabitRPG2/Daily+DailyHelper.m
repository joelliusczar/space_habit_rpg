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

@implementation Daily (DailyHelper)

+(Daily *)constructDaily{
    return (Daily *)[SHData constructEmptyEntity:Daily.entity InContext:nil];
}

+(NSDate *)calculateNextDueTime:(NSDate *)checkinDate withRate:(int)rate andDayStart:(int)dayStart{
    NSAssert(rate>0,@"rate must be at least 1");
    NSAssert(dayStart >= 0 && dayStart < 24,@"day start must be between 0 and 24");
    NSDate *checkinDateStart = [SharedGlobal.inUseCalendar startOfDayForDate:checkinDate];
    NSDate *nextDueDateStart = [NSDate adjustDate:checkinDateStart year:0 month:0 day:rate];
    return [NSDate adjustTime:nextDueDateStart hour:dayStart minute:0 second:0];
}


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
    NSPredicate *filter = [NSPredicate predicateWithFormat:@"isActive = 1 AND (lastActivationTime = NULL OR lastActivationTime < %@)",todayStart];
    NSFetchedResultsController *resultsController = [SHData getItemFetcher:Daily.fetchRequest predicate:filter sortBy:[Daily buildFetchDescriptors]];
    return resultsController;
}

+(NSFetchedResultsController *)getFinishedDailiesController:(NSDate *)todayStart{
    NSPredicate *filter = [NSPredicate predicateWithFormat:@"isActive = 1 AND lastActivationTime >= %@",todayStart];
    NSFetchedResultsController *resultsController = [SHData getItemFetcher:Daily.fetchRequest predicate: filter sortBy:@[[[NSSortDescriptor alloc] initWithKey:@"lastActivationTime" ascending:NO]]];
    return resultsController;
}

@end
