//
//  Daily+ActiveDays.h
//  HabitRPG2
//
//  Created by Joel Pridgen on 9/4/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import "ModelConstants.h"
#import "Daily+CoreDataClass.h"


@interface Daily (ActiveDays)
-(NSMutableArray<RateValueItemDict *> * )getActiveDaysForRateType:(RateType)rateType;
-(void)flipDayOfWeek_w:(NSUInteger)dayIdx for:(BOOL)isInverse;
-(NSInteger)addMonthlyItem:(BOOL)isInverse ordinal:(NSInteger)ordinal dayOfWeekNum:(NSInteger)weekdayNum;
-(NSInteger)addYearlyItem:(BOOL)isInverse monthNum:(NSInteger)monthNum dayOfMonth:(NSInteger)monthDay;
-(void)deleteRateValueItem:(RateType)rateType atIndex:(NSInteger)index;
-(NSDate *)nextDueTime_DAILY:(NSDate *)checkinDate;
-(NSDate *)nextDueTime_DAILY_INVERSE:(NSDate *)checkinDate;
+(void)setActivenessArray:(NSArray<RateValueItemDict *> *)week activeDays:(BOOL *)activeDays;
//-(NSDate *)nextDueTime_WEEKLY:(NSDate *)checkinDate;
@end
