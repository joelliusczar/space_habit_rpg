//
//  DailyCellController.h
//  HabitRPG2
//
//  Created by Joel Pridgen on 9/1/16.
//  Copyright © 2016 Joel Pridgen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Daily+CoreDataClass.h"
#import "TaskCell.h"
#import "DailyViewController.h"

@interface DailyCellController : TaskCell

+(id)getDailyCell:(UITableView *)tableView WithParent:(DailyViewController *)parent;
-(void)setupCell:(Daily *)model AndRow:(NSIndexPath *)rowInfo;
-(void)refreshCell:(NSIndexPath *)rowInfo;
@end
