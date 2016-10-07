//
//  IntroViewController.h
//  HabitRPG2
//
//  Created by Joel Pridgen on 9/29/16.
//  Copyright © 2016 Joel Pridgen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CoreDataStackController.h"
#import "Settings.h"

@interface IntroViewController : UIViewController
-(id)initWithDataController:(CoreDataStackController *)dataController AndSettings:(Settings *)userSettings;
@end
