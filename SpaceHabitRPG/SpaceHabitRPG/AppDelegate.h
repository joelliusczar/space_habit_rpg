//
//  AppDelegate.h
//  HabitRPG2
//
//  Created by Joel Pridgen on 8/26/16.
//  Copyright © 2016 Joel Pridgen. All rights reserved.
//

#import "SHCentralViewController.h"
#import <sqlite3.h>
#import <pthread.h>
@import UIKit;
@import SHUtils_C;


@class SHCentralViewController;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) SHCentralViewController *centralController;
@property (readonly, nonatomic) sqlite3 *db;
@property (readonly, nonatomic) pthread_t dbSerialThread;
@property (readonly, nonatomic) struct SHSerialQueue *queue;
@end

