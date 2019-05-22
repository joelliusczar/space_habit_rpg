//
//  SHReminderCellController.h
//  HabitRPG2
//
//  Created by Joel Pridgen on 6/17/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import <SHControls/SHListItemCell.h>
#import <SHModels/SHReminder.h>
#import <SHModels/SHReminderDTO.h>

@interface SHReminderCellController : SHListItemCell
+(instancetype)getReminderCell:(UITableView *)tableView
  withParent:(id)parent andObjectID:(NSManagedObjectID*)objectID;
@end
