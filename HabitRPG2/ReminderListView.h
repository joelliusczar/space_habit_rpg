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
#import "P_Reminder.h"
#import "P_AddItemsFooterDelegate.h"

@import CoreData;

@interface ReminderListView :UIView
<P_EditScreenControl,
UITableViewDataSource,UITableViewDelegate,P_AddItemsFooterDelegate>

@property (weak,nonatomic) IBOutlet ReminderListView *mainView;
@property (weak,nonatomic) IBOutlet UITableView *reminderList;
@property (weak,nonatomic) NSObject<P_DueDateWrapper>* dueDateInfo;
@property (weak,nonatomic)
    NSOrderedSet<NSManagedObject<P_Reminder> *> *reminderSet;

-(instancetype)initWithDueDateInfo:(NSObject<P_DueDateWrapper> *)dueDateInfo;
@end
