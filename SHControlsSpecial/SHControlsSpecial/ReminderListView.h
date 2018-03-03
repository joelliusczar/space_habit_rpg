//
//  ReminderListView.h
//  HabitRPG2
//
//  Created by Joel Pridgen on 6/25/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SHModels/P_DueDateItem.h>
#import <SHControls/P_AddItemsFooterDelegate.h>
#import <SHModels/Reminder+CoreDataClass.h>
#import <SHControls/P_SHSpinPickerDelegate.h>
#import <SHControls/AddItemsFooter.h>
#import <SHControls/ItemFlexibleListView.h>

@import CoreData;

@interface ReminderListView :ItemFlexibleListView
<UITableViewDataSource
,P_AddItemsFooterDelegate
,P_SHSpinPickerDelegate>

@property (strong,nonatomic) id<P_DueDateItem> dueDateInfo;
@property (weak,nonatomic) NSOrderedSet<Reminder *> *reminderSet;
+(instancetype)newWithDueDateInfo:(id<P_DueDateItem>)dueDateInfo;
@end
