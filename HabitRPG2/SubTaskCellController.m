//
//  SubTaskCellController.m
//  HabitRPG2
//
//  Created by Joel Pridgen on 6/17/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import "SubTaskCellController.h"

@implementation SubTaskCellController

+(instancetype)getSubtaskCell:(UITableView *)tableView withParent:(id)parent
                     andModel:(DailySubTask *)model{
    (void)parent;
    (void)model;
    SubTaskCellController *cell = [tableView
                                   dequeueReusableCellWithIdentifier:NSStringFromClass(self.class)];
    if(nil==cell){
        cell = [[SubTaskCellController alloc] init];
    }
    return cell;
}

@end
