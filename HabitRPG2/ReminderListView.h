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
#import "Reminder+CoreDataClass.h"
#import "P_ReminderTimeSpinPickerDelegate.h"
#import "EditNavigationController.h"
#import "P_TimeUtilityStore.h"
#import "SHView.h"

@import CoreData;

@interface ReminderListView :SHView
<UITableViewDataSource
,P_AddItemsFooterDelegate
,P_ReminderTimeSpinPickerDelegate>

@property (weak,nonatomic) IBOutlet UITableView *reminderTbl;
@property (strong,nonatomic) id<P_DueDateWrapper> dueDateInfo;
@property (weak,nonatomic) NSOrderedSet<Reminder *> *reminderSet;
@property (strong,nonatomic) id<P_TimeUtilityStore> timeStore;
@property (weak,nonatomic) EditNavigationController *backViewController;
@property (strong,nonatomic) UIColor *contentColor;
+(instancetype)newWithDueDateInfo:(id<P_DueDateWrapper>)dueDateInfo
             andBackViewController:(EditNavigationController *)backViewController
                         andTimeStore:(id<P_TimeUtilityStore>)timeStore;
@end
