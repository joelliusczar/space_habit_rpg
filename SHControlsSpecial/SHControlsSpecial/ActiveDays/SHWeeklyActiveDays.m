//
//	SHWeeklyActiveDaysViewController.m
//	HabitRPG2
//
//	Created by Joel Pridgen on 6/17/17.
//	Copyright © 2017 Joel Pridgen. All rights reserved.
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
	self.view = [[UIView alloc] init];
	self.view.backgroundColor = UIColor.magentaColor;
	UIView *testView = [[UIView alloc] init];
	testView.backgroundColor = UIColor.orangeColor;
	//self.sundaySwitch = [self buildDayOptionView];
	[self.view addSubview:testView];
	[self.view tieHorizontalConstaintsForSubordinateView:testView];
	[testView.heightAnchor constraintEqualToConstant:50].active = YES;
	//[self.view.topAnchor co];
	[self.view.topAnchor constraintEqualToAnchor:testView.topAnchor constant:-50].active = YES;
}


-(SHWeekDayOption*)buildDayOptionView{
	SHWeekDayOption *dayOption = [[SHWeekDayOption alloc] initEmpty];
	return dayOption;
}

-(void)setupCustomOptions{
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
		NSLog(@"On view");
		if(self.touchCallback){
			self.touchCallback();
		}
}


-(void)setActiveDaysOfWeek:(NSArray<SHRangeRateItem*>*)activeDays{
		for(SHSwitch *flip in self.activeDaySwitches){
				flip.isOn = activeDays[flip.tag].isDayActive;
		}
}


-(void)changeBackgroundColorTo:(UIColor *)color{
	self.view.backgroundColor = color;
}

@end
