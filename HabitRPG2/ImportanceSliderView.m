//
//  ImportanceSliderViewController.m
//  HabitRPG2
//
//  Created by Joel Pridgen on 6/17/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import "ImportanceSliderView.h"
#import "P_CommonDelegate.h"
#import "NSObject+Helper.h"

@interface ImportanceSliderView ()

@end

@implementation ImportanceSliderView

+(CGRect)naturalFrame{
    return CGRectMake(0,0,297,152);
}


-(IBAction)importanceSld_valueChanged_action:(UISlider *)sender
                                    forEvent:(UIEvent *)event {
    if(self.delegate){
        [self.delegate importanceSld_valueChanged_action:self
                                                forEvent:event];
    }
}


@end
