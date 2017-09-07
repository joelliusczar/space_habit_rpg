//
//  Daily+ActiveDays.h
//  HabitRPG2
//
//  Created by Joel Pridgen on 9/4/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import "Daily+CoreDataClass.h"
#import "ActiveDaysTriKey.h"

@interface Daily (ActiveDays)
-(NSMutableArray<RateValueItemDict *> * )getActiveDaysForRateType:(RateType)rateType;
-(BOOL)flipDayOfWeek_w:(NSString *)key setTo:(BOOL)isOn for:(BOOL)isInverse;
-(void)setActiveDay:(ActiveDaysTriKey *)triKey withValue:(NSNumber *)value;
-(NSInteger)addMonthlyItem:(BOOL)isInverse ordinal:(NSInteger)ordinal dayOfWeekNum:(NSInteger)weekdayNum;
-(NSInteger)addYearlyItem:(BOOL)isInverse monthNum:(NSInteger)monthNum dayOfMonth:(NSInteger)monthDay;
@end
