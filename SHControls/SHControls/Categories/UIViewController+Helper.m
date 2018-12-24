//
//  UIViewController+Helper.m
//  SHControls
//
//  Created by Joel Pridgen on 12/23/18.
//  Copyright © 2018 Joel Gillette. All rights reserved.
//

#import "UIViewController+Helper.h"

@implementation UIViewController (Helper)

-(void)arrangeAndPushChildVCToFront:(UIViewController *)child{
  NSCAssert(child,@"child was nil");
  child.view.frame = self.view.bounds;
  [self.view addSubview:child.view];
  [self addChildViewController:child];
  [child didMoveToParentViewController:self];
}


-(void)popChildVCFromFront{
  [self willMoveToParentViewController:nil];
  [self.view removeFromSuperview];
  [self removeFromParentViewController];
}

@end
