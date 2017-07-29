//
//  UIView+Helpers.m
//  HabitRPG2
//
//  Created by Joel Pridgen on 7/21/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import "UIView+Helpers.h"

@implementation UIView (Helpers)

-(void)resizeHeightByOffset:(CGFloat)offset{
    CGRect frame = self.frame;
    frame.size.height += offset;
    self.frame = frame;
}

-(void)resizeBoundsHeightByOffset:(CGFloat)change{
    CGRect bounds = self.bounds;
    bounds.size.height += change;
    self.bounds = bounds;
}


@end