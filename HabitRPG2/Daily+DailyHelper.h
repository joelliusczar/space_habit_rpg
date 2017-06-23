//
//  Daily+DailyHelper.h
//  HabitRPG2
//
//  Created by Joel Pridgen on 6/4/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import "Daily+CoreDataClass.h"

@interface Daily (DailyHelper)
+(Daily *)constructDaily;
+(NSDate *)calculateNextDueTime:(NSDate *)checkinDate withRate:(int)rate andDayStart:(int)dayStart;
+(int)calculateActiveDaysHash:(NSArray *)activeDays;
+(void)setActiveDaySwitches:(NSArray *)activeDays fromHash:(NSInteger)hash;
+(NSFetchedResultsController *)getUnfinishedDailiesController:(NSDate *)todayStart;
+(NSFetchedResultsController *)getFinishedDailiesController:(NSDate *)todayStart;
@end
