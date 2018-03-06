//
//  CustomSwitch.m
//  HabitRPG2
//
//  Created by Joel Pridgen on 10/12/16.
//  Copyright © 2016 Joel Pridgen. All rights reserved.
//

#import "SHSwitch.h"
#import <SHCommon/UIImage+Helper.h>
@import CoreGraphics;

@implementation SHSwitch



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
        _onImageColorInverted = [self.onImage invertImageColors];
    }
    return _onImageColorInverted;
}

@synthesize offImageColorInverted = _offImageColorInverted;
-(UIImage *)offImageColorInverted{
    if(!_offImageColorInverted){
        _offImageColorInverted = [self.offImage invertImageColors];
    }
    return _offImageColorInverted;
}

-(UIImage *)currentOnImage{
#if !TARGET_INTERFACE_BUILDER
    if(self.areColorsInverted){
        return self.onImageColorInverted;
    }
#endif
    return _onImage;
}

-(UIImage *)currentOffImage{
#if !TARGET_INTERFACE_BUILDER
    if(self.areColorsInverted){
        return self.offImageColorInverted;
    }
#endif
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
//- (void)drawRect:(CGRect)rect {
//    [super drawRect:rect];
//}

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wunused-parameter"

-(BOOL)beginTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event{
    [self sendActionsForControlEvents:UIControlEventTouchUpInside];
    self.isOn = !self.isOn;
    return NO;
}

#pragma clang diagnostic pop

@end
