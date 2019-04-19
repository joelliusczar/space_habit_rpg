//
//  ReminderListView.m
//  HabitRPG2
//
//  Created by Joel Pridgen on 6/25/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import "ReminderListView.h"
#import "ReminderCellController.h"
#import <SHControls/SHAddItemsFooter.h>
#import <SHControls/UIViewController+Helper.h>
#import <SHCommon/SHInterceptor.h>
#import <SHCommon/NSDate+DateHelper.h>
#import <SHCommon/SHMath.h>
#import "ReminderTimeSpinPicker.h"
#import <SHControls/UIView+Helpers.h>
#import <SHControls/UIScrollView+ScrollAdjusters.h>
#import <SHControls/SHFrontEndConstants.h>
#import <SHCommon/SHNotificationHelper.h>
#import <SHCommon/NSObject+Helper.h>
#import <SHControls/SHEventInfo.h>
#import <SHModels/SHReminderDTO.h>

@interface ReminderListView()
@end

@implementation ReminderListView


+(instancetype)newWithDueDateItem:(id<SHDueDateItemProtocol>)dueDateItem{
    ReminderListView *instance = [[ReminderListView alloc] init];
    instance.dueDateItem = dueDateItem;
    [instance commonSetup];
    [instance.addItemsFooter.addItemBtn setTitle:@"Add New Reminder" forState:UIControlStateNormal];
    return instance;
}

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wunused-parameter"

-(NSInteger)tableView:(UITableView *)tableView
numberOfRowsInSection:(NSInteger)section{
    return self.dueDateItem.reminderCount;
}

#pragma clang diagnostic pop


-(UITableViewCell *)tableView:(UITableView *)tableView
        cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ReminderCellController *cell =
    [ReminderCellController getReminderCell:tableView withParent:self
      andReminder:[self.dueDateItem reminderAtIndex:indexPath.row]];
    cell.lblRowDesc.text = [NSString stringWithFormat:@"%ld",indexPath.row];
    return cell;
}


-(void)addItemBtn_press_action:(SHEventInfo *)eventInfo{
    (void)eventInfo;
    //the reason I was using a temp model earlier is because
    //the model that was getting passed through here
    //earlier only had the original value.
    [self hideKeyboard];
    ReminderTimeSpinPicker *timePicker =
    [[ReminderTimeSpinPicker alloc] initWithDayRange:self.dueDateItem.maxDaysBefore];
    [self showSHSpinPicker:timePicker];
}


-(void)pickerSelection_action:(SHEventInfo *)eventInfo{
  __weak ReminderListView *weakSelf = self;
    shWrapReturnVoid wrappedCall = ^void(){
        UIPickerView *picker = (UIPickerView *)eventInfo.senderStack[1];
        NSInteger hourRow = [picker selectedRowInComponent:SH_HOUR_OF_DAY_COL];
        NSInteger minuteRow = [picker selectedRowInComponent:SH_MINUTE_COL];
        NSInteger daysCol = picker.numberOfComponents -1;
        NSInteger daysBefore = [picker selectedRowInComponent:daysCol];
        [weakSelf insertNewReminder:hourRow minute:minuteRow daysBefore:daysBefore];
        [weakSelf addItemToTableAndScale:(weakSelf.dueDateItem.reminderCount -1)];
        [eventInfo.senderStack addObject:weakSelf];
        [weakSelf pickerSelection_action:eventInfo];
    };
    [self.interceptor callVoidWrapped:wrappedCall withInfo:nil];
}


-(void)insertNewReminder:(NSInteger)hour minute:(NSInteger)minute
daysBefore:(NSInteger)daysBefore{
    SHReminderDTO *reminder = [SHReminderDTO new];
    //we only really care about the hour and minute
    reminder.reminderHour = [NSDate createSimpleTimeWithHour:hour minute:minute second:0];
    reminder.daysBeforeDue = [SHMath toIntExact:daysBefore];
    [self.dueDateItem addNewReminder:reminder];
}


-(void)deleteCellAt:(NSIndexPath *)indexPath{
    [self.dueDateItem removeReminderAtIndex:indexPath.row];
    [self removeItemFromTableAndScale:indexPath];
}


@end
