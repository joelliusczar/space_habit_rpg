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
  [self switchToActiveDaysViewController:self.rateType];
  __weak typeof(self) weakSelf = self;
  self.intervalSetter.rateStepEvent = ^(UIStepper *stepper,UIEvent *e){
    typeof(weakSelf) bSelf = weakSelf;
    [bSelf rateStepEvent:stepper event:e];
  };
  [self.intervalSetter changeBackgroundColorTo: [UIColor whiteColor]];
  [self.intervalSetter setSubControlColorsTo: [UIColor colorWithRed:36.0/255 green:126.0/255 blue:217.0/255 alpha:1]];
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

-(void)loadDailyRateView {
  self.intervalSetter.labelSingularFormatString = @"Interval: Every day";
  self.intervalSetter.labelPluralFormatString = @"Interval: Every %ld days";
  self.intervalSetter.intervalSize = self.activeDays.dailyIntervalSize;
  [self.rateActiveDaysViewController popAllChildVCs];
}

- (void)loadWeeklyRateView {
  self.weeklyActiveDays.weeklyActiveDays = self.activeDays.weeklyActiveDays;
  self.intervalSetter.labelSingularFormatString = @"Interval: Every week";
  self.intervalSetter.labelPluralFormatString = @"Interval: Every %ld weeks";
  self.intervalSetter.intervalSize = self.activeDays.weeklyIntervalSize;
  [self.rateActiveDaysViewController arrangeAndPushChildVCToFront:self.weeklyActiveDays];
}

- (void)loadMonthlyRateView {
  self.intervalSetter.labelSingularFormatString = @"Interval: Every month";
  self.intervalSetter.labelPluralFormatString = @"Interval: Every %ld months";
  self.intervalSetter.intervalSize = self.activeDays.monthlyIntervalSize;
  [self.rateActiveDaysViewController arrangeAndPushChildVCToFront:self.monthlyActiveDays];
}

- (void)loadYearlyRateView {
  self.intervalSetter.labelSingularFormatString = @"Interval: Every year";
  self.intervalSetter.labelPluralFormatString = @"Interval: Every %ld years";
  self.intervalSetter.intervalSize = self.activeDays.yearlyIntervalSize;
  [self.rateActiveDaysViewController arrangeAndPushChildVCToFront:self.yearlyActiveDays];
}

-(void)switchToActiveDaysViewController:(SHRateType)rateType{
  NSAssert(self.activeDays,@"We need active days to not be nill");
  SHRateType baseRateType = shExtractBaseRateType(rateType);
  switch (baseRateType) {
    case SH_DAILY_RATE:
      [self loadDailyRateView];
      break;
    case SH_WEEKLY_RATE:
      [self loadWeeklyRateView];
      break;
    case SH_MONTHLY_RATE:
      [self loadMonthlyRateView];
      break;
    case SH_YEARLY_RATE:
      [self loadYearlyRateView];
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


-(void)switchActiveDay:(NSInteger)dayIdx value:(BOOL)value{
  (void)value;
  //for now, we're not actually using the inverse stuff.
  //but I keep it around incase I change my mind.
  [self.activeDays flipDayOfWeek:dayIdx forPolarity:NO];
}


-(void)rateStepEvent:(UIStepper *)stepper event:(UIEvent*)event{
  (void)event;
  int32_t intervalSize = (int32_t)stepper.value;
  switch (self.rateType) {
    case SH_DAILY_RATE:
      self.activeDays.dailyIntervalSize = intervalSize;
      break;
    case SH_WEEKLY_RATE:
      self.activeDays.weeklyIntervalSize = intervalSize;
      break;
    case SH_MONTHLY_RATE:
      self.activeDays.monthlyIntervalSize = intervalSize;
      break;
    case SH_YEARLY_RATE:
      self.activeDays.yearlyIntervalSize = intervalSize;
      break;
    case SH_DAILY_RATE_INVERSE:
      self.activeDays.dailyIntervalSizeInv = intervalSize;
      break;
    case SH_WEEKLY_RATE_INVERSE:
      self.activeDays.weeklyIntervalSizeInv = intervalSize;
      break;
    case SH_MONTHLY_RATE_INVERSE:
      self.activeDays.monthlyIntervalSizeInv = intervalSize;
      break;
    case SH_YEARLY_RATE_INVERSE:
      self.activeDays.yearlyIntervalSizeInv = intervalSize;
      break;
  default:
    @throw [NSException oddException];
    break;
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
