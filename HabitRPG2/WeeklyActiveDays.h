//
//  WeeklyActiveDays.h
//  HabitRPG2
//
//  Created by Joel Pridgen on 6/17/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomSwitch.h"
#import "P_WeeklyActiveDaysDelegate.h"
#import "SHView.h"
#import "constants.h"

IB_DESIGNABLE
@interface WeeklyActiveDays : SHView
@property (strong, nonatomic) IBOutletCollection(CustomSwitch) NSArray *activeDaySwitches;
@property (weak,nonatomic) IBOutlet CustomSwitch *sundaySwitch;
@property (weak,nonatomic) IBOutlet CustomSwitch *mondaySwitch;
@property (weak,nonatomic) IBOutlet CustomSwitch *tuesdaySwitch;
@property (weak,nonatomic) IBOutlet CustomSwitch *wednesdaySwitch;
@property (weak,nonatomic) IBOutlet CustomSwitch *thursdaySwitch;
@property (weak,nonatomic) IBOutlet CustomSwitch *fridaySwitch;
@property (weak,nonatomic) IBOutlet CustomSwitch *saturdaySwitch;
@property (weak,nonatomic) id<P_WeeklyActiveDaysDelegate> delegate;
-(void)setActiveDaysOfWeek:(NSArray<RateValueItemDict *> *)activeDays;
@end
