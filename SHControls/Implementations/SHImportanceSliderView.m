//
//	ImportanceSliderViewController.m
//	HabitRPG2
//
//	Created by Joel Pridgen on 6/17/17.
//	Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import "SHImportanceSliderView.h"
@import SHCommon;

@interface SHImportanceSliderView ()

@end

@implementation SHImportanceSliderView


-(IBAction)importanceSld_valueChanged_action:(UISlider *)sender
	forEvent:(UIEvent *)event
{
	(void)sender; (void)event;
	[self.delegate sld_valueChanged_action:self];
}

-(double)value{
	return self.importanceSld.value;
}

-(void)setValue:(double)value{
	self.importanceSld.value = value;
}


-(void)updateImportanceSlider:(int32_t)updateValue{
	self.importanceSld.value = updateValue;
	self.importanceLbl.text = [NSString stringWithFormat:@"%@: %d",self.controlName,updateValue];
}


@end
