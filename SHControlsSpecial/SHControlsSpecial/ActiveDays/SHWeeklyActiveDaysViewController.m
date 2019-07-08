//
//  SHWeeklyActiveDaysViewController.m
//  HabitRPG2
//
//  Created by Joel Pridgen on 6/17/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import "SHWeeklyActiveDaysViewController.h"
#import <SHCommon/SHCommonUtils.h>
#import <SHCommon/NSObject+Helper.h>
#import <SHControls/SHEventInfo.h>
#import <SHControls/UIView+Helpers.h>


@interface SHWeeklyActiveDaysViewController ()

@end

@implementation SHWeeklyActiveDaysViewController

-(void)viewDidLoad{
  [super viewDidLoad];
  self.activeDaySwitches = @[
    self.day0Switch,
    self.day1Switch,
    self.day2Switch,
    self.day3Switch,
    self.day4Switch,
    self.day5Switch,
    self.day6Switch
  ];
  
  NSArray<NSString *> *dayKeys = shBuildWeekBasedOnWeekStart(self.weekStartDay);
  
  for(int i = 0; i < 7; i++){
    self.activeDaySwitches[i].dayLabel.text = shWeekDayKeyToFull(dayKeys[i]);
  }

}


-(void)onBeginTap_action:(SHView *)sender withEvent:(UIEvent*)event{
  (void)sender; (void)event;
}

-(void)setActiveDaysOfWeek:(NSArray<SHRangeRateItem*>*)activeDays{
    for(SHSwitch *flip in self.activeDaySwitches){
        flip.isOn = activeDays[flip.tag].isDayActive;
    }
}


-(void)changeBackgroundColorTo:(UIColor *)color{
  self.view.backgroundColor = color;
}


-(void)setupCustomOptions{}

@end
