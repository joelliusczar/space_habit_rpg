//
//  ReminderCellController.m
//  HabitRPG2
//
//  Created by Joel Pridgen on 6/17/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import "ReminderCellController.h"
@interface ReminderCellController()
@property (weak,nonatomic) SHReminderDTO *model; //warning replace type
@end

@implementation ReminderCellController


+(instancetype)getReminderCell:(UITableView *)tableView withParent:(id)parent andReminder:(SHReminderDTO*)reminderModel{
    (void)parent;
    ReminderCellController *cell = [tableView
                                    dequeueReusableCellWithIdentifier:NSStringFromClass(self.class)];
    if(nil==cell){
        cell = [[ReminderCellController alloc] init];
    }
    cell.model = reminderModel;
    return cell;
}


@end
