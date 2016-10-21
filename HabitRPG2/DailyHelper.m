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


-(BOOL)isDailyCompleteForTheDay:(Daily *)daily{
    return NO;
}

-(NSDate *)calculateNextDueTime:(NSDate *)checkinDate WithRate:(long)rate{
    NSCalendar *cal = [NSCalendar currentCalendar];
    NSDateComponents *offsetComponents = [[NSDateComponents alloc] init];
    [offsetComponents setDay:rate];
    return [cal dateByAddingComponents:offsetComponents toDate:checkinDate options:0];
}

-(int)calculateActiveDaysHash:(NSMutableArray *)activeDays{
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



-(void)setActiveDaySwitches:(NSMutableArray *)activeDays fromHash:(NSInteger)hash{
    int currentDayBit = 1;
    for(int i = 0;i<DAYS_IN_WEEK;i++){
        [CommonUtilities setSwitch:[activeDays objectAtIndex:i] withValue:hash & currentDayBit];
        currentDayBit = currentDayBit << 1;
    }
}

@end
