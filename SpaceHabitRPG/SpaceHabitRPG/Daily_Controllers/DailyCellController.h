//
//  DailyCellController.h
//  HabitRPG2
//
//  Created by Joel Pridgen on 9/1/16.
//  Copyright © 2016 Joel Pridgen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SHModels/Daily+CoreDataClass.h>
#import <SHControls/TaskCell.h>
#import "DailyViewController.h"
#import <SHControls/SHButton.h>

@interface DailyCellController : TaskCell
@property (weak,nonatomic) IBOutlet UILabel *daysLeftLbl;
@property (weak,nonatomic) IBOutlet UILabel *nameLbl;
@property (weak,nonatomic) IBOutlet UILabel *streakLbl;
@property (weak,nonatomic) IBOutlet SHButton *completeBtn;
+(instancetype)getDailyCell:(UITableView *)tableView WithParent:(DailyViewController *)parent;
-(void)setupCell:(Daily *)model AndRow:(NSIndexPath *)rowInfo;
-(void)refreshCell:(NSIndexPath *)rowInfo;
@end
