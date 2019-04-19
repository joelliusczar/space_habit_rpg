//
//  SHReminderListView.h
//  HabitRPG2
//
//  Created by Joel Pridgen on 6/25/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SHModels/SHDueDateItemProtocol.h>
#import <SHControls/SHAddItemsFooterDelegateProtocol.h>
#import <SHControls/SHSpinPickerDelegateProtocol.h>
#import <SHControls/SHAddItemsFooter.h>
#import <SHControls/SHItemFlexibleListView.h>

@import CoreData;

@interface SHReminderListView :SHItemFlexibleListView
<UITableViewDataSource
,SHAddItemsFooterDelegateProtocol
,SHSpinPickerDelegateProtocol>

@property (strong,nonatomic) id<SHDueDateItemProtocol> dueDateItem;
+(instancetype)newWithDueDateItem:(id<SHDueDateItemProtocol>)dueDateItem;
@end
