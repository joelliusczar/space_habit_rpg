//
//	SHWeeklyActiveDaysViewController.h
//	HabitRPG2
//
//	Created by Joel Pridgen on 6/17/17.
//	Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import "SHDayOption.h"
@import UIKit;
@import SHControls;

@import SHModels;
@import SHControls;


@protocol SHWeeklyActiveDayChangesProtocol <NSObject>

-(void)switchActiveDay:(int32_t)dayIdx value:(bool)value;

@end


IB_DESIGNABLE
@interface SHWeeklyActiveDaysViewController :
	SHViewController
@property (strong, nonatomic) IBOutletCollection(SHDayOption) NSArray<SHDayOption*> *activeDaySwitches;
@property (strong, nonatomic) NSArray<UIView*> *dayOptionViews;
@property (strong,nonatomic) IBOutlet UIView *day0Switch;
@property (strong,nonatomic) IBOutlet UIView *day1Switch;
@property (strong,nonatomic) IBOutlet UIView *day2Switch;
@property (strong,nonatomic) IBOutlet UIView *day3Switch;
@property (strong,nonatomic) IBOutlet UIView *day4Switch;
@property (strong,nonatomic) IBOutlet UIView *day5Switch;
@property (strong,nonatomic) IBOutlet UIView *day6Switch;
@property (assign,nonatomic) NSInteger weekStartDay;
@property (assign,nonatomic) IBOutlet id<SHWeeklyActiveDayChangesProtocol> valueChangeDelegate;
//@property (strong,nonatomic) SHWeekIntervalItemList *weeklyActiveDays;
-(void)setupCustomOptions;
@end



