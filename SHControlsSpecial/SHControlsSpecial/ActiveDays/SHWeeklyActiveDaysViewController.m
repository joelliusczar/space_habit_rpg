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
  NSAssert(self.weeklyActiveDays,@"Weekly active days cannot be null");
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
    self.activeDaySwitches[i].eventDelegate = self;
    int32_t dayIdx =  (i + self.weekStartDay) % 7;
    self.activeDaySwitches[dayIdx].isOn = self.weeklyActiveDays[dayIdx].isDayActive;
  }
  
}



-(void)onBeginTap_action:(SHView *)sender withEvent:(UIEvent*)event{
  (void)sender; (void)event;
  SHDayOption *dayOption = (SHDayOption *)sender;
  if(sender == self.day0Switch.mainView){
    [self.valueChangeDelegate switchActiveDay:0 value:dayOption.isOn];
  }
  else if(sender == self.day1Switch.mainView){
    [self.valueChangeDelegate switchActiveDay:1 value:dayOption.isOn];
  }
  else if(sender == self.day2Switch.mainView){
    [self.valueChangeDelegate switchActiveDay:2 value:dayOption.isOn];
  }
  else if(sender == self.day3Switch.mainView){
    [self.valueChangeDelegate switchActiveDay:3 value:dayOption.isOn];
  }
  else if(sender == self.day4Switch.mainView){
    [self.valueChangeDelegate switchActiveDay:4 value:dayOption.isOn];
  }
  else if(sender == self.day5Switch.mainView){
    [self.valueChangeDelegate switchActiveDay:5 value:dayOption.isOn];
  }
  else if(sender == self.day6Switch.mainView){
    [self.valueChangeDelegate switchActiveDay:6 value:dayOption.isOn];
  }
}


-(void)changeBackgroundColorTo:(UIColor *)color{
  self.view.backgroundColor = color;
}


-(void)setupCustomOptions{}

@end
