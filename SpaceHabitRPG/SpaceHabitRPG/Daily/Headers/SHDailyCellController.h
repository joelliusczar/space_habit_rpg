//
//  SHDailyCellController.h
//  HabitRPG2
//
//  Created by Joel Pridgen on 9/1/16.
//  Copyright © 2016 Joel Pridgen. All rights reserved.
//

#import "SHHabitCell.h"
@import UIKit;
@import SHModels;
@import SHControls;


@interface SHDailyCellController : SHHabitCell
@property (weak,nonatomic) IBOutlet UILabel *daysLeftLbl;
@property (weak,nonatomic) IBOutlet UILabel *nameLbl;
@property (weak,nonatomic) IBOutlet UILabel *streakLbl;
@property (weak,nonatomic) IBOutlet UIButton *completeBtn;
-(void)refreshCell;
@end
