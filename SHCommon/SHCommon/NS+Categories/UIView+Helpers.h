//
//  UIView+Helpers.h
//  HabitRPG2
//
//  Created by Joel Pridgen on 7/21/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//
#define isTestingInvert NO

#import <UIKit/UIKit.h>

@interface UIView (Helpers)

-(void)resizeHeightByOffset:(CGFloat)offset;
-(void)setupBorder:(UIRectEdge)edges withThickness:(CGFloat)thickness andColor:(UIColor *)color;
-(void)resizeFrame:(CGSize)size;
-(void)replaceSubviewsWith:(UIView *)view;
-(void)invertViewColors;
-(void)applyVisualChangeToAllSubviews;
-(void)checkForAndApplyVisualChanges;
-(void)invertTitleColorForAllStates;
-(void)invertTitleShadowColorForAllStates;
@end
