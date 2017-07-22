//
//  UIScrollView+ScrollAdjusters.m
//  HabitRPG2
//
//  Created by Joel Pridgen on 7/21/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import "UIScrollView+ScrollAdjusters.h"

@implementation UIScrollView (ScrollAdjusters)

-(void)scrollByOffset:(CGFloat)offset{
    CGPoint point = self.contentOffset;
    point.y += offset;
    self.contentOffset = point;
}

@end
