//
//  SHWeeklyActiveDays.h
//  HabitRPG2
//
//  Created by Joel Pridgen on 6/17/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

@import UIKit;
@import SHControls;
#import "SHWeeklyActiveDaysDelegateProtocol.h"
#import <SHGlobal/SHConstants.h>
#import <SHModels/SHModelConstants.h>
#import <SHCore_C/SHRateValueItem.h>


IB_DESIGNABLE
@interface SHWeeklyActiveDays : SHView
@property (strong, nonatomic) IBOutletCollection(SHSwitch) NSArray *activeDaySwitches;
@property (weak,nonatomic) IBOutlet SHSwitch *sundaySwitch;
@property (weak,nonatomic) IBOutlet SHSwitch *mondaySwitch;
@property (weak,nonatomic) IBOutlet SHSwitch *tuesdaySwitch;
@property (weak,nonatomic) IBOutlet SHSwitch *wednesdaySwitch;
@property (weak,nonatomic) IBOutlet SHSwitch *thursdaySwitch;
@property (weak,nonatomic) IBOutlet SHSwitch *fridaySwitch;
@property (weak,nonatomic) IBOutlet SHSwitch *saturdaySwitch;
@property (weak,nonatomic) id<SHWeeklyActiveDaysDelegateProtocol> delegate;
-(void)setActiveDaysOfWeek:(SHRateValueItem *)activeDays;
@end
