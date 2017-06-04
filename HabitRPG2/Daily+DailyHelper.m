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

+(BOOL)isDailyCompleteForTheDay:(Daily *)daily{
    //todo
    return NO;
}

//todo fix this long to int
+(NSDate *)calculateNextDueTime:(NSDate *)checkinDate WithRate:(int32_t)rate{
    NSCalendar *cal = [NSCalendar currentCalendar];
    NSDateComponents *offsetComponents = [[NSDateComponents alloc] init];
    [offsetComponents setDay:rate];
    return [cal dateByAddingComponents:offsetComponents toDate:checkinDate options:0];
    
}

+(int)calculateActiveDaysHash:(NSMutableArray<NSObject<P_CustomSwitch> *> *)activeDays{
    int32_t daysHash = 0;
    int32_t currentDayBit = 1;
    for(int i = 0;i<DAYS_IN_WEEK;i++){
        if(activeDays[i].isOn){
            daysHash |= currentDayBit;
            
        }
        currentDayBit = currentDayBit << 1;
    }
    return daysHash;
}

+(void)setActiveDaySwitches:(NSMutableArray<NSObject<P_CustomSwitch> *> *)activeDays fromHash:(NSInteger)hash{
    int currentDayBit = 1;
    for(int i = 0;i<DAYS_IN_WEEK;i++){
        activeDays[i].isOn = hash & currentDayBit;
        currentDayBit = currentDayBit << 1;
    }
}

+(NSArray *)buildFetchDescriptors{
    NSSortDescriptor *sortByUrgency = [[NSSortDescriptor alloc]
                                       initWithKey:@"urgency" ascending:NO];
    NSSortDescriptor *sortByDifficulty = [[NSSortDescriptor alloc]
                                          initWithKey:@"difficulty" ascending:YES];
    return [NSArray arrayWithObjects:sortByUrgency,sortByDifficulty, nil];
}

+(NSFetchedResultsController *)getUnfinishedDailiesController:(NSDate *)todayStart{
    NSPredicate *filter = [NSPredicate predicateWithFormat:@"isActive = 1 AND (lastActivationTime = NULL OR lastActivationTime < %@)",todayStart];
    NSFetchedResultsController *resultsController = [SHData getItemFetcher:Daily.fetchRequest predicate:filter sortBy:[Daily buildFetchDescriptors]];
    return resultsController;
}
@end
