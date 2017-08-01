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

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self hideCountAllDaysIfNeeded];
}

-(void)hideCountAllDaysIfNeeded{
    BOOL shouldHide = (NSInteger)self.rateStep.value <= 1;
    self.countAllDaysLbl.hidden = shouldHide;
    self.shouldCountAllDaysSwitch.hidden = shouldHide;
}


- (IBAction)rateStep_valueChanged_action:(UIStepper *)sender forEvent:(UIEvent *)event {
    if(self.delegate){
        [self.delegate rateStep_valueChanged_action:sender forEvent:event];
    }
    [self hideCountAllDaysIfNeeded];
}


-(IBAction)countAllDaysSwitch_checked_action:(CustomSwitch *)sender
                                    forEvent:(UIEvent *)event{
    if(self.delegate){
        [self.delegate countAllDaysSwitch_checked_action:sender forEvent:event];
    }
}

@end
