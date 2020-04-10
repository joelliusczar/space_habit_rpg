//
//  SHIconBuilder.m
//  SHCommon
//
//  Created by Joel Pridgen on 12/28/19.
//  Copyright © 2019 Joel Gillette. All rights reserved.
//

#import "SHIconBuilder.h"
#import "SHIconDrawingFunctions.h"

static UIColor *_defaultColor = nil;
static UIColor *_defaultBackgroundColor = nil;
static UIColor *_defaultTertiaryColor = nil;
static CGSize _defaultSize = { 50, 50 };
static CGFloat _defaultThickness = 50;

typedef void (*shDrawShapeFn)(const CGRect *, CGContextRef, CGFloat);

@implementation SHIconBuilder


+(UIColor*)defaultColor {
	if(nil == _defaultColor) {
		_defaultColor = UIColor.blackColor;
	}
	return _defaultColor;
}


+(void)setDefaultColor:(UIColor *)defaultColor {
	_defaultColor = defaultColor;
}


+(UIColor*)defaultBackgroundColor {
	if(nil == _defaultBackgroundColor) {
		_defaultBackgroundColor = UIColor.whiteColor;
	}
	return _defaultBackgroundColor;
}


+(void)setDefaultBackgroundColor:(UIColor*)defaultBackgroundColor {
	_defaultBackgroundColor = defaultBackgroundColor;
}


+(UIColor*)defaultTertiaryColor {
	if(nil == _defaultTertiaryColor) {
		_defaultTertiaryColor = UIColor.grayColor;
	}
	return _defaultTertiaryColor;
}


+(void)setDefaultTertiaryColor:(UIColor*)defaultTertiaryColor {
	_defaultTertiaryColor = defaultTertiaryColor;
}


+(CGSize)defaultSize {
	if(_defaultSize.width < 0 || _defaultSize.width < 0) {
		_defaultSize = CGSizeMake(50, 50);
	}
	return _defaultSize;
}


+(void)setDefaultSize:(CGSize)defaultSize {
	_defaultSize = defaultSize;
}


+(CGFloat)defaultThickness {
	if(_defaultThickness < 0) {
		_defaultThickness = 10;
	}
	return _defaultThickness;
}


+(void)setDefaultThickness:(CGFloat)defaultThickness {
	_defaultThickness = defaultThickness;
}


-(UIColor*)color {
	if(nil == _color) {
		_color = self.class.defaultColor;
	}
	return _color;
}


-(UIColor*)backgroundColor {
	if(nil == _backgroundColor) {
		_backgroundColor = self.class.defaultBackgroundColor;
	}
	return _backgroundColor;
}


-(UIColor*)tertiaryColor {
	if(nil == _tertiaryColor) {
		_tertiaryColor = self.class.defaultTertiaryColor;
	}
	return _tertiaryColor;
}


-(CGSize)size {
	if(_size.width < 0 || _size.height < 0) {
		_size = self.class.defaultSize;
	}
	return _size;
}


-(CGFloat)thickness {
	if(_thickness < 0) {
		_thickness = self.class.defaultThickness;
	}
	return _thickness;
}



-(instancetype)init {
	if(self = [super init]) {
		_thickness = -1;
		_size = CGSizeMake(-1, -1);
	}
	return self;
}

UIImage * drawShape(SHIconBuilder *builder, shDrawShapeFn fn) {
	UIGraphicsImageRenderer *renderer = [[UIGraphicsImageRenderer alloc]
		initWithSize:builder.size
		format:UIGraphicsImageRendererFormat.preferredFormat];
	UIImage *img = [renderer imageWithActions:^(UIGraphicsImageRendererContext *context){
		CGRect bounds = renderer.format.bounds;
		CGContextRef ctx = context.CGContext;
		CGContextSetFillColorWithColor(ctx, builder.backgroundColor.CGColor);
		CGContextFillRect(ctx, bounds);
		CGContextSetFillColorWithColor(ctx, builder.color.CGColor);
		fn(&bounds, ctx, builder.thickness);
	}];
	return [img imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
}




-(UIImage *)drawX {
	UIImage * img = drawShape(self, shDrawX);
	return img;
}


-(UIImage *)drawCheck {
	UIImage * img = drawShape(self, shDrawCheck);
	return img;
}


-(UIImage *)drawPlus {
	UIImage * img = drawShape(self, shDrawPlus);
	return img;
}


-(UIImage *)drawMinus {
	UIImage * img = drawShape(self, shDrawHSegment);
	return img;
}


-(UIImage *)drawForwardArrow {
	UIImage * img = drawShape(self, shDrawArrow);
	return img;
}


-(UIImage *)drawBackArrow {
	UIImage * img = drawShape(self, shDrawArrow);
	return [img imageWithHorizontallyFlippedOrientation];
}


-(UIImage *)drawForwardArrow2 {
	UIImage * img = drawShape(self, shDrawArrow2);
	return img;
}

-(UIImage *)drawBackArrow2 {
	UIImage * img = drawShape(self, shDrawArrow2);
	return [img imageWithHorizontallyFlippedOrientation];
}


-(UIImage *)drawBlank {
	UIImage *img = drawShape(self, shDrawBlank);
	return img;
}

-(UIImage *)drawPie:(CGFloat)percent {
	UIGraphicsImageRenderer *renderer = [[UIGraphicsImageRenderer alloc]
		initWithSize:self.size
		format:UIGraphicsImageRendererFormat.preferredFormat];
	UIImage *img = [renderer imageWithActions:^(UIGraphicsImageRendererContext *context){
		CGRect bounds = renderer.format.bounds;
		CGContextRef ctx = context.CGContext;
		CGContextSetFillColorWithColor(ctx, self.backgroundColor.CGColor);
		CGContextFillRect(ctx, bounds);
		CGContextSetFillColorWithColor(ctx, self.color.CGColor);
		SH_drawPie(&bounds, ctx, percent, self.backgroundColor.CGColor, self.tertiaryColor.CGColor);
	}];
	return [img imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
}
@end

