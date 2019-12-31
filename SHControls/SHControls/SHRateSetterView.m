//
//	rateSetterViewController.m
//	HabitRPG2
//
//	Created by Joel Pridgen on 6/18/17.
//	Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import "SHRateSetterView.h"
#import "EventArgs/SHEventInfo.h"
@import SHCommon;


@interface SHRateSetterView ()
@end

@implementation SHRateSetterView


@synthesize textColor = _textColor;
-(UIColor*)textColor {
	UIColor *color = _textColor ? _textColor : UIColor.blackColor;
	return color;
}


-(void)setTextColor:(UIColor *)textColor {
	[self _simpleSetTextColor:textColor];
	[self redrawButtons];
}


@synthesize labelSingularFormatString = _labelSingularFormatString;
-(NSString*)labelSingularFormatString {
	return _labelSingularFormatString;
}


-(void)setLabelSingularFormatString:(NSString *)labelSingularFormatString {
	_labelSingularFormatString = labelSingularFormatString;
	if(self.intervalSize == 1) {
		[self updateLabelTextWithInterval:self.intervalSize];
	}
}

@synthesize labelPluralFormatString = _labelPluralFormatString;
-(NSString*)labelPluralFormatString {
	return _labelPluralFormatString;
}


-(void)setLabelPluralFormatString:(NSString *)labelPluralFormatString {
	_labelPluralFormatString = labelPluralFormatString;
	if(self.intervalSize != 1) {
		[self updateLabelTextWithInterval:self.intervalSize];
	}
}


-(void)setIntervalSize:(NSInteger)intervalSize{
	_intervalSize = intervalSize;
	self.rateStep.value = intervalSize;
	[self updateLabelTextWithInterval:intervalSize];
}


-(void)_simpleSetTextColor: (UIColor *)color {
	_textColor = color;
	self.intervalLabel.textColor = color;
}


-(void)setupCustomOptions{
	[super setupCustomOptions];
}


-(void)updateLabelTextWithInterval:(NSInteger)intervalValue{
	NSString *useFormatString = intervalValue == 1 ?
		self.labelSingularFormatString :
		self.labelPluralFormatString;
	if(nil == useFormatString) return;
	self.intervalLabel.text = [NSString stringWithFormat:useFormatString,intervalValue];
}


- (IBAction)rateStep_valueChanged_action:(UIStepper *)sender forEvent:(UIEvent *)event {
	NSInteger intervalValue = (NSInteger)sender.value;
	[self updateLabelTextWithInterval:intervalValue];
	if(self.rateStepEvent){
		self.rateStepEvent(sender,event);
	}
}


-(void)redrawButtons {
	CGSize imgSize = [self.rateStep incrementImageForState:UIControlStateNormal].size;
	SHIconBuilder *builder = [[SHIconBuilder alloc]
		initWithColor:self.textColor
		withBackgroundColor:self.backgroundColor
		withSize:imgSize
		withThickness:1];
	UIImage *incrImg = [builder drawPlus];
	UIImage *decrImg = [builder drawMinus];
	[self.rateStep setIncrementImage:incrImg forState:UIControlStateNormal];
	[self.rateStep setDecrementImage:decrImg forState:UIControlStateNormal];
}


-(BOOL)_simpleSetBackgroundColor:(UIColor *)backgroundColor {
	super.backgroundColor = backgroundColor;
	if(nil == self.rateStep) return false;
	self.intervalLabel.backgroundColor = backgroundColor;
	self.rateStep.backgroundColor = backgroundColor;
	return YES;
}


-(void)setBackgroundColor:(UIColor *)backgroundColor {
	if(![self _simpleSetBackgroundColor:backgroundColor]) return;
	[self redrawButtons];
}


-(void)traitCollectionDidChange:(UITraitCollection *)previousTraitCollection {
	[super traitCollectionDidChange:previousTraitCollection];
	if (@available(iOS 12.0, *)) {
		if(self.traitCollection.userInterfaceStyle != previousTraitCollection.userInterfaceStyle) {
			UIColor *background = [UIColor colorNamed:@"background"
																			 inBundle:NSBundle.mainBundle
									compatibleWithTraitCollection:self.traitCollection];
			UIColor *textColor = [UIColor colorNamed:@"text"
																			inBundle:NSBundle.mainBundle
								 compatibleWithTraitCollection:self.traitCollection];
			[self _simpleSetBackgroundColor:background];
			[self _simpleSetTextColor:textColor];
			[self redrawButtons];
		}
	} else {
		// Fallback on earlier versions
	}
}


@end
