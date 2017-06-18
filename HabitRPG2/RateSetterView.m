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

-(instancetype)new{
    return [[NSBundle mainBundle] loadNibNamed:@"RateSetterView" owner:self options:nil][0];
}

- (IBAction)rateStep_valueChanged_action:(UIStepper *)sender forEvent:(UIEvent *)event {
    if(self.delegate){
        [self.delegate rateValueChanged:sender passedEvent:event];
    }
}


@end
