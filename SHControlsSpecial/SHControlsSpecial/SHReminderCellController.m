//
//  SHReminderCellController.m
//  HabitRPG2
//
//  Created by Joel Pridgen on 6/17/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import "SHReminderCellController.h"
@interface SHReminderCellController()
@property (weak,nonatomic) SHReminderDTO *model; //warning replace type
@end

@implementation SHReminderCellController


+(instancetype)getReminderCell:(UITableView *)tableView withParent:(id)parent andReminder:(SHReminderDTO*)reminderModel{
    (void)parent;
    SHReminderCellController *cell = [tableView
                                    dequeueReusableCellWithIdentifier:NSStringFromClass(self.class)];
    if(nil==cell){
        cell = [[SHReminderCellController alloc] init];
    }
    cell.model = reminderModel;
    return cell;
}


@end
