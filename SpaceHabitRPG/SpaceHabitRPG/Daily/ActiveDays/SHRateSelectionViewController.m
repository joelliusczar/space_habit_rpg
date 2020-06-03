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
@property (assign, nonatomic) SHIntervalType rateType;
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
		_weeklyActiveDaysViewController.activeDays = self.activeDays;
		_weeklyActiveDaysViewController.valueChangeDelegate = self;
	}
	return _weeklyActiveDaysViewController;
}


-(SHMonthlyActiveDaysViewController*)monthlyActiveDaysViewController{
	if(nil == _monthlyActiveDaysViewController){
//		_monthlyActiveDaysViewController = [SHMonthlyActiveDaysViewController
//			newWithListRateItemCollection:self.activeDays.monthlyActiveDays
//			inverseActiveDays:self.activeDays.monthlyActiveDaysInv];
//		_monthlyActiveDaysViewController.linkedViewController = self;
	}
	return _monthlyActiveDaysViewController;
}


-(SHYearlyActiveDaysViewController*)yearlyActiveDaysViewController{
	if(nil == _yearlyActiveDaysViewController){
//		_yearlyActiveDaysViewController = [SHYearlyActiveDaysViewController newWithListRateItemCollection:self.activeDays.yearlyActiveDays
//			inverseActiveDays:self.activeDays.yearlyActiveDaysInv];
//		_yearlyActiveDaysViewController.linkedViewController = self;
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
	self.intervalSetter.descriptionArgs = self.activeDays;
}


-(void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	SHIconBuilder *builder = [[SHIconBuilder alloc] init];
	builder.color = UIColor.grayColor;
	builder.backgroundColor = self.viewBackgroundColor;
	builder.size = CGSizeMake(30, 30);
	builder.thickness = 5;
	UIImage *backImg = [builder drawBackArrow2];
	[self.backButton setImage:backImg forState:UIControlStateNormal];
}


-(IBAction)back_touch_action:(UIButton *)sender forEvent:(UIEvent *)event{
	(void)sender; (void)event;
	if(self.onCloseIntervalSelect) {
		SHIntervalType intervalType = self.activeDays->intervalType;
		int32_t intervalSize = SH_getIntervalSizeForType(self.activeDays, intervalType);
		self.onCloseIntervalSelect(intervalType, intervalSize);
	}
	[self popVCFromFront];
}


-(IBAction)rateType_valueChanged_action:(UISegmentedControl *)sender
	forEvent:(UIEvent *)event
{
	(void)event;
	SHIntervalType rateType = [self segmentIndexToRateType:sender.selectedSegmentIndex];
	self.rateType = rateType;
	[self switchToActiveDaysViewController:rateType];
}


-(void)switchToActiveDaysViewControllerByIndex:(NSInteger)segmentIndex {
	SHIntervalType rateType = [self segmentIndexToRateType:segmentIndex];
	[self switchToActiveDaysViewController:rateType];
}


-(SHViewController*)selectActiveDaysViewController:(SHIntervalType)rateType {
	SHIntervalType useRateType = SH_extractBaseIntervalType(rateType);
	switch (useRateType) {
		case SH_DAILY_INTERVAL:
			return nil;
		case SH_WEEKLY_INTERVAL:
			return self.weeklyActiveDaysViewController;
		case SH_MONTHLY_INTERVAL:
			return self.monthlyActiveDaysViewController;
		case SH_YEARLY_INTERVAL:
			return self.yearlyActiveDaysViewController;
		default:
			@throw [NSException oddException];
	}
}


-(void)switchToActiveDaysViewController:(SHIntervalType)intervalType {

	char *(*descriptionBuilder)(int32_t, struct SHActiveDaysValues *) = SH_selectDescriptionBuilderFunc(intervalType);

	self.intervalSetter.buildDescription = ^NSString *(int32_t intervalSize, void *descriptionArgs) {
		if(NULL == descriptionBuilder) return nil;
		struct SHActiveDaysValues *activeDays = (struct SHActiveDaysValues *)descriptionArgs;
		return [NSString stringWithUTF8String:descriptionBuilder(intervalSize, activeDays)];
	};
	SHViewController *selectedActiveDaysVC = [self selectActiveDaysViewController:intervalType];
	[self.rateActiveDaysViewController popAllChildVCs];
	if(selectedActiveDaysVC) {
		[self.rateActiveDaysViewController arrangeAndPushChildVCToFront:selectedActiveDaysVC];
	}
}


-(SHIntervalType)segmentIndexToRateType:(NSInteger)segmentIndex{
	switch (segmentIndex) {
		case DAILY_SELECTION:
			return SH_DAILY_INTERVAL;
		case WEEKLY_SELECTION:
			return SH_WEEKLY_INTERVAL;
		case MONTHLY_SELECTION:
			return SH_MONTHLY_INTERVAL;
		case YEARLY_SELECTION:
			return SH_YEARLY_INTERVAL;
		default:
			return SH_UNDETERMINED_INTERVAL;
	}
}


-(NSInteger)rateTypeToSegmentIndex:(SHIntervalType)rateType{
	SHIntervalType useRateType = SH_extractBaseIntervalType(rateType);
	switch (useRateType) {
		case SH_DAILY_INTERVAL:
			return DAILY_SELECTION;
		case SH_WEEKLY_INTERVAL:
			return WEEKLY_SELECTION;
		case SH_MONTHLY_INTERVAL:
			return MONTHLY_SELECTION;
		case SH_YEARLY_INTERVAL:
			return YEARLY_SELECTION;
		default:
			@throw [NSException oddException];
	}
}


-(void)selectRateType:(SHIntervalType)rateType{
	NSInteger selectionIndex = [self rateTypeToSegmentIndex:rateType];
	self.rateType = rateType;
	if(self.isViewLoaded && self.view.window){
		[self.rateSelector setEnabled:YES forSegmentAtIndex:selectionIndex];
	}
}


-(void)switchActiveDay:(int32_t)dayIdx value:(BOOL)value{
	bool cValue = value ? true : false;
	SH_setDayValue(self.activeDays, self.activeDays->intervalType, dayIdx, cValue);
}


-(void)rateStepEvent:(UIStepper *)stepper event:(UIEvent*)event{
	(void)event;
	int32_t intervalSize = (int32_t)stepper.value;
	SHIntervalType intervalType = self.activeDays->intervalType;
	SH_setCurrentIntervalSize(self.activeDays, intervalType, intervalSize);
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
