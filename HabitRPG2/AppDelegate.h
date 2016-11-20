//
//  AppDelegate.h
//  HabitRPG2
//
//  Created by Joel Pridgen on 8/26/16.
//  Copyright © 2016 Joel Pridgen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CentralViewController.h"

@class CentralViewController;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) CentralViewController *centralController;

@end

