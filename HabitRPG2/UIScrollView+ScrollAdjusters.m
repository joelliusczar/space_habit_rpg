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
    CGRect frame = self.frame;
    frame.origin.y += (offset + self.contentOffset.y);
    [self scrollRectToVisible:frame animated:YES];
}


-(void)resizeContentHeight:(CGFloat)change{
    CGSize size = self.contentSize;
    size.height += change;
    self.contentSize = size;
}

@end
