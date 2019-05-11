//
//  SHWeeklyActiveDays.m
//  HabitRPG2
//
//  Created by Joel Pridgen on 6/17/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import "SHWeeklyActiveDays.h"
#import <SHCommon/SHCommonUtils.h>
#import <SHCommon/NSObject+Helper.h>
#import <SHControls/SHEventInfo.h>

@interface SHWeeklyActiveDays ()

@end

@implementation SHWeeklyActiveDays


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
    (void)sender; (void)event;
    if(self.touchCallback){
      self.touchCallback();
    }
}


-(void)setActiveDaysOfWeek:(NSArray<SHRangeRateItem*>*)activeDays{
    for(SHSwitch *flip in self.activeDaySwitches){
        flip.isOn = activeDays[flip.tag].isDayActive;
    }
}

@end
