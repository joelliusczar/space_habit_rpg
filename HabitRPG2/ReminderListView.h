//
//  ReminderListView.h
//  HabitRPG2
//
//  Created by Joel Pridgen on 6/25/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "P_DueDateWrapper.h"
#import "P_AddItemsFooterDelegate.h"
#import "ControlController.h"
#import "Reminder+CoreDataClass.h"
#import "P_ReminderTimeSpinPickerDelegate.h"
#import "EditNavigationController.h"

@import CoreData;

@interface ReminderListView :ControlController
<UITableViewDataSource
,P_AddItemsFooterDelegate
,P_ReminderTimeSpinPickerDelegate>

@property (weak,nonatomic) IBOutlet UITableView *reminderTbl;
@property (strong,nonatomic) NSObject<P_DueDateWrapper>* dueDateInfo;
@property (weak,nonatomic) NSOrderedSet<Reminder *> *reminderSet;
@property (strong,nonatomic) NSLocale *locale;
@property (weak,nonatomic) EditNavigationController *backViewController;
-(instancetype)initWithDueDateInfo:(NSObject<P_DueDateWrapper> *)dueDateInfo
             andBackViewController:(EditNavigationController *)backViewController
                         andLocale:(NSLocale *)locale;
@end
