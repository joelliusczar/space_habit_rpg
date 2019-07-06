//
//  UIViewController+Helper.m
//  SHControls
//
//  Created by Joel Pridgen on 12/23/18.
//  Copyright © 2018 Joel Gillette. All rights reserved.
//

#import "UIViewController+Helper.h"
#import "UIView+Helpers.h"

@implementation UIViewController (Helper)


-(void)pushChildVC:(UIViewController*)child toViewOfParent:(UIView*)view{
  [view addSubview:child.view];
  [self addChildViewController:child];
  [child didMoveToParentViewController:self];
  [view tieConstaintsForsubordinateView:child.view];
}


-(void)arrangeAndPushChildVCToFront:(UIViewController *)child{
  [self pushChildVC:child toViewOfParent:self.view];
}


-(void)popVCFromFront{
  [self willMoveToParentViewController:nil];
  [self.view removeFromSuperview];
  [self removeFromParentViewController];
}


-(void)showErrorView:(NSString*)name withError:(NSError*)error{
  (void)name;
  (void)error;
}


-(void)replaceAllChildViewControllersWith:(UIViewController*)viewController{
  for(UIViewController *vc in self.childViewControllers){
    [vc popVCFromFront];
  }
  [self arrangeAndPushChildVCToFront:viewController];
}

@end
