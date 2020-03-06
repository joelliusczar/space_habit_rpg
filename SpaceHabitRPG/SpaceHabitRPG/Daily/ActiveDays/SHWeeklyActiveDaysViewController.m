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
	NSAssert(self.weeklyActiveDays,@"Weekly active days cannot be null");
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
	if(sender == self.day0Switch){
		[self.valueChangeDelegate switchActiveDay:0 value:newValue];
	}
	else if(sender == self.day1Switch){
		[self.valueChangeDelegate switchActiveDay:1 value:newValue];
	}
	else if(sender == self.day2Switch){
		[self.valueChangeDelegate switchActiveDay:2 value:newValue];
	}
	else if(sender == self.day3Switch){
		[self.valueChangeDelegate switchActiveDay:3 value:newValue];
	}
	else if(sender == self.day4Switch){
		[self.valueChangeDelegate switchActiveDay:4 value:newValue];
	}
	else if(sender == self.day5Switch){
		[self.valueChangeDelegate switchActiveDay:5 value:newValue];
	}
	else if(sender == self.day6Switch){
		[self.valueChangeDelegate switchActiveDay:6 value:newValue];
	}
}


-(void)changeBackgroundColorTo:(UIColor *)color{
	self.view.backgroundColor = color;
}


-(void)setupCustomOptions{}

@end
