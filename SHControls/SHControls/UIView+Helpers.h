//
//  UIView+Helpers.h
//  HabitRPG2
//
//  Created by Joel Pridgen on 7/21/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//
#define isTestingInvert NO

@import UIKit;

@interface UIView (Helpers)

-(void)resizeAutoLayoutHeightByOffset:(CGFloat)offset;
-(void)setupBorder:(UIRectEdge)edges withThickness:(CGFloat)thickness andColor:(UIColor *)color;
-(void)replaceSubviewsWith:(UIView *)view;
-(void)checkForAndApplyVisualChanges;
-(void)translateViewVertically:(CGFloat)offset;
-(void)resetVerticalOrigin;
-(void)tieConstaintsForsubordinateView:(UIView *)view;
-(void)tieHorizontalConstaintsForSubordinateView:(UIView *)view;
-(void)tieVerticalConstraintsForsubordinateView:(UIView*)view;
@end
