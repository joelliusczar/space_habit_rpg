//
//  DailyViewController.h
//  HabitRPG2
//
//  Created by Joel Pridgen on 8/26/16.
//  Copyright © 2016 Joel Pridgen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CoreDataStackController.h"
#import "BaseViewController.h"
#import "Daily.h"


@interface DailyViewController : UIViewController
-(id)initWithDataController:(CoreDataStackController *)dataController AndWithParent:(BaseViewController *)parent;
-(void)setuptab:(CoreDataStackController *)dataController;
-(void)showNewDaily:(Daily *)daily;
@end
