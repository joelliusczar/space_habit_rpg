//
//  CustomSwitch.m
//  HabitRPG2
//
//  Created by Joel Pridgen on 10/12/16.
//  Copyright © 2016 Joel Pridgen. All rights reserved.
//

#import "CustomSwitch.h"
#import "CommonUtilities.h"
@import CoreGraphics;

@implementation CustomSwitch



@synthesize isOn = _isOn;
-(void)setIsOn:(BOOL)isOn{
    _isOn = isOn;
    [self setSwitchImageForState:_isOn];
}

-(BOOL)isOn{
    return _isOn;
}

@synthesize areColorsInverted = _areColorsInverted;
-(void)setAreColorsInverted:(BOOL)areColorsInverted{
    _areColorsInverted = areColorsInverted;
    [self refreshImage];
}


@synthesize onImageColorInverted = _onImageColorInverted;
-(UIImage *)onImageColorInverted{
    if(!_onImageColorInverted){
        _onImageColorInverted = [CommonUtilities invertImageColors:self.onImage];
    }
    return _onImageColorInverted;
}

@synthesize offImageColorInverted = _offImageColorInverted;
-(UIImage *)offImageColorInverted{
    if(!_offImageColorInverted){
        _offImageColorInverted = [CommonUtilities invertImageColors:self.offImage];
    }
    return _offImageColorInverted;
}

-(UIImage *)currentOnImage{
    if(self.areColorsInverted){
        return self.onImageColorInverted;
    }
    return _onImage;
}

-(UIImage *)currentOffImage{
    if(self.areColorsInverted){
        return self.offImageColorInverted;
    }
    return _offImage;
}

-(void)setSwitchImageForState:(BOOL)isOn{
    if(isOn){
        [self setImage:self.currentOnImage forState:UIControlStateNormal];
    }
    else{
        [self setImage:self.currentOffImage forState:UIControlStateNormal];
    }
}

-(void)refreshImage{
    [self setSwitchImageForState:self.isOn];
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
