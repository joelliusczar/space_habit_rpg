//
//	SHAddItemsFooter.m
//	HabitRPG2
//
//	Created by Joel Pridgen on 7/1/17.
//	Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import "SHAddItemsFooter.h"

@implementation SHAddItemsFooter

-(IBAction)addItemBtn_press_action:(UIButton *)sender forEvent:(UIEvent *)event {
	(void)sender; (void)event;
	[self.delegate addItemBtn_press_action];
}

@end
