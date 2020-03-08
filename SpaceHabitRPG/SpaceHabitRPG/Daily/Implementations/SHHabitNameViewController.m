//
//  SHHabitNameViewController.m
//  SpaceHabitRPG
//
//  Created by Joel Pridgen on 3/6/20.
//  Copyright © 2020 Joel Gillette. All rights reserved.
//

#import "SHHabitNameViewController.h"

@interface SHHabitNameViewController ()
@property (assign, nonatomic) id token;
@end

@implementation SHHabitNameViewController

-(IBAction)backBtn_press_action:(UIButton *)sender
	forEvent:(UIEvent *)event
{
	(void)sender; (void)event;
	[self popVCFromFront];
}


-(IBAction)nextBtn_press_action:(UIButton *)sender
	forEvent:(UIEvent *)event
{
	(void)sender; (void)event;
	if(self.onNext) {
		self.onNext(self.namebox.text);
	}
}


-(BOOL)textField:(UITextField *)textField
	shouldChangeCharactersInRange:(NSRange)range
	replacementString:(NSString *)string
{
	if(string.length > 0) {
		self.next.enabled = YES;
	}
	else {
		self.next.enabled = textField.text.length > range.length;
	}
	return YES;
}

@end
