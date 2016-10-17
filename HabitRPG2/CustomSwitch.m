//
//  CustomSwitch.m
//  HabitRPG2
//
//  Created by Joel Pridgen on 10/12/16.
//  Copyright © 2016 Joel Pridgen. All rights reserved.
//

#import "CustomSwitch.h"
@import CoreGraphics;

@implementation CustomSwitch


@synthesize isOn = _isOn;
-(void)setIsOn:(BOOL)isOn{
    _isOn = isOn;
    if(_isOn){
        [self setImage:self.onImage forState:UIControlStateNormal];
    }
    else{
        [self setImage:self.offImage forState:UIControlStateNormal];
    }
}

-(BOOL)isOn{
    return _isOn;
}
 //Only override drawRect: if you perform custom drawing.
 //An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    [self addTarget:self action:@selector(onPress:) forControlEvents:UIControlEventTouchUpInside];
    
}

-(void)onPress:(id)sender{
    self.isOn = !self.isOn;
}


@end
