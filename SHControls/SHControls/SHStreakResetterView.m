//
//	SHStreakResetterView.m
//	HabitRPG2
//
//	Created by Joel Pridgen on 6/24/17.
//	Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import "SHStreakResetterView.h"

@implementation SHStreakResetterView


-(IBAction)streakResetBtn_press_action:(UIButton *)sender
	forEvent:(UIEvent *)event
{
	(void)event; (void)sender;
	if(self.streakReset){
		self.streakReset();
	}
}


@end
