//
//  ReminderCellController.h
//  HabitRPG2
//
//  Created by Joel Pridgen on 6/17/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import "ListItemCell.h"
#import "Reminder+CoreDataClass.h"

@interface ReminderCellController : ListItemCell
+(instancetype)getReminderCell:(UITableView *)tableView withParent:(id)parent andReminder:(Reminder *)reminderModel;
@end
