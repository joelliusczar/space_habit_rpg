//
//  ViewHelper.m
//  HabitRPG2
//
//  Created by Joel Pridgen on 1/21/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import "ViewHelper.h"


void arrangeAndPushVCToFrontOfParent(UIViewController *child,UIViewController *parent){
    NSCAssert(child,@"child was nil");
    NSCAssert(parent,@"parent was nil");
    child.view.frame = parent.view.bounds;
    [parent.view addSubview:child.view];
    [parent addChildViewController:child];
    [child didMoveToParentViewController:parent];
}

void popVCFromFront(UIViewController * child){
    NSCAssert(child,@"child was nil");
    [child willMoveToParentViewController:nil];
    [child.view removeFromSuperview];
    [child removeFromParentViewController];
}

