//
//  UIScrollView+ScrollAdjusters.h
//  HabitRPG2
//
//  Created by Joel Pridgen on 7/21/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIScrollView (ScrollAdjusters)

-(void)scrollByOffset:(CGFloat)offset;
-(void)resizeContentHeight:(CGFloat)change;

@end
