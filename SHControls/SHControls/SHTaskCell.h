//
//  SHTaskCell.h
//  HabitRPG2
//
//  Created by Joel Pridgen on 9/18/16.
//  Copyright © 2016 Joel Pridgen. All rights reserved.
//

@import UIKit;

@interface SHTaskCell : UITableViewCell
@property (copy,nonatomic) void (^cellActivationAction)(void);
-(UIView *)loadDefaultXib;
+(instancetype)getTaskCell:(UITableView *)tableView;
-(void)refreshCell;
@end
