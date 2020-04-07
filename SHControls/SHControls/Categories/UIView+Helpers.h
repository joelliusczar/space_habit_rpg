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
@property (assign, nonatomic) UIColor *SH_borderColor UI_APPEARANCE_SELECTOR;
@property (assign, nonatomic) CGFloat SH_borderWidth UI_APPEARANCE_SELECTOR;
@property (assign, nonatomic) CGFloat SH_cornerRadius UI_APPEARANCE_SELECTOR;
-(void)checkForAndApplyVisualChanges;
-(UIView *)loadXib:(NSString *)nibName;
-(void)fitToContainerView:(UIView *)containerView;
@end
