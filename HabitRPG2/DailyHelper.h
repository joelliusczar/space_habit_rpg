//
//  DailyHelper.h
//  HabitRPG2
//
//  Created by Joel Pridgen on 9/10/16.
//  Copyright © 2016 Joel Pridgen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Daily.h"
#import "CommonUtilities.h"



@interface DailyHelper : NSObject
+(BOOL)isDailyCompleteForTheDay:(Daily *)daily;
+(NSTimeInterval)calculateNextDueTime:(NSDate *)checkinDate WithRate:(long)rate;
+(int)calculateActiveDaysHash:(NSMutableArray *)activeDays;
+(void)setActiveDaySwitches:(NSMutableArray *)activeDays fromHash:(NSInteger)hash;
@end
