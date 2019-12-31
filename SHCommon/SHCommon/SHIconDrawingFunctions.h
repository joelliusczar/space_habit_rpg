//
//  SHIconDrawingFunctions.h
//  SHCommon
//
//  Created by Joel Pridgen on 12/28/19.
//  Copyright © 2019 Joel Gillette. All rights reserved.
//

#ifndef SHIconDrawingFunctions_h
#define SHIconDrawingFunctions_h

#include <stdio.h>
#if IS_IOS
#import <UIKit/UIKit.h>
#endif
@import CoreGraphics;


void shDrawHSegment(const CGRect *bounds, CGContextRef ctx, CGFloat thickness);
void shDrawVSegment(const CGRect *bounds, CGContextRef ctx, CGFloat thickness);
void shDrawPlus(const CGRect *bounds, CGContextRef ctx, CGFloat thickness);
void shDrawCheck(const CGRect *bounds, CGContextRef ctx, CGFloat thickness);
void shDrawSlash(const CGSize *size, CGContextRef ctx, CGFloat thickness, CGPoint startPoint, CGFloat slope);
void shDrawX(const CGRect *bounds, CGContextRef ctx, CGFloat thickness);
void shDrawArrow(const CGRect *bounds, CGContextRef ctx, CGFloat thickness);

#endif /* SHIconDrawingFunctions_h */
