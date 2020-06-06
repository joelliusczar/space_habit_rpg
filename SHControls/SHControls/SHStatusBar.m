//
//  SHStatusBar.m
//  SHControls
//
//  Created by Joel Pridgen on 8/22/19.
//  Copyright © 2019 Joel Gillette. All rights reserved.
//

#import "SHStatusBar.h"
#import <math.h>

@interface SHStatusBar ()
@property (strong,nonatomic) IBOutlet NSLayoutConstraint *heightConstraint;
@end


@implementation SHStatusBar


-(void)setPercent:(double)percent{
	NSAssert(percent >= 0 && percent <= 1, @"fullnessRatio needs to be a fraction between 1 and 0");
	_percent = percent;
	[self setNeedsDisplay];
}


static void drawBarLeftPart(CGContextRef ctx,const CGRect *rect, CGFloat radius,CGFloat xOffset,
	CGFloat barCoverage)
{
	CGFloat minX = CGRectGetMinX(*rect);
	CGFloat midY = CGRectGetMidY(*rect);
	CGFloat x0 = minX + xOffset + radius;
	
	CGContextMoveToPoint(ctx, x0,midY);
	CGContextAddArc(ctx, x0, midY, radius, M_PI * .5, 1.5 * M_PI, 0);
	CGContextFillPath(ctx);
	
	CGContextMoveToPoint(ctx, x0, midY - radius);
	CGRect bar = CGRectMake(x0, midY - radius, barCoverage, 2 * radius);
	CGContextFillRect(ctx, bar);
}


static void drawFullBar(CGContextRef ctx, const CGRect *rect, CGFloat radius, CGFloat xOffset) {
	CGContextBeginPath(ctx);
	CGFloat width = CGRectGetWidth(*rect) -2 * xOffset;
	CGFloat midY = CGRectGetMidY(*rect);
	CGFloat maxX = CGRectGetMaxX(*rect);
	CGFloat x0 = maxX - xOffset - radius;
	
	drawBarLeftPart(ctx,rect,radius,xOffset, width - 2 * radius);
	
	CGContextMoveToPoint(ctx, x0,midY);
	CGContextAddArc(ctx, x0, midY, radius, 1.5 * M_PI, .5 * M_PI, 0);
	CGContextFillPath(ctx);
}


static void drawBarLowBar(CGContextRef ctx, const CGRect *rect, CGFloat radius,
	CGFloat xOffset, CGFloat xSide)
{
	CGFloat minX = CGRectGetMinX(*rect);
	CGFloat midY = CGRectGetMidY(*rect);
	CGFloat angleHeight = sqrt((radius * radius) - (xSide * xSide));
	CGFloat theta = atan(angleHeight / xSide);
	CGFloat gapCos = cos(.5 * M_PI + theta) * radius;
	CGFloat gapSin = sin(.5 * M_PI + theta) * radius;
	CGFloat x0 = minX + xOffset + radius + gapCos;
	CGFloat arcCenterX = minX + xOffset + radius;
	
	CGContextMoveToPoint(ctx, x0, midY + gapSin);
	CGContextAddArc(ctx, arcCenterX, midY, radius, .5 * M_PI + theta, 1.5 * M_PI - theta, 0);
	CGContextAddLineToPoint(ctx, x0, midY + gapSin);
	CGContextFillPath(ctx);
}


static void drawAlmostFullBar(CGContextRef ctx, const CGRect *rect, CGFloat radius,
	CGFloat xOffset, CGFloat fullnessRatio)
{
	CGFloat width = CGRectGetWidth(*rect) -2 * xOffset;
	CGFloat leftHalfWidth = width - radius;
	CGFloat barCoverage = (width * fullnessRatio) - leftHalfWidth;
	CGFloat maxX = CGRectGetMaxX(*rect);
	CGFloat midY = CGRectGetMidY(*rect);
	CGFloat x0 = maxX - xOffset - radius;
	CGFloat angleHeight = sqrt((radius * radius) - (barCoverage * barCoverage));
	CGFloat theta = atan(angleHeight / barCoverage);
	CGFloat x1 = x0 + barCoverage;
	
	drawBarLeftPart(ctx,rect,radius,xOffset,width - 2 * radius);
	
	CGContextMoveToPoint(ctx, x0, midY - radius);
	CGContextAddLineToPoint(ctx, x0, midY + radius);
	CGContextMoveToPoint(ctx, x0, midY + radius);
	CGContextAddArc(ctx, x0, midY, radius, .5 * M_PI, theta, 1);
	CGContextAddLineToPoint(ctx, x1, midY - angleHeight);
	CGContextMoveToPoint(ctx, x1, midY - angleHeight);
	CGContextAddArc(ctx, x0, midY, radius, -theta, 1.5 * M_PI, 1);
	CGContextAddLineToPoint(ctx, x0, midY + radius);
	
	CGContextClosePath(ctx);
	CGContextFillPath(ctx);
	
}


static void drawBorder(CGContextRef ctx, const CGRect *rect, CGFloat radius,
	CGFloat xOffset)
{
	CGFloat minX = CGRectGetMinX(*rect);
	CGFloat midY = CGRectGetMidY(*rect);
	CGFloat maxX = CGRectGetMaxX(*rect);
	CGFloat x0 = minX + xOffset + radius;
	CGFloat x1 = maxX - xOffset - radius;
	CGContextMoveToPoint(ctx, x0, midY - radius);
	CGContextAddArc(ctx, x0, midY, radius, 1.5 * M_PI, .5 * M_PI, 1);
	CGContextAddLineToPoint(ctx, x1, midY + radius);
	CGContextAddArc(ctx, x1, midY, radius, .5 * M_PI, 1.5 * M_PI, 1);
	CGContextAddLineToPoint(ctx, x0, midY - radius);
	CGContextStrokePath(ctx);
}


static void drawStatusBar(CGContextRef ctx, const CGRect *rect,CGFloat fullnessRatio,
	CGColorRef fillColor, CGColorRef emptyColor)
{
	NSCAssert(fullnessRatio >= 0 && fullnessRatio <= 1, @"fullnessRatio needs to be a fraction between 1 and 0");
	CGFloat height = CGRectGetHeight(*rect);
	CGFloat maxBorderWidth = 3;
	CGFloat radius = (height - (maxBorderWidth * 2)) / 2;
	CGFloat xOffset = 10;
	CGFloat width = CGRectGetWidth(*rect) -2*xOffset;
	CGFloat barWidth = width - 2*radius;
	CGFloat leftCircleFraction = radius / width;
	CGFloat sansRightCircleFraction = (radius + barWidth) / width;
	
	CGContextSetFillColorWithColor(ctx, emptyColor);
	drawFullBar(ctx, rect, radius, xOffset);
	
	CGContextSetFillColorWithColor(ctx, fillColor);
	if(fullnessRatio == 1) {
		drawFullBar(ctx, rect, radius, xOffset);
	}
	else if(fullnessRatio < leftCircleFraction) {
		drawBarLowBar(ctx, rect, radius, xOffset, fullnessRatio * width);
	}
	else if(fullnessRatio < sansRightCircleFraction) {
		drawBarLeftPart(ctx, rect, radius, xOffset, (width * fullnessRatio) - radius);
	}
	else {
		drawAlmostFullBar(ctx, rect, radius, xOffset, fullnessRatio);
	}
	CGContextSetStrokeColorWithColor(ctx, UIColor.blackColor.CGColor);
	CGContextSetLineWidth(ctx, maxBorderWidth);
	drawBorder(ctx, rect, radius, xOffset);
	CGContextSetStrokeColorWithColor(ctx, UIColor.whiteColor.CGColor);
	CGContextSetLineWidth(ctx, 1);
	drawBorder(ctx, rect, radius, xOffset);
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
	CGContextRef ctx = UIGraphicsGetCurrentContext();
	drawStatusBar(ctx,&rect,self.percent,self.fullnessColor.CGColor,
		self.emptyColor.CGColor);
}


@end
