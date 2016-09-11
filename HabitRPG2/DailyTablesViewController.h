//
//  DailyTablesViewController.h
//  HabitRPG2
//
//  Created by Joel Pridgen on 8/31/16.
//  Copyright © 2016 Joel Pridgen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CoreDataStackController.h"
#import "Daily.h"

@interface DailyTablesViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

-(void)setupData:(CoreDataStackController *)data;
-(void)addNewDailyToView:(Daily *)daily;
@end
