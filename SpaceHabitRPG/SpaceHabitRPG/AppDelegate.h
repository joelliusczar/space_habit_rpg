//
//  AppDelegate.h
//  HabitRPG2
//
//  Created by Joel Pridgen on 8/26/16.
//  Copyright © 2016 Joel Pridgen. All rights reserved.
//


#import <sqlite3.h>
#import <pthread.h>
@import UIKit;
@import SHUtils_C;
@import SHCommon;
@import SHModels;
@import SHDatetime;

@class SHCentralViewController;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) UIViewController *centralController;
@property (readonly, nonatomic) struct SHSerialQueue *dbQueue;
@property (readonly, nonatomic) const struct SHConfigAccessor *config;
@property (strong, nonatomic) SHResourceUtility *resourceUtil;
@property (readonly, nonatomic) const struct SHDatetimeProvider *dateProvider;
@end

