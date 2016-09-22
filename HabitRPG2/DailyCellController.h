//
//  DailyCellController.h
//  HabitRPG2
//
//  Created by Joel Pridgen on 9/1/16.
//  Copyright © 2016 Joel Pridgen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Daily.h"
#import "TaskCell.h"

@interface DailyCellController : TaskCell

@property (nonatomic,weak)  UILabel *nameLbl;
@property (nonatomic,weak)  UILabel *streakLbl;
@property (nonatomic,weak)  UILabel *daysLeftLbl;
@property (nonatomic,weak)  UIButton *checkbutton;


+(id)getDailyCell:(UITableView *)tableView WithParent:(id)parent;
-(void)setupModel:(Daily *)model;
@end
