//
//  ReminderCellController.m
//  HabitRPG2
//
//  Created by Joel Pridgen on 6/17/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import "ReminderCellController.h"
@interface ReminderCellController()
@property (weak,nonatomic) NSManagedObject<P_Reminder> *model;
@end

@implementation ReminderCellController

+(instancetype)getReminderCell:(UITableView *)tableView withParent:(id)parent andReminder:(NSManagedObject<P_Reminder> *)reminderModel{
    ReminderCellController *cell = [ReminderCellController getCell:tableView WithNibName:@"ReminderCell" AndParent:parent];
    cell.model = reminderModel;
    return cell;
}

- (IBAction)addReminderBtn_press_action:(UIButton *)sender forEvent:(UIEvent *)event {
}

@end
