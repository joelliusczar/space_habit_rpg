//
//  SHReminderListView.m
//  HabitRPG2
//
//  Created by Joel Pridgen on 6/25/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import "SHReminderListView.h"
#import "SHReminderCellController.h"
#import <SHControls/SHAddItemsFooter.h>
#import <SHControls/UIViewController+Helper.h>
#import <SHCommon/SHInterceptor.h>
#import <SHCommon/NSDate+DateHelper.h>
#import <SHCommon/SHMath.h>
#import "SHReminderTimeSpinPicker.h"
#import <SHControls/UIView+Helpers.h>
#import <SHControls/UIScrollView+ScrollAdjusters.h>
#import <SHControls/SHFrontEndConstants.h>
#import <SHCommon/SHNotificationHelper.h>
#import <SHCommon/NSObject+Helper.h>
#import <SHControls/SHEventInfo.h>
#import <SHModels/SHReminderDTO.h>
#import <SHData/NSManagedObjectContext+Helper.h>
#import <SHModels/SHReminder.h>
//#import <SHModels/SHDueDateItemProtocol.h>

@interface SHReminderListView()
@end

@implementation SHReminderListView


+(instancetype)newWithContext:(NSManagedObjectContext *)context
  withObjectIDWrapper:(SHObjectIDWrapper*)objectIDWrapper
{
  SHReminderListView *instance = [[SHReminderListView alloc] init];
  instance.context = context;
  instance.objectIDWrapper = objectIDWrapper;
  [instance commonSetup];
  [instance.addItemsFooter.addItemBtn setTitle:@"Add New Reminder" forState:UIControlStateNormal];
  return instance;
}


-(NSInteger)tableView:(UITableView *)tableView
numberOfRowsInSection:(NSInteger)section
{
  (void)tableView; (void)section;
  __block NSInteger count = 0;
  [self.context performBlockAndWait:^{
    id<SHDueDateItemProtocol> dueDateItem = (id<SHDueDateItemProtocol>)[self.context
      getExistingOrNewEntityWithObjectID:self.objectIDWrapper];
    count = dueDateItem.reminderCount;
  }];
  return count;
}


-(UITableViewCell *)tableView:(UITableView *)tableView
  cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  __block NSManagedObjectID *reminderObjectID = nil;
  [self.context performBlockAndWait:^{
    id<SHDueDateItemProtocol> dueDateItem = (id<SHDueDateItemProtocol>)[self.context
      getExistingOrNewEntityWithObjectID:self.objectIDWrapper];
    reminderObjectID = [dueDateItem reminderAtIndex:indexPath.row].objectID;
  }];
    SHReminderCellController *cell =
    [SHReminderCellController getReminderCell:tableView withParent:self
      andObjectID:reminderObjectID];
    cell.lblRowDesc.text = [NSString stringWithFormat:@"%ld",indexPath.row];
    return cell;
}


-(void)addItemBtn_press_action:(SHEventInfo *)eventInfo{
  (void)eventInfo;
  //the reason I was using a temp model earlier is because
  //the model that was getting passed through here
  //earlier only had the original value.
  [self hideKeyboard];
  [self.context performBlock:^{
    id<SHDueDateItemProtocol> dueDateItem = (id<SHDueDateItemProtocol>)[self.context
      getExistingOrNewEntityWithObjectID:self.objectIDWrapper];
    NSInteger maxDaysBefore = dueDateItem.maxDaysBefore;
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
      SHReminderTimeSpinPicker *timePicker = [[SHReminderTimeSpinPicker alloc]
        initWithDayRange:maxDaysBefore];
      [self showSHSpinPicker:timePicker];
    }];
  }];

}


-(void)pickerSelection_action:(SHEventInfo *)eventInfo{
  UIPickerView *picker = (UIPickerView *)eventInfo.senderStack[1];
  NSInteger hourRow = [picker selectedRowInComponent:SH_HOUR_OF_DAY_COL];
  NSInteger minuteRow = [picker selectedRowInComponent:SH_MINUTE_COL];
  NSInteger daysCol = picker.numberOfComponents -1;
  NSInteger daysBefore = [picker selectedRowInComponent:daysCol];
  [self insertNewReminder:hourRow minute:minuteRow daysBefore:daysBefore];
  [self.context performBlock:^{
    id<SHDueDateItemProtocol> dueDateItem = (id<SHDueDateItemProtocol>)[self.context
      getExistingOrNewEntityWithObjectID:self.objectIDWrapper];
    NSUInteger newIndex = dueDateItem.reminderCount - 1;
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
      [self addItemToTableAndScale:(newIndex)];
      [eventInfo.senderStack addObject:self];
      [self pickerSelection_action:eventInfo];
    }];
  }];
  
}


-(void)insertNewReminder:(NSInteger)hour minute:(NSInteger)minute
  daysBefore:(NSInteger)daysBefore
{
  [self.context performBlock:^{
    id<SHDueDateItemProtocol> dueDateItem = (id<SHDueDateItemProtocol>)[self.context
      getExistingOrNewEntityWithObjectID:self.objectIDWrapper];
    SHReminder *reminder = (SHReminder *)[self.context newEntity:SHReminder.entity];
    //we only really care about the hour and minute
    reminder.reminderHour = [NSDate createSimpleTimeWithHour:hour minute:minute second:0].timeIntervalSince1970;
    reminder.daysBeforeDue = [SHMath toIntExact:daysBefore];
    [dueDateItem addNewReminder:reminder];
  }];
}


-(void)deleteCellAt:(NSIndexPath *)indexPath{
  [self.context performBlock:^{
    id<SHDueDateItemProtocol> dueDateItem = (id<SHDueDateItemProtocol>)[self.context
      getExistingOrNewEntityWithObjectID:self.objectIDWrapper];
    [dueDateItem removeReminderAtIndex:indexPath.row];
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
      [self removeItemFromTableAndScale:indexPath];
    }];
  }];
}


-(NSInteger)backendListCount{
  __block NSInteger count = 0;
  [self.context performBlockAndWait:^{
    id<SHDueDateItemProtocol> dueDateItem = (id<SHDueDateItemProtocol>)[self.context
      getExistingOrNewEntityWithObjectID:self.objectIDWrapper];
    count = dueDateItem.reminderCount;
  }];
  return count;
}

@end
