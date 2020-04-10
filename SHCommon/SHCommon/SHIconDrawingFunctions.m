//
//  SHIconDrawingFunctions.c
//  SHCommon
//
//  Created by Joel Pridgen on 12/28/19.
//  Copyright © 2019 Joel Gillette. All rights reserved.
//

#include "SHIconDrawingFunctions.h"
#import <math.h>




void shDrawHSegment(const CGRect *bounds, CGContextRef ctx, CGFloat thickness) {
	CGFloat xOffset = bounds->size.width * .1;
	CGFloat yOffset = thickness;
	CGFloat x0 = xOffset;
	CGFloat y0 = CGRectGetMidY(*bounds) -(yOffset / 2);
	CGFloat x1 = CGRectGetMaxX(*bounds) - xOffset;
	CGFloat y1 = y0 + yOffset;
	CGContextMoveToPoint(ctx, x0, y0);
	CGContextAddLineToPoint(ctx, x1, y0);
	CGContextAddLineToPoint(ctx, x1, y1);
	CGContextAddLineToPoint(ctx, x0, y1);
	CGContextAddLineToPoint(ctx, x0, y0);
	CGContextFillPath(ctx);
}


void shDrawVSegment(const CGRect *bounds, CGContextRef ctx, CGFloat thickness) {
	CGFloat xOffset = thickness;
	CGFloat yOffset = bounds->size.height * .1;
	CGFloat x0 = CGRectGetMidX(*bounds) + (xOffset / 2);
	CGFloat y0 = yOffset;
	CGFloat x1 = x0 - xOffset;
	CGFloat y1 = CGRectGetMaxY(*bounds) - yOffset;
	CGContextMoveToPoint(ctx, x0, y0);
	CGContextAddLineToPoint(ctx, x1, y0);
	CGContextAddLineToPoint(ctx, x1, y1);
	CGContextAddLineToPoint(ctx, x0, y1);
	CGContextAddLineToPoint(ctx, x0, y0);
	CGContextFillPath(ctx);
}


void shDrawPlus(const CGRect *bounds, CGContextRef ctx, CGFloat thickness) {
	shDrawHSegment(bounds, ctx, thickness);
	shDrawVSegment(bounds, ctx, thickness);
}


static CGFloat calcIndependentVar(CGFloat dist, CGFloat slope) {
	return dist / sqrt(1 + slope * slope);
}


static CGPoint calcNextSlopePoint2(const CGPoint *prev, CGFloat delta, CGFloat slope) {
	if(delta == 0) return CGPointMake(prev->x, prev->y + slope);
	return CGPointMake(prev->x + delta, prev->y + delta * slope);
}


static CGPoint calcNextSlopePoint(const CGPoint *prev, CGFloat length, CGFloat slope) {
	CGFloat delta = calcIndependentVar(length, slope);
	return calcNextSlopePoint2(prev, delta, slope);
}


void shDrawCheck(const CGRect *bounds, CGContextRef ctx, CGFloat thickness) {
	CGFloat w = bounds->size.width;
	CGFloat h = bounds->size.height;
	int32_t len = 7;
	CGPoint points[len];
	CGFloat slope1 = 1.2; //arbitrary
	CGFloat slope2 = 2 / slope1;
	CGFloat shortLegBase = sqrt(.05 * w * w + .2 * h * h);
	CGFloat longLegBase = sqrt(.4 * w * w + .4 * h * h);
	
	points[0] = CGPointMake(w * .1, CGRectGetMidY(*bounds) + h * .05);
	points[1] = calcNextSlopePoint(&points[0], shortLegBase, slope1);
	points[2] = calcNextSlopePoint(&points[1], longLegBase, -slope2);
	points[3] = calcNextSlopePoint(&points[2], -thickness, slope1);
	points[4] = calcNextSlopePoint(&points[3], -1 * (longLegBase - thickness), -slope2);
	points[5] = calcNextSlopePoint(&points[4], -1 * (shortLegBase - thickness), slope1);
	points[6] = points[0];
	CGContextAddLines(ctx, points, len);
	 
	
	CGContextFillPath(ctx);
	
}


void shDrawSlash(const CGSize *size, CGContextRef ctx, CGFloat thickness, CGPoint startPoint, CGFloat slope) {
	CGFloat w = size->width;
	CGFloat h = size->height;
	CGFloat legBase = sqrt(.36 * w * w + .36 * h * h);
	
	int32_t len = 5;
	CGPoint points[len];
	points[0] = calcNextSlopePoint(&startPoint, -thickness / 2, -slope);
	points[1] = calcNextSlopePoint(&points[0], legBase, slope);
	points[2] = calcNextSlopePoint(&points[1], thickness, -slope);
	points[3] = calcNextSlopePoint(&points[2], -legBase, slope);
	points[4] = points[0];
	
	CGContextAddLines(ctx, points, len);
	 
	
	CGContextFillPath(ctx);
	
}


void shDrawX(const CGRect *bounds, CGContextRef ctx, CGFloat thickness) {
	CGSize size = bounds->size;
	shDrawSlash(&size, ctx, thickness, CGPointMake(size.width * .2, size.height * .2), 1);
	shDrawSlash(&size, ctx, thickness, CGPointMake(size.width * .2, size.height * .8), -1);
}



void shDrawArrow(const CGRect *bounds, CGContextRef ctx, CGFloat thickness) {
	CGFloat w = bounds->size.width;
	CGFloat h = bounds->size.height;
	CGFloat hPaddingFactor = .15;
	CGFloat vPaddingFactor = .075;
	CGFloat slope1 = tan(M_PI / 6);
	CGFloat innerLeg = sqrt(.09 * w * w + .64 * h * h);
	
	int32_t len = 7;
	CGPoint points[len];
	points[0] = CGPointMake(w * hPaddingFactor, h * vPaddingFactor + thickness);
	points[1] = calcNextSlopePoint(&points[0], 0, -thickness);
	points[2] = calcNextSlopePoint(&points[1], innerLeg, slope1);
	points[3] = calcNextSlopePoint(&points[2], -innerLeg, -slope1);
	points[4] = calcNextSlopePoint(&points[3], 0, -thickness);
	CGFloat outerLeg = innerLeg - 4 * sin(atan(slope1)) * thickness;
	points[5] = calcNextSlopePoint(&points[4], outerLeg, -slope1);

	points[6] = points[0];
	CGContextAddLines(ctx, points, 7);

	CGContextFillPath(ctx);
}


void shDrawArrow2(const CGRect *bounds, CGContextRef ctx, CGFloat thickness) {

	CGFloat w = bounds->size.width;
	CGFloat h = bounds->size.height;
	CGFloat angle = M_PI / 4;
	CGFloat slope = tan(angle);
	CGFloat outsideLine = sqrt(.01 * w * w + .36 * h * h);
	
	CGFloat leg = sin(angle) * thickness;
	CGFloat insideLine = outsideLine - leg;

	int32_t len = 7;
	CGPoint points[len];

	points[0] = CGPointMake(0, 0);
	points[1] = calcNextSlopePoint(&points[0], leg, -slope);
	points[2] = calcNextSlopePoint(&points[1], outsideLine, slope);
	points[3] = calcNextSlopePoint(&points[2], -outsideLine, -slope);
	points[4] = calcNextSlopePoint(&points[3], -leg, slope);
	
	points[5] = calcNextSlopePoint(&points[4], insideLine, -slope);

	points[6] = points[0];

	CGContextTranslateCTM(ctx, CGRectGetMidX(*bounds) -(points[2].x ) + points[5].x, CGRectGetMidY(*bounds) - points[2].y);
	CGContextAddLines(ctx, points, 7);

	CGContextFillPath(ctx);
}


void shDrawBlank(const CGRect *bounds, CGContextRef ctx, CGFloat thickness) {
	(void)bounds; (void)ctx; (void)thickness;
}


void SH_drawPie(const CGRect *bounds, CGContextRef ctx, CGFloat percent,
	CGColorRef background, CGColorRef pieColor)
{
	CGFloat w = bounds->size.width;
	CGFloat radius = w * .5 * .9;
	CGFloat midX = CGRectGetMidX(*bounds);
	CGFloat midY = CGRectGetMidY(*bounds);
	CGContextMoveToPoint(ctx, midX + radius, midY);
	CGContextAddArc(ctx, midX, midY, radius, 0, -2 * M_PI, 1);
	CGContextFillPath(ctx);
	
	CGFloat innerRadius = w * .5 * .8;
	
	CGContextSetFillColorWithColor(ctx, background);
	CGContextMoveToPoint(ctx, midX, midY);
	CGContextAddArc(ctx, midX, midY, innerRadius, 0, -2 * M_PI, 1);
	CGContextFillPath(ctx);
	
	CGContextSetFillColorWithColor(ctx, pieColor);
	CGContextMoveToPoint(ctx, midX, midY);
	CGContextAddArc(ctx, midX, midY, innerRadius, 0, -2 * M_PI * percent, 1);
	CGContextAddLineToPoint(ctx, midX, midY);
	CGContextFillPath(ctx);
}
