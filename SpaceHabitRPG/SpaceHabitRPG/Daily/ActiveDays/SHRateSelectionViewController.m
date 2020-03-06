//
//	SHRateSelectionViewController.m
//	SHControlsSpecial
//
//	Created by Joel Pridgen on 6/29/19.
//	Copyright © 2019 Joel Gillette. All rights reserved.
//

#import "SHRateSelectionViewController.h"
@import SHControls;
@import SHModels;
@import SHCommon;


const NSInteger DAILY_SELECTION = 0;
const NSInteger WEEKLY_SELECTION = 1;
const NSInteger MONTHLY_SELECTION = 2;
const NSInteger YEARLY_SELECTION = 3;

@interface SHRateSelectionViewController ()
@property (assign, nonatomic) SHRateType rateType;
@property (strong, nonatomic) IBOutlet UIButton *backButton;
@end

@implementation SHRateSelectionViewController

-(void)setViewBackgroundColor:(UIColor *)viewBackgroundColor {
	super.viewBackgroundColor = viewBackgroundColor;
	self.intervalSetter.viewBackgroundColor = viewBackgroundColor;
}

-(SHWeeklyActiveDaysViewController*)weeklyActiveDaysViewController{
	if(nil == _weeklyActiveDaysViewController) {
		_weeklyActiveDaysViewController = [SHWeeklyActiveDaysViewController newWithDefaultNib];
		_weeklyActiveDaysViewController.weeklyActiveDays = self.activeDays.weeklyActiveDays;
		_weeklyActiveDaysViewController.valueChangeDelegate = self;
	}
	return _weeklyActiveDaysViewController;
}


-(SHMonthlyActiveDaysViewController*)monthlyActiveDaysViewController{
	if(nil == _monthlyActiveDaysViewController){
		_monthlyActiveDaysViewController = [SHMonthlyActiveDaysViewController
			newWithListRateItemCollection:self.activeDays.monthlyActiveDays
			inverseActiveDays:self.activeDays.monthlyActiveDaysInv];
		_monthlyActiveDaysViewController.linkedViewController = self;
	}
	return _monthlyActiveDaysViewController;
}


-(SHYearlyActiveDaysViewController*)yearlyActiveDaysViewController{
	if(nil == _yearlyActiveDaysViewController){
		_yearlyActiveDaysViewController = [SHYearlyActiveDaysViewController newWithListRateItemCollection:self.activeDays.yearlyActiveDays
			inverseActiveDays:self.activeDays.yearlyActiveDaysInv];
		_yearlyActiveDaysViewController.linkedViewController = self;
	}
	return _yearlyActiveDaysViewController;
}


-(void)viewDidLoad {
	[super viewDidLoad];
	[self pushChildVC:self.intervalSetter toViewOfParent:self.intervalContainer];
	[self switchToActiveDaysViewController:self.rateType];
	__weak SHRateSelectionViewController *weakSelf = self;
	self.intervalSetter.rateStepEvent = ^(UIStepper *stepper,UIEvent *e){
		SHRateSelectionViewController *bSelf = weakSelf;
		[bSelf rateStepEvent:stepper event:e];
	};

}


-(void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	SHIconBuilder *builder = [[SHIconBuilder alloc] initWithColor:UIColor.grayColor
		withBackgroundColor:self.viewBackgroundColor
		withSize:CGSizeMake(30, 30)
		withThickness:5];
	UIImage *backImg = [builder drawBackArrow2];
	[self.backButton setImage:backImg forState:UIControlStateNormal];
}


-(IBAction)back_touch_action:(UIButton *)sender forEvent:(UIEvent *)event{
	(void)sender; (void)event;
	if(self.onCloseIntervalSelect) {
		SHIntervalItemFormat *intervalItem = [self.activeDays selectRateItemCollection:self.rateType];
		self.onCloseIntervalSelect(self.rateType,intervalItem.intervalSize);
	}
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


-(SHViewController*)selectActiveDaysViewController:(SHRateType)rateType {
	SHRateType useRateType = shExtractBaseRateType(rateType);
	switch (useRateType) {
		case SH_DAILY_RATE:
			return nil;
		case SH_WEEKLY_RATE:
			return self.weeklyActiveDaysViewController;
		case SH_MONTHLY_RATE:
			return self.monthlyActiveDaysViewController;
		case SH_YEARLY_RATE:
			return self.yearlyActiveDaysViewController;
		default:
			@throw [NSException oddException];
	}
}


-(void)switchToActiveDaysViewController:(SHRateType)rateType{
	NSAssert(self.activeDays,@"We need active days to not be nill");
	
	SHIntervalItemFormat *rateItem = [self.activeDays selectRateItemCollection:rateType];
	
	NSString *singularString = [NSString stringWithFormat:@"Interval: %@",[rateItem.class singularFormatString]];
	NSString *pluralString = [NSString stringWithFormat:@"Interval: %@",[rateItem.class pluralFormatString]];
	self.intervalSetter.labelSingularFormatString = singularString;
	self.intervalSetter.labelPluralFormatString = pluralString;
	self.intervalSetter.intervalSize = rateItem.intervalSize;
	
	SHViewController *selectedActiveDaysVC = [self selectActiveDaysViewController:rateType];
	[self.rateActiveDaysViewController popAllChildVCs];
	if(selectedActiveDaysVC) {
		[self.rateActiveDaysViewController arrangeAndPushChildVCToFront:selectedActiveDaysVC];
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
	[self.activeDays.weeklyActiveDays flipDayOfWeek:dayIdx];
}


-(void)rateStepEvent:(UIStepper *)stepper event:(UIEvent*)event{
	(void)event;
	int32_t intervalSize = (int32_t)stepper.value;
	SHIntervalItemFormat *rateItemCollection = [self.activeDays selectRateItemCollection:self.rateType];
	rateItemCollection.intervalSize = intervalSize;
}


//-(void)traitCollectionDidChange:(UITraitCollection *)previousTraitCollection
//{
//	[super traitCollectionDidChange:previousTraitCollection];
//	if (@available(iOS 12.0, *)) {
//		UIColor *background = [UIColor colorNamed:@"background"
//			inBundle:NSBundle.mainBundle
//			compatibleWithTraitCollection:self.traitCollection];
//		UIColor *text = [UIColor colorNamed:@"text"
//			inBundle:NSBundle.mainBundle
//			compatibleWithTraitCollection:self.traitCollection];
//		[self.intervalSetter setColors:background text:text];
//	}
//}

@end
