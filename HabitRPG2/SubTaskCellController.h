//
//  SubTaskCellController.h
//  HabitRPG2
//
//  Created by Joel Pridgen on 6/17/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import "TaskCell.h"
#import "DailySubTask+CoreDataClass.h"

@interface SubTaskCellController : TaskCell

+(instancetype)getSubtaskCell:(UITableView *)tableView withParent:(id)parent andModel:(DailySubTask *)model;

@end
