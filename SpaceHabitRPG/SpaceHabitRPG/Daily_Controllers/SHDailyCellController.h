//
//  SHDailyCellController.h
//  HabitRPG2
//
//  Created by Joel Pridgen on 9/1/16.
//  Copyright © 2016 Joel Pridgen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SHModels/SHDaily.h>
#import <SHControls/SHTaskCell.h>
#import "SHDailyViewController.h"
#import <SHControls/SHButton.h>

@interface SHDailyCellController : SHTaskCell
@property (weak,nonatomic) IBOutlet UILabel *daysLeftLbl;
@property (weak,nonatomic) IBOutlet UILabel *nameLbl;
@property (weak,nonatomic) IBOutlet UILabel *streakLbl;
@property (weak,nonatomic) IBOutlet SHButton *completeBtn;
+(instancetype)getDailyCell:(UITableView *)tableView WithParent:(SHDailyViewController *)parent;
-(void)setupCell:(SHDaily *)model AndRow:(NSIndexPath *)rowInfo;
-(void)refreshCell:(NSIndexPath *)rowInfo;
@end
