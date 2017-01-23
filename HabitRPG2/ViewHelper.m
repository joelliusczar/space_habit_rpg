//
//  ViewHelper.m
//  HabitRPG2
//
//  Created by Joel Pridgen on 1/21/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import "ViewHelper.h"

@implementation ViewHelper

+(void)pushViewToFront:(UIViewController *)child OfParent:(UIViewController *)parent{
    [parent.view addSubview:child.view];
    [parent addChildViewController:child];
    [child didMoveToParentViewController:parent];
}

+(void)popViewFromFront:(UIViewController *)child OfParent:(UIViewController *)parent{
    [child willMoveToParentViewController:nil];
    [child.view removeFromSuperview];
    [child removeFromParentViewController];
}

@end
