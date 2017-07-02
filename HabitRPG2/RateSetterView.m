//
//  rateSetterViewController.m
//  HabitRPG2
//
//  Created by Joel Pridgen on 6/18/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import "RateSetterView.h"

@interface RateSetterView ()

@end

@implementation RateSetterView

+(CGRect)naturalFrame{
    return CGRectMake(0,0,302,100);
}


- (IBAction)rateStep_valueChanged_action:(UIStepper *)sender forEvent:(UIEvent *)event {
    if(self.delegate){
        [self.delegate rateStep_valueChanged_action:sender forEvent:event];
    }
}


@end
