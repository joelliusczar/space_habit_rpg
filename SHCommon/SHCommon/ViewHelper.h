//
//  ViewHelper.h
//  HabitRPG2
//
//  Created by Joel Pridgen on 1/21/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/*
  Header is deprecated, use the UIVIewController category: Helper instead
*/
void arrangeAndPushVCToFrontOfParent(UIViewController *child,UIViewController *parent);
void popVCFromFront(UIViewController * child);

