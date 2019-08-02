//
//  SHWeeklyActiveDaysViewController.h
//  HabitRPG2
//
//  Created by Joel Pridgen on 6/17/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

@import UIKit;
@import SHControls;
#import "SHDayOption.h"
#import <SHGlobal/SHConstants.h>
#import <SHModels/SHModelConstants.h>
#import <SHModels/SHRangeRateItem.h>
#import <SHControls/SHNestedControlProtocol.h>
#import <SHControls/SHViewEventsProtocol.h>
#import <SHControls/SHRateSetterView.h>


@protocol SHWeeklyActiveDayChangesProtocol <NSObject>

-(void)switchActiveDay:(NSInteger)dayIdx value:(BOOL)value;

@end


IB_DESIGNABLE
@interface SHWeeklyActiveDaysViewController :
  UIViewController<SHNestedControlProtocol,
    SHViewEventsProtocol>
@property (strong,nonatomic) NSArray<SHDayOption*> *activeDaySwitches;
@property (strong,nonatomic) IBOutlet SHDayOption *day0Switch;
@property (strong,nonatomic) IBOutlet SHDayOption *day1Switch;
@property (strong,nonatomic) IBOutlet SHDayOption *day2Switch;
@property (strong,nonatomic) IBOutlet SHDayOption *day3Switch;
@property (strong,nonatomic) IBOutlet SHDayOption *day4Switch;
@property (strong,nonatomic) IBOutlet SHDayOption *day5Switch;
@property (strong,nonatomic) IBOutlet SHDayOption *day6Switch;
@property (assign,nonatomic) NSInteger weekStartDay;
@property (assign,nonatomic) IBOutlet id<SHWeeklyActiveDayChangesProtocol> valueChangeDelegate;
@property (strong,nonatomic) NSArray<SHRangeRateItem*> *weeklyActiveDays;
-(void)setupCustomOptions;

@end



