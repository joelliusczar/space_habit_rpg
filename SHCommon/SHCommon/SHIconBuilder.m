//
//  SHIconBuilder.m
//  SHCommon
//
//  Created by Joel Pridgen on 12/28/19.
//  Copyright © 2019 Joel Gillette. All rights reserved.
//

#import "SHIconBuilder.h"
#import "SHIconDrawingFunctions.h"



typedef void (*shDrawShapeFn)(const CGRect *, CGContextRef, CGFloat);

@implementation SHIconBuilder


-(instancetype)initWithColor:(UIColor *)color
	withBackgroundColor:(UIColor*)backgroundColor
	withSize:(CGSize)size
	withThickness:(CGFloat)thickness
{
	if(self = [super init]) {
		_color = color;
		_backgroundColor = backgroundColor;
		_size = size;
		_thickness = thickness;
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
@end

