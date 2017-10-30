//
//  rateSetterViewController.m
//  HabitRPG2
//
//  Created by Joel Pridgen on 6/18/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import "RateSetterView.h"
#import "SHEventInfo.h"

@interface RateSetterView ()

@end

@implementation RateSetterView


- (IBAction)rateStep_valueChanged_action:(UIStepper *)sender forEvent:(UIEvent *)event {
    wrapReturnVoid wrappedCall = ^void(){
        SHEventInfo *e = eventInfoCopy;
        [self.delegate rateStep_valueChanged_action:e];
    };
    [self.interceptor callVoidWrapped:wrappedCall withInfo:nil];
}



@end
