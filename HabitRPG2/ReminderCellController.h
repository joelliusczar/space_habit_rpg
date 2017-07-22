//
//  ReminderCellController.h
//  HabitRPG2
//
//  Created by Joel Pridgen on 6/17/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import "TaskCell.h"
#import "Reminder+CoreDataClass.h"

@interface ReminderCellController : TaskCell
@property (weak, nonatomic) IBOutlet UILabel *lblRowDesc;
+(instancetype)getReminderCell:(UITableView *)tableView withParent:(id)parent andReminder:(Reminder *)reminderModel;
@end
