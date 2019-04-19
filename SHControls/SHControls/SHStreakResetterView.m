//
//  SHStreakResetterView.m
//  HabitRPG2
//
//  Created by Joel Pridgen on 6/24/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import "SHStreakResetterView.h"
#import "EventArgs/SHEventInfo.h"

@implementation SHStreakResetterView


- (IBAction)streakResetBtn_press_action:(UIButton *)sender
                               forEvent:(UIEvent *)event {
    shWrapReturnVoid wrappedCall = ^void(){
        SHEventInfo *e = eventInfoCopy;
        [self.delegate streakResetBtn_press_action:e];
    };
    [self.interceptor callVoidWrapped:wrappedCall withInfo:nil];
}


@end