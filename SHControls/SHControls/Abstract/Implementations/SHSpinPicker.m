//
//	SHSpinPicker.m
//	HabitRPG2
//
//	Created by Joel Pridgen on 8/2/17.
//	Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import "SHSpinPicker.h"
@import SHCommon;
#import "UIViewController+Helper.h"

@interface SHSpinPicker ()
@property (weak,nonatomic) IBOutlet NSLayoutConstraint *buttonXConstraint;

@end

@implementation SHSpinPicker


-(UIColor*)pickerBackground {
	return self.picker.backgroundColor;
}


-(void)setPickerBackground:(UIColor *)pickerBackground {
	self.picker.backgroundColor = pickerBackground;
}


-(UIColor*)cellTextColor {
	UIColor *textColor = _cellTextColor ? _cellTextColor : UIColor.blackColor;
	return textColor;
}


-(instancetype)init{
	NSBundle *bundle = [NSBundle bundleForClass:NSClassFromString(@"SHSpinPicker")];
	if(self = [super initWithNibName:@"SHSpinPicker" bundle:bundle]){}
	return self;
}


-(void)viewDidLoad{
	[super viewDidLoad];
	UITapGestureRecognizer *tapGestureBG = [[UITapGestureRecognizer alloc]
		initWithTarget:self
		action:@selector(background_tap_action:)];
	[self.view addGestureRecognizer:tapGestureBG];
}


-(void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	//self.picker.backgroundColor = nil == self.pickerBackground ? UIColor.whiteColor : self.pickerBackground;
}


-(void)background_tap_action:(UITapGestureRecognizer *)sender{
	if(sender.view==self.view){
		[self popVCFromFront];
	}
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}


-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
	(void)pickerView;
	@throw [NSException abstractException];
}


-(NSInteger)pickerView:(UIPickerView *)pickerView
	numberOfRowsInComponent:(NSInteger)component
{
	(void)pickerView; (void)component;
	@throw [NSException abstractException];
}


-(void)animateInvalidSelection{

	CGFloat offset = 25;
	UIViewPropertyAnimator *animator = [[UIViewPropertyAnimator alloc] initWithDuration:.25
	curve:UIViewAnimationCurveEaseInOut
	animations:^{
		self.buttonXConstraint.constant += offset;
		[self.view layoutIfNeeded];
	}];
	[animator addAnimations:^{
		self.buttonXConstraint.constant -= offset*2;
		[self.view layoutIfNeeded];
	} delayFactor:.50];
	[animator addAnimations:^{
		self.buttonXConstraint.constant += offset;
		[self.view layoutIfNeeded];
	} delayFactor:.75];
	[animator startAnimation];
}


-(IBAction)pickerSelectBtn_press_action:(UIButton *)sender
	forEvent:(UIEvent *)event
{
	(void)sender; (void)event;
	if(self.spinPickerAction) {
	BOOL shouldCancel = NO;
	self.spinPickerAction(self,&shouldCancel);
	if(shouldCancel) return;
	}
	[self popVCFromFront];

}


-(NSInteger)selectedRowInComponent:(NSInteger)component{
	return [self.picker selectedRowInComponent:component];
}

-(NSString * _Nullable)buildTitle:(NSInteger)component
	row:(NSInteger)row
{
	(void)component; (void)row;
	@throw [NSException abstractException];
}


-(UIView *)pickerView:(UIPickerView *)pickerView
	viewForRow:(NSInteger)row
	forComponent:(NSInteger)component
	reusingView:(UIView *)view
{
	(void)pickerView; (void)view;
	NSString *title = [self buildTitle:component row:row];
	UILabel *cell = [[UILabel alloc] init];
	cell.text = title;
	cell.textColor = self.cellTextColor;
	return cell;
}

@end
