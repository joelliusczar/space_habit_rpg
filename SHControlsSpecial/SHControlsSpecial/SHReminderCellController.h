//
//	SHReminderCellController.h
//	HabitRPG2
//
//	Created by Joel Pridgen on 6/17/17.
//	Copyright © 2017 Joel Pridgen. All rights reserved.
//

@import SHControls;
@import SHModels;

@interface SHReminderCellController : SHListItemCell
+(instancetype)getReminderCell:(UITableView *)tableView
	withParent:(id)parent andObjectID:(NSManagedObjectID*)objectID;
@end
