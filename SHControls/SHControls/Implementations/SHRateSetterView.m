//
//	rateSetterViewController.m
//	HabitRPG2
//
//	Created by Joel Pridgen on 6/18/17.
//	Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import "SHRateSetterView.h"
#import "UIView+Helpers.h"
@import SHCommon;


@interface SHRateSetterView ()

@end

@implementation SHRateSetterView



-(void)loadView {
	NSBundle *bundle = [NSBundle bundleForClass:self.class];
	UINib *nib = [UINib nibWithNibName:NSStringFromClass(self.class) bundle:bundle];
	NSArray *results = [nib instantiateWithOwner:self options:nil];
	if(results.count > 0) {
		self.view = results[0];
	}
}


@synthesize textColor = _textColor;
-(UIColor*)textColor {
	UIColor *color = _textColor ? _textColor : UIColor.blackColor;
	return color;
}


-(void)setTextColor:(UIColor *)textColor {
	_textColor = textColor;
	self.intervalLabel.textColor = textColor;
}


-(void)setIntervalSize:(NSInteger)intervalSize{
	_intervalSize = intervalSize;
	self.rateStep.value = intervalSize;
	[self updateLabelTextWithInterval:intervalSize];
}


-(void)updateLabelTextWithInterval:(NSInteger)intervalValue{
	if(self.buildDescription) {
		self.intervalLabel.text = self.buildDescription((int32_t)intervalValue, self.descriptionArgs);
	}
}


-(IBAction)rateStep_valueChanged_action:(UIStepper *)sender forEvent:(UIEvent *)event {
	NSInteger intervalValue = (NSInteger)sender.value;
	[self updateLabelTextWithInterval:intervalValue];
	if(self.rateStepEvent){
		self.rateStepEvent(sender,event);
	}
}


-(void)redrawButtons {
	CGSize imgSize = [self.rateStep incrementImageForState:UIControlStateNormal].size;
	SHIconBuilder *builder = [[SHIconBuilder alloc] init];
	builder.color = self.textColor;
	builder.backgroundColor = self.viewBackgroundColor;
	builder.size = imgSize;
	builder.thickness = 1;

	UIImage *incrImg = [builder drawPlus];
	UIImage *decrImg = [builder drawMinus];
	[self.rateStep setIncrementImage:incrImg forState:UIControlStateNormal];
	[self.rateStep setDecrementImage:decrImg forState:UIControlStateNormal];
}


-(void)dealloc {
	if(self.descriptionArgsCleanup) {
		self.descriptionArgsCleanup(self.descriptionArgs);
	}
}


@end
