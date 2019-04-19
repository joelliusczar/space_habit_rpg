//
//  rateSetterViewController.m
//  HabitRPG2
//
//  Created by Joel Pridgen on 6/18/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import "SHRateSetterView.h"
#import "EventArgs/SHEventInfo.h"

@interface SHRateSetterView ()

@end

@implementation SHRateSetterView


- (IBAction)rateStep_valueChanged_action:(UIStepper *)sender forEvent:(UIEvent *)event {
    shWrapReturnVoid wrappedCall = ^void(){
        SHEventInfo *e = eventInfoCopy;
        [self.delegate rateStep_valueChanged_action:e];
    };
    [self.interceptor callVoidWrapped:wrappedCall withInfo:nil];
}



@end
