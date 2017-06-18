//
//  ReminderCellController.h
//  HabitRPG2
//
//  Created by Joel Pridgen on 6/17/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import "TaskCell.h"
#import "P_Reminder.h"
#import <CoreData/CoreData.h>

@interface ReminderCellController : TaskCell
+(instancetype)getReminderCell:(UITableView *)tableView withParent:(id)parent andReminder:(NSManagedObject<P_Reminder> *)reminderModel;

@end
