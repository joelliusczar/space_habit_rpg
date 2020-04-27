//
//  SHIconDrawingFunctions.h
//  SHCommon
//
//  Created by Joel Pridgen on 12/28/19.
//  Copyright © 2019 Joel Gillette. All rights reserved.
//

#ifndef SHIconDrawingFunctions_h
#define SHIconDrawingFunctions_h

#import <stdio.h>
#import <TargetConditionals.h>
#if TARGET_OS_MACCATALYST || TARGET_OS_IOS
@import UIKit;
#endif
@import CoreGraphics;


void shDrawHSegment(const CGRect *bounds, CGContextRef ctx, CGFloat thickness);
void shDrawVSegment(const CGRect *bounds, CGContextRef ctx, CGFloat thickness);
void shDrawPlus(const CGRect *bounds, CGContextRef ctx, CGFloat thickness);
void shDrawCheck(const CGRect *bounds, CGContextRef ctx, CGFloat thickness);
void shDrawSlash(const CGSize *size, CGContextRef ctx, CGFloat thickness, CGPoint startPoint, CGFloat slope);
void shDrawX(const CGRect *bounds, CGContextRef ctx, CGFloat thickness);
void shDrawArrow(const CGRect *bounds, CGContextRef ctx, CGFloat thickness);
void shDrawArrow2(const CGRect *bounds, CGContextRef ctx, CGFloat thickness);
void shDrawBlank(const CGRect *bounds, CGContextRef ctx, CGFloat thickness);
void SH_drawPie(const CGRect *bounds, CGContextRef ctx, CGFloat percent,
	CGColorRef background, CGColorRef pieColor);

#endif /* SHIconDrawingFunctions_h */
