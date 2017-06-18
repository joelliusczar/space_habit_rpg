//
//  ImportanceSliderViewController.m
//  HabitRPG2
//
//  Created by Joel Pridgen on 6/17/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import "ImportanceSliderView.h"

@interface ImportanceSliderView ()

@end

@implementation ImportanceSliderView

-(instancetype)new{
    return [[NSBundle mainBundle] loadNibNamed:@"ImportanceSliderView" owner:self options:nil][0];
}

- (IBAction)urgencySld_valueChanged_action:(UISlider *)sender forEvent:(UIEvent *)event {
    if(self.delegate){
        [self.delegate urgencyLvlChanged:sender passedEvent:event];
    }
}

- (IBAction)difficultySld_valueChanged_action:(UISlider *)sender forEvent:(UIEvent *)event {
    if(self.delegate){
        [self.delegate difficultyLvlChanged:sender passedEvent:event];
    }
}

@end
