//
//  ReminderListView.h
//  HabitRPG2
//
//  Created by Joel Pridgen on 6/25/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "P_EditScreenControl.h"
#import "P_DueDateWrapper.h"
#import "P_AddItemsFooterDelegate.h"
#import "ControlController.h"
#import "Reminder+CoreDataClass.h"
#import "P_ReminderTimeSpinPickerDelegate.h"

@import CoreData;

@interface ReminderListView :ControlController
<P_EditScreenControl
,UITableViewDataSource
,P_AddItemsFooterDelegate
,P_ReminderTimeSpinPickerDelegate>

@property (weak,nonatomic) IBOutlet UITableView *reminderList;
@property (weak,nonatomic) NSObject<P_DueDateWrapper>* dueDateInfo;
@property (weak,nonatomic) NSOrderedSet<Reminder *> *reminderSet;
-(instancetype)initWithDueDateInfo:(NSObject<P_DueDateWrapper> *)dueDateInfo;
@end
