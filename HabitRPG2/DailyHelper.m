//
//  DailyHelper.m
//  HabitRPG2
//
//  Created by Joel Pridgen on 9/10/16.
//  Copyright © 2016 Joel Pridgen. All rights reserved.
//

#import "DailyHelper.h"
#import "Daily.h"
#import "constants.h"

@interface DailyHelper()

@end

@implementation DailyHelper


+(BOOL)isDailyCompleteForTheDay:(Daily *)daily{
    //todo
    return NO;
}
//todo fix this long to int
+(NSTimeInterval)calculateNextDueTime:(NSDate *)checkinDate WithRate:(long)rate{
    long timeLength = 60*60*24*rate;
    NSDate *end = [NSDate dateWithTimeIntervalSinceNow:timeLength];
    
    NSTimeInterval timeInt = [end timeIntervalSinceReferenceDate];
    return timeInt;
    
}

+(int)calculateActiveDaysHash:(NSMutableArray *)activeDays{
    int daysHash = 0;
    int currentDayBit = 1;
    for(int i = 0;i<DAYS_IN_WEEK;i++){
        if([CommonUtilities isSwitchOn:[activeDays objectAtIndex:i]]){
            daysHash |= currentDayBit;
            
        }
        currentDayBit = currentDayBit << 1;
    }
    return daysHash;
}



+(void)setActiveDaySwitches:(NSMutableArray *)activeDays fromHash:(NSInteger)hash{
    int currentDayBit = 1;
    for(int i = 0;i<DAYS_IN_WEEK;i++){
        [CommonUtilities setSwitch:[activeDays objectAtIndex:i] withValue:hash & currentDayBit];
        currentDayBit = currentDayBit << 1;
    }
}

@end
