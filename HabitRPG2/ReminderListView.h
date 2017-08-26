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
#import "P_SHSpinPickerDelegate.h"
#import "EditNavigationController.h"
#import "AddItemsFooter.h"
#import "ItemFlexibleListView.h"

@import CoreData;

@interface ReminderListView :ItemFlexibleListView
<UITableViewDataSource
,P_AddItemsFooterDelegate
,P_SHSpinPickerDelegate>

@property (strong,nonatomic) id<P_DueDateWrapper> dueDateInfo;
@property (weak,nonatomic) NSOrderedSet<Reminder *> *reminderSet;
+(instancetype)newWithDueDateInfo:(id<P_DueDateWrapper>)dueDateInfo;
@end
