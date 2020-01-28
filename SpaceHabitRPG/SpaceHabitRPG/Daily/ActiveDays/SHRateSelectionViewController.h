//
//  SHRateSelectionViewController.h
//  SHControlsSpecial
//
//  Created by Joel Pridgen on 6/29/19.
//  Copyright © 2019 Joel Gillette. All rights reserved.
//

#import "SHWeeklyActiveDaysViewController.h"
#import "SHMonthlyActiveDaysViewController.h"
#import "SHYearlyActiveDaysViewController.h"
@import UIKit;
@import SHModels;



NS_ASSUME_NONNULL_BEGIN

@interface SHRateSelectionViewController : SHViewController<SHWeeklyActiveDayChangesProtocol>
@property (strong, nonatomic) IBOutlet SHViewController *rateActiveDaysViewController;
@property (weak, nonatomic) IBOutlet UISegmentedControl *rateSelector;
@property (strong, nonatomic) SHWeeklyActiveDaysViewController *weeklyActiveDaysViewController;
@property (strong, nonatomic) SHMonthlyActiveDaysViewController *monthlyActiveDaysViewController;
@property (strong, nonatomic) SHYearlyActiveDaysViewController *yearlyActiveDaysViewController;
@property (strong, nonatomic) SHDailyActiveDays *activeDays;
@property (strong, nonatomic) IBOutlet SHRateSetterView *intervalSetter;
@property (copy, nonatomic) void (^onCloseIntervalSelect)(SHRateType rateType, NSInteger intervalSize);
-(void)selectRateType:(SHRateType)rateType;
@end

NS_ASSUME_NONNULL_END
