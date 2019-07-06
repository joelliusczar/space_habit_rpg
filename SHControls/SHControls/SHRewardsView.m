//
//  SHRewardsView.m
//  HabitRPG2
//
//  Created by Joel Pridgen on 6/24/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import "SHRewardsView.h"
#import <SHCommon/NSObject+Helper.h>
#import "SHEventInfo.h"

@implementation SHRewardsView

- (IBAction)addRewardsBtn_press_action:(UIButton *)sender forEvent:(UIEvent *)event
{
  SHEventInfo *e = eventInfoCopy;
  [self.delegate addRewardsBtn_press_action:e];
}


@end
