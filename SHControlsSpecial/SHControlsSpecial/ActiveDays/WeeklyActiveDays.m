//
//  WeeklyActiveDays.m
//  HabitRPG2
//
//  Created by Joel Pridgen on 6/17/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import "WeeklyActiveDays.h"
#import <SHCommon/CommonUtilities.h>
#import <SHCommon/NSObject+Helper.h>
#import <SHControls/SHEventInfo.h>

@interface WeeklyActiveDays ()

@end

@implementation WeeklyActiveDays


-(void)setupCustomOptions{
    [super setupCustomOptions];
    self.sundaySwitch.tag = 0;
    self.mondaySwitch.tag = 1;
    self.tuesdaySwitch.tag = 2;
    self.wednesdaySwitch.tag = 3;
    self.thursdaySwitch.tag = 4;
    self.fridaySwitch.tag = 5;
    self.saturdaySwitch.tag = 6;
}

- (IBAction)activeDaySwitch_press_action:(SHSwitch *)sender forEvent:(UIEvent *)event {
    SHEventInfo *e = eventInfoCopy;
    [self.delegate activeDaySwitch_press_action:e];
}


-(void)setActiveDaysOfWeek:(NSArray<RateValueItemDict *> *)activeDays{
    for(SHSwitch *flip in self.activeDaySwitches){
        flip.isOn = activeDays[flip.tag][IS_DAY_ACTIVE_KEY].boolValue;
    }
}

@end
