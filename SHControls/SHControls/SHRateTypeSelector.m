//
//	SHRateTypeSelector.m
//	HabitRPG2
//
//	Created by Joel Pridgen on 8/2/17.
//	Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import "SHRateTypeSelector.h"
#import "UIViewController+Helper.h"
#import <SHCommon/SHInterceptor.h>
#import "UIView+Helpers.h"
#import "SHEventInfo.h"

@interface SHRateTypeSelector ()

@end

@implementation SHRateTypeSelector

-(instancetype)initWithRateType:(SHRateType)rateType
	andDelegate:(id<SHRateTypeSelectorDelegateProtocol>)delegate
{
	NSBundle *bundle = [NSBundle bundleForClass:self.class];
	if(self = [super initWithNibName:NSStringFromClass(self.class) bundle:bundle]){
		_rateType = rateType;
		_delegate = delegate;
	}
	return self;
}


-(void)viewDidLoad{
	[super viewDidLoad];
	UITapGestureRecognizer *tapGestureBG = [[UITapGestureRecognizer alloc]
		initWithTarget:self
		 action:@selector(background_tap_action:)];
	[self.backgroundView addGestureRecognizer:tapGestureBG];
	[self formatView];
}


- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}


-(void)formatView{
	[self setupBorder:self.everyXBtn];
	[self setupBorder:self.weeklyBtn];
	[self setupBorder:self.monthlyBtn];
	[self setupBorder:self.yearlyBtn];
	[self setupBorder:self.view];
	[self setCheckmark:self.rateType];
}


-(void)setupBorder:(UIView *)view{
	NSAssert(view,@"button was nil");
	[view setupBorder:UIRectEdgeTop|UIRectEdgeBottom
		withThickness:1.0f
		andColor:[UIColor lightGrayColor]];
}


-(void)setCheckmark:(SHRateType)rateType{
	self.everyXCheckLbl.hidden = rateType!=SH_DAILY_RATE;
	self.weeklyCheckLbl.hidden = rateType!=SH_WEEKLY_RATE;
	self.monthlyCheckLbl.hidden = rateType!=SH_MONTHLY_RATE;
	self.yearlyCheckLbl.hidden = rateType!=SH_YEARLY_RATE;
}


-(void)background_tap_action:(UITapGestureRecognizer *)sender{
	if(sender.view == self.backgroundView){
		[self popVCFromFront];
	}
}


-(IBAction)rateType_click_action:(UIView *)sender forEvent:(UIEvent *)event{
	SHRateType rateType = self.rateType;
	if(self.delegate){
		if(sender == self.yearlyBtn){
			rateType = SH_YEARLY_RATE;
		}
		else if(sender == self.monthlyBtn){
			rateType = SH_MONTHLY_RATE;
		}
		else if(sender == self.weeklyBtn){
			rateType = SH_WEEKLY_RATE;
		}
		else{
			rateType = SH_DAILY_RATE;
		}
		SHEventInfo *e = eventInfoCopy;
		[self.delegate updateRateType: rateType with:e];
	}
	[self setCheckmark:rateType];
	//I want to display some sort of visible change in response to
	//the user action before the view goes away
	long arbitraryDispatchTime = 100000;
	dispatch_after(dispatch_walltime(nil,arbitraryDispatchTime),dispatch_get_main_queue(),^(){
		[self popVCFromFront];
	});
}




@end
