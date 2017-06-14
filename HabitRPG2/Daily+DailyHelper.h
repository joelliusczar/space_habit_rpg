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
+(BOOL)isDailyCompleteForTheDay:(Daily *)daily;
+(NSDate *)calculateNextDueTime:(NSDate *)checkinDate WithRate:(int)rate;
+(int)calculateActiveDaysHash:(NSMutableArray *)activeDays;
+(void)setActiveDaySwitches:(NSMutableArray *)activeDays fromHash:(NSInteger)hash;
+(int)getDaysLeft:(NSDate *)lastActivationTime;
+(NSFetchedResultsController *)getUnfinishedDailiesController:(NSDate *)todayStart;

@end
