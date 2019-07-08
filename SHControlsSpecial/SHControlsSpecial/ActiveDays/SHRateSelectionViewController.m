//
//  SHRateSelectionViewController.m
//  SHControlsSpecial
//
//  Created by Joel Pridgen on 6/29/19.
//  Copyright © 2019 Joel Gillette. All rights reserved.
//

#import "SHRateSelectionViewController.h"
#import <SHControls/UIViewController+Helper.h>
#import <SHModels/SHRateTypeHelper.h>
#import <SHCommon/NSException+SHCommonExceptions.h>


const NSInteger DAILY_SELECTION = 0;
const NSInteger WEEKLY_SELECTION = 1;
const NSInteger MONTHLY_SELECTION = 2;
const NSInteger YEARLY_SELECTION = 3;

@interface SHRateSelectionViewController ()
@property (assign, nonatomic) SHRateType rateType;
@end

@implementation SHRateSelectionViewController


-(SHWeeklyActiveDaysViewController*)weeklyActiveDays{
  if(nil == _weeklyActiveDays){
    NSBundle *bundle = [NSBundle bundleForClass:SHWeeklyActiveDaysViewController.class];
    _weeklyActiveDays = [[SHWeeklyActiveDaysViewController alloc]
      initWithNibName:@"SHWeeklyActiveDaysFull"
      bundle:bundle];
  }
  return _weeklyActiveDays;
}


-(SHMonthlyActiveDaysViewController*)monthlyActiveDays{
  if(nil == _monthlyActiveDays){
    _monthlyActiveDays = [SHMonthlyActiveDaysViewController
      newWithListRateItemCollection:self.activeDays.monthlyActiveDays
      inverseActiveDays:self.activeDays.monthlyActiveDaysInv];
  }
  return _monthlyActiveDays;
}


-(SHYearlyActiveDaysViewController*)yearlyActiveDays{
  if(nil == _yearlyActiveDays){
    _yearlyActiveDays = [SHYearlyActiveDaysViewController newWithListRateItemCollection:self.activeDays.yearlyActiveDays
      inverseActiveDays:self.activeDays.yearlyActiveDaysInv];
  }
  return _yearlyActiveDays;
}


- (void)viewDidLoad {
  [super viewDidLoad];
  [self switchToActiveDaysViewController:WEEKLY_SELECTION];
}


-(IBAction)back_touch_action:(UIButton *)sender forEvent:(UIEvent *)event{
  (void)sender; (void)event;
  [self popVCFromFront];
}

-(IBAction)rateType_valueChanged_action:(UISegmentedControl *)sender
  forEvent:(UIEvent *)event
{
  (void)event;
  SHRateType rateType = [self segmentIndexToRateType:sender.selectedSegmentIndex];
  self.rateType = rateType;
  [self switchToActiveDaysViewController:rateType];
}


-(void)switchToActiveDaysViewControllerByIndex:(NSInteger)segmentIndex {
  SHRateType rateType = [self segmentIndexToRateType:segmentIndex];
  [self switchToActiveDaysViewController:rateType];
}

-(void)switchToActiveDaysViewController:(SHRateType)rateType{
  SHRateType baseRateType = shExtractBaseRateType(rateType);
  switch (baseRateType) {
    case SH_DAILY_RATE:
      
    case SH_WEEKLY_RATE:
      [self.weeklyActiveDays setActiveDaysOfWeek:self.activeDays.weeklyActiveDays];
      [self.rateActiveDaysViewController arrangeAndPushChildVCToFront:self.weeklyActiveDays];
      break;
    case SH_MONTHLY_RATE:
      [self.rateActiveDaysViewController arrangeAndPushChildVCToFront:self.monthlyActiveDays];
      break;
    case SH_YEARLY_RATE:
      [self.rateActiveDaysViewController arrangeAndPushChildVCToFront:self.yearlyActiveDays];
      break;
    default:
      @throw [NSException oddException];
  }
}

-(SHRateType)segmentIndexToRateType:(NSInteger)segmentIndex{
  switch (segmentIndex) {
    case DAILY_SELECTION:
      return SH_DAILY_RATE;
    case WEEKLY_SELECTION:
      return SH_WEEKLY_RATE;
    case MONTHLY_SELECTION:
      return SH_MONTHLY_RATE;
    case YEARLY_SELECTION:
      return SH_YEARLY_RATE;
    default:
      return SH_UNDETERMINED_RATE;
  }
}


-(NSInteger)rateTypeToSegmentIndex:(SHRateType)rateType{
  SHRateType useRateType = shExtractBaseRateType(rateType);
  switch (useRateType) {
    case SH_DAILY_RATE:
      return DAILY_SELECTION;
    case SH_WEEKLY_RATE:
      return WEEKLY_SELECTION;
    case SH_MONTHLY_RATE:
      return MONTHLY_SELECTION;
    case SH_YEARLY_RATE:
      return YEARLY_SELECTION;
    default:
      @throw [NSException oddException];
  }
}


-(void)selectRateType:(SHRateType)rateType{
  NSInteger selectionIndex = [self rateTypeToSegmentIndex:rateType];
  self.rateType = rateType;
  if(self.isViewLoaded && self.view.window){
    [self.rateSelector setEnabled:YES forSegmentAtIndex:selectionIndex];
  }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
