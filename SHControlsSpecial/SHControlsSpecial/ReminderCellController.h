//
//  ReminderCellController.h
//  HabitRPG2
//
//  Created by Joel Pridgen on 6/17/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import <SHControls/SHListItemCell.h>
#import <SHModels/SHReminder+CoreDataClass.h>
#import <SHModels/SHReminderDTO.h>

@interface ReminderCellController : SHListItemCell
+(instancetype)getReminderCell:(UITableView *)tableView withParent:(id)parent andReminder:(SHReminderDTO*)reminderModel;
@end
