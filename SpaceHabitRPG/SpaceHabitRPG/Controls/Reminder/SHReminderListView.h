//
//	SHReminderListView.h
//	HabitRPG2
//
//	Created by Joel Pridgen on 6/25/17.
//	Copyright © 2017 Joel Pridgen. All rights reserved.
//

@import UIKit;
@import SHModels;
@import SHControls;

@import CoreData;

@interface SHReminderListView :SHItemFlexibleListView
<UITableViewDataSource>

@property (strong,nonatomic) NSManagedObjectContext *context;
@property (strong,nonatomic) SHObjectIDWrapper *objectIDWrapper;

+(instancetype)newWithContext:(NSManagedObjectContext *)context
	withObjectIDWrapper:(SHObjectIDWrapper*)objectIDWrapper;

@end
