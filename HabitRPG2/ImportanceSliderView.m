//
//  ImportanceSliderViewController.m
//  HabitRPG2
//
//  Created by Joel Pridgen on 6/17/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import "ImportanceSliderView.h"
#import "P_CommonDelegate.h"

@interface ImportanceSliderView ()

@end

@implementation ImportanceSliderView

+(CGRect)naturalFrame{
    return CGRectMake(0,0,297,152);
}


-(instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        _mainView =
        [[NSBundle mainBundle]
         loadNibNamed:NSStringFromClass(self.class)
         owner:self options:nil][0];
        
        [self addSubview: _mainView];
    }
    return self;
}


-(IBAction)urgencySld_valueChanged_action:(UISlider *)sender forEvent:(UIEvent *)event {
    if(self.delegate){
        [self.delegate urgencySld_valueChanged_action:sender forEvent:event];
    }
}


-(IBAction)difficultySld_valueChanged_action:(UISlider *)sender forEvent:(UIEvent *)event {
    if(self.delegate){
        [self.delegate difficultySld_valueChanged_action:sender forEvent:event];
    }
}

@end
