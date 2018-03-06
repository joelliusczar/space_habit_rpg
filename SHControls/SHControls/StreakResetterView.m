//
//  StreakResetterView.m
//  HabitRPG2
//
//  Created by Joel Pridgen on 6/24/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import "StreakResetterView.h"
#import "EventArgs/SHEventInfo.h"

@implementation StreakResetterView


- (IBAction)streakResetBtn_press_action:(UIButton *)sender
                               forEvent:(UIEvent *)event {
    wrapReturnVoid wrappedCall = ^void(){
        SHEventInfo *e = eventInfoCopy;
        [self.delegate streakResetBtn_press_action:e];
    };
    [self.interceptor callVoidWrapped:wrappedCall withInfo:nil];
}


@end