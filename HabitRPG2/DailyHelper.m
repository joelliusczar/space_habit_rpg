//
//  DailyHelper.m
//  HabitRPG2
//
//  Created by Joel Pridgen on 9/10/16.
//  Copyright © 2016 Joel Pridgen. All rights reserved.
//

#import "DailyHelper.h"
#import "Daily+CoreDataClass.h"
#import "constants.h"
#import "UIUtilities.h"
#import "SingletonCluster.h"

@interface DailyHelper()

@end

@implementation DailyHelper

-(BOOL)isDailyCompleteForTheDay:(Daily *)daily{
    //todo
    return NO;
}

//todo fix this long to int
-(NSDate *)calculateNextDueTime:(NSDate *)checkinDate WithRate:(int32_t)rate{
    NSCalendar *cal = [NSCalendar currentCalendar];
    NSDateComponents *offsetComponents = [[NSDateComponents alloc] init];
    [offsetComponents setDay:rate];
    return [cal dateByAddingComponents:offsetComponents toDate:checkinDate options:0];
    
}

-(int32_t)calculateActiveDaysHash:(NSMutableArray *)activeDays{
    int32_t daysHash = 0;
    int32_t currentDayBit = 1;
    for(int i = 0;i<DAYS_IN_WEEK;i++){
        if([[SingletonCluster getSharedInstance].uiUtilities isSwitchOn:[activeDays objectAtIndex:i]]){
            daysHash |= currentDayBit;
            
        }
        currentDayBit = currentDayBit << 1;
    }
    return daysHash;
}



-(void)setActiveDaySwitches:(NSMutableArray *)activeDays fromHash:(NSInteger)hash{
    int currentDayBit = 1;
    for(int i = 0;i<DAYS_IN_WEEK;i++){
        [[SingletonCluster getSharedInstance].uiUtilities setSwitch:[activeDays objectAtIndex:i] withValue:hash & currentDayBit];
        currentDayBit = currentDayBit << 1;
    }
}

@end
