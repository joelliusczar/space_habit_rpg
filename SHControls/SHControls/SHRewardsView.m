//
//	SHRewardsView.m
//	HabitRPG2
//
//	Created by Joel Pridgen on 6/24/17.
//	Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import "SHRewardsView.h"
#import "SHEventInfo.h"
@import SHCommon;

@implementation SHRewardsView

- (IBAction)addRewardsBtn_press_action:(UIButton *)sender forEvent:(UIEvent *)event
{
	SHEventInfo *e = eventInfoCopy;
	[self.rewardsDelegate addRewardsBtn_press_action:e];
}


@end
