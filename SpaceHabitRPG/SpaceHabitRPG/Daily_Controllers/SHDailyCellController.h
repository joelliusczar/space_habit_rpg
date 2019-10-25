//
//  SHDailyCellController.h
//  HabitRPG2
//
//  Created by Joel Pridgen on 9/1/16.
//  Copyright © 2016 Joel Pridgen. All rights reserved.
//

#import "SHDailyViewController.h"
@import UIKit;
@import SHModels;
@import SHControls;
@import SHData;

@interface SHDailyCellController : SHTaskCell
@property (weak,nonatomic) IBOutlet UILabel *daysLeftLbl;
@property (weak,nonatomic) IBOutlet UILabel *nameLbl;
@property (weak,nonatomic) IBOutlet UILabel *streakLbl;
@property (weak,nonatomic) IBOutlet SHButton *completeBtn;
+(instancetype)getDailyCell:(UITableView *)tableView WithParent:(SHDailyViewController *)parent;
-(void)setupCell:(SHObjectIDWrapper *)objectID;
-(void)refreshCell;
@end
