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

static UIImage *_defaultOnImage = nil;
static UIImage *_defaultOffImage = nil;
static UIColor *_defaultBackgroundColor = nil;

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


+(UIColor*)defaultBackgroundColor {
	return _defaultBackgroundColor;
}


+(void)setDefaultBackgroundColor:(UIColor *)defaultBackgroundColor {
	_defaultBackgroundColor = defaultBackgroundColor;
}


+(UIImage*)defaultOnImage {
	if(nil == _defaultOnImage) {
		SHIconBuilder *builder = [[SHIconBuilder alloc] initWithColor:UIColor.grayColor
			withBackgroundColor:self.defaultBackgroundColor
			withSize:CGSizeMake(50, 50)
			withThickness:10];
		_defaultOnImage = [builder drawBlank];
	}
	return _defaultOnImage;
}


-(UIImage *)currentOnImage{
#if !TARGET_INTERFACE_BUILDER
	if(self.areColorsInverted){
		return self.onImageColorInverted;
	}
#endif
	NSLog(@"get image");
	if(nil == _onImage) {
		_onImage = self.class.defaultOnImage;
	}
	return _onImage;
}


+(UIImage*)defaultOffImage {
	if(nil == _defaultOnImage) {
		SHIconBuilder *builder = [[SHIconBuilder alloc] initWithColor:UIColor.grayColor
			withBackgroundColor:self.defaultBackgroundColor
			withSize:CGSizeMake(50, 50)
			withThickness:10];
		_defaultOffImage = [builder drawBlank];
	}
	return _defaultOffImage;
}


-(UIImage *)currentOffImage{
#if !TARGET_INTERFACE_BUILDER
	if(self.areColorsInverted){
		return self.offImageColorInverted;
	}
#endif
	if(nil == _offImage) {
		_offImage = self.class.defaultOffImage;
	}
	return _offImage;
}


-(void)setOnImage:(UIImage *)onImage {
	NSLog(@"%@",onImage);
	if(self.mainView) {
		SHSwitch *mainView = (SHSwitch*)self.mainView;
		mainView->_onImage = onImage;
	}
	_onImage = onImage;
}


-(void)setOffImage:(UIImage *)offImage {
	_offImage = offImage;
}

-(void)setSwitchImageForState:(BOOL)isOn{
	if(isOn){
		UIImage *currentImage = self.currentOnImage;
		self.currentImageHolder.image = currentImage;
	}
	else{
		self.currentImageHolder.image = self.currentOffImage;
	}
}

-(void)refreshImage{
	[self setSwitchImageForState:self.isOn];
	[self setNeedsLayout];
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
