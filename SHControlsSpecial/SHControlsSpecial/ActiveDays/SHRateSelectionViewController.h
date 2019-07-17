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
#import <UIKit/UIKit.h>
#import <SHModels/SHDailyActiveDays.h>
#import <SHGlobal/SHConstants.h>


NS_ASSUME_NONNULL_BEGIN

@interface SHRateSelectionViewController : UIViewController<SHWeeklyActiveDayChangesProtocol>
@property (strong, nonatomic) IBOutlet UIViewController *rateActiveDaysViewController;
@property (weak, nonatomic) IBOutlet UISegmentedControl *rateSelector;
@property (strong, nonatomic) SHWeeklyActiveDaysViewController *weeklyActiveDays;
@property (strong, nonatomic) SHMonthlyActiveDaysViewController *monthlyActiveDays;
@property (strong, nonatomic) SHYearlyActiveDaysViewController *yearlyActiveDays;
@property (weak, nonatomic) UIViewController *backViewController;
@property (strong, nonatomic) SHDailyActiveDays *activeDays;
-(void)selectRateType:(SHRateType)rateType;
@end

NS_ASSUME_NONNULL_END
