//
//	SHWeeklyActiveDaysViewController.m
//	HabitRPG2
//
//	Created by Joel Pridgen on 6/17/17.
//	Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import "SHWeeklyActiveDaysViewController.h"
@import SHCommon;
@import SHControls;


@interface SHWeeklyActiveDaysViewController ()

@end

@implementation SHWeeklyActiveDaysViewController

-(void)viewDidLoad{
	NSAssert(self.weeklyActiveDays, @"Weekly active days cannot be null");
	[super viewDidLoad];
	self.dayOptionViews = @[
		self.day0Switch,
		self.day1Switch,
		self.day2Switch,
		self.day3Switch,
		self.day4Switch,
		self.day5Switch,
		self.day6Switch
	];
	
	NSArray<NSString *> *dayKeys = self.weeklyActiveDays.weekKeysBasedOnWeekStart;

	__weak SHWeeklyActiveDaysViewController *weakSelf = self;
	for(int32_t i = 0; i < 7; i++){
		[self pushChildVC:self.activeDaySwitches[i] toViewOfParent:self.dayOptionViews[i]];
		self.activeDaySwitches[i].dayLabel.text = [SHWeeklyRateItemList weekDayKeyToFullName:dayKeys[i]];

		self.activeDaySwitches[i].onChange = ^void (BOOL newValue, SHSwitch *sender) {
			SHWeeklyActiveDaysViewController *bSelf = weakSelf;
			if(nil == bSelf) return;
			[bSelf dayChange:newValue sender:sender];
		};
		int32_t dayIdx = (i + self.weekStartDay) % 7;
		self.activeDaySwitches[dayIdx].isOn = self.weeklyActiveDays[dayIdx].isDayActive;
	}
	
}



-(void)dayChange:(BOOL)newValue sender:(SHSwitch*)sender {
	for(int32_t i = 0; i < 7; i ++) {
		if(sender == self.activeDaySwitches[i]) {
			[self.valueChangeDelegate switchActiveDay:i value:newValue];
		}
	}
}


-(void)changeBackgroundColorTo:(UIColor *)color{
	self.view.backgroundColor = color;
}


-(void)setupCustomOptions{}

@end
