//
//  ViewHelper.m
//  HabitRPG2
//
//  Created by Joel Pridgen on 1/21/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import "ViewHelper.h"

@implementation ViewHelper

+(void)pushViewToFront:(UIViewController * _Nonnull)child
              OfParent:(UIViewController * _Nonnull)parent{
    NSAssert(child,@"child was nil");
    NSAssert(parent,@"parent was nil");
    [parent.view addSubview:child.view];
    [parent addChildViewController:child];
    [child didMoveToParentViewController:parent];
}

+(void)popViewFromFront:(UIViewController * _Nonnull)child{
    NSAssert(child,@"child was nil");
    [child willMoveToParentViewController:nil];
    [child.view removeFromSuperview];
    [child removeFromParentViewController];
}

@end
