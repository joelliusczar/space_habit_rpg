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
#import "SHEventInfo.h"

@interface ImportanceSliderView ()

@end

@implementation ImportanceSliderView


-(IBAction)importanceSld_valueChanged_action:(UISlider *)sender
                                    forEvent:(UIEvent *)event {
    SHEventInfo *e = eventInfoCopy;
    [self.delegate sld_valueChanged_action:e];
}


@end
