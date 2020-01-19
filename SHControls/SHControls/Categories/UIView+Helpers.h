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
@property (nonatomic) UIColor *SH_borderColor UI_APPEARANCE_SELECTOR;
@property (nonatomic) CGFloat SH_borderWidth UI_APPEARANCE_SELECTOR;
@property (nonatomic) CGFloat SH_cornerRadius UI_APPEARANCE_SELECTOR;
-(void)checkForAndApplyVisualChanges;
-(UIView *)loadXib:(NSString *)nibName;
@end
