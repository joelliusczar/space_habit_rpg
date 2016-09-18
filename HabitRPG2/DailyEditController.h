//
//  DailyEditController.h
//  HabitRPG2
//
//  Created by Joel Pridgen on 9/15/16.
//  Copyright © 2016 Joel Pridgen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EditingSaver.h"
#import "CoreDataStackController.h"
#import "DailyViewController.h"


@interface DailyEditController : UIViewController <EditingSaver>
-(id)initWithDataController:(CoreDataStackController *)dataController AndWithParentDailyController:(DailyViewController *)parentDailyController;
@end
