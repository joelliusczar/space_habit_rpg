//
//  TaskCell.h
//  HabitRPG2
//
//  Created by Joel Pridgen on 9/18/16.
//  Copyright © 2016 Joel Pridgen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TaskCell : UITableViewCell
+(id)getCell:(UITableView *)tableView WithNibName:(NSString *)nibName AndParent:(id)parent;
@end
