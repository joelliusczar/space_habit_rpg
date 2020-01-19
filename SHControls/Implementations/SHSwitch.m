//
//	CustomSwitch.m
//	HabitRPG2
//
//	Created by Joel Pridgen on 10/12/16.
//	Copyright © 2016 Joel Pridgen. All rights reserved.
//

#import "SHSwitch.h"
@import SHCommon;
@import CoreGraphics;

@implementation SHSwitch



@synthesize isOn = _isOn;
-(void)setIsOn:(BOOL)isOn{
	_isOn = isOn;
	if(self.mainView && [self.mainView isKindOfClass:SHSwitch.class]){
		SHSwitch *shSwitch = (SHSwitch*)self.mainView;
		shSwitch.isOn = isOn;
	}
	else{
		[self setSwitchImageForState:_isOn];
	}
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
		self.currentImageHolder.image = self.currentOnImage;
	}
	else{
		self.currentImageHolder.image = self.currentOffImage;
	}
}

-(void)refreshImage{
	[self setSwitchImageForState:self.isOn];
}

 //Only override drawRect: if you perform custom drawing.
 //An empty implementation adversely affects performance during animation.
//- (void)drawRect:(CGRect)rect {
//	[super drawRect:rect];
//}

-(void)beginTap_action:(UITouch *)touch
	withEvent:(UIEvent *)event
{
	[super beginTap_action:touch withEvent:event];
	 self.isOn = !self.isOn;
}



@end
