//
//  WeeklyActiveDays.m
//  HabitRPG2
//
//  Created by Joel Pridgen on 6/17/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import "WeeklyActiveDays.h"
#import "CommonUtilities.h"
#import "NSObject+Helper.h"
#import "SHEventInfo.h"

@interface WeeklyActiveDays ()

@end

@implementation WeeklyActiveDays


- (IBAction)activeDaySwitch_press_action:(CustomSwitch *)sender forEvent:(UIEvent *)event {
    SHEventInfo *e = eventInfoCopy;
    [self.delegate activeDaySwitch_press_action:e];
}


-(void)setActiveDaysOfWeek:(RateValueItemDict *)activeDaysDict{
    for(CustomSwitch *flip in self.activeDaySwitches){
        flip.isOn = activeDaysDict[flip.dayKey].boolValue;
    }
}

@end
