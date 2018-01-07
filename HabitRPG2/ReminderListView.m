//
//  ReminderListView.m
//  HabitRPG2
//
//  Created by Joel Pridgen on 6/25/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import "ReminderListView.h"
#import "SingletonCluster.h"
#import "ReminderCellController.h"
#import "AddItemsFooter.h"
#import "ViewHelper.h"
#import "Interceptor.h"
#import "Reminder+CoreDataClass.h"
#import "NSDate+DateHelper.h"
#import "SHMath.h"
#import "ReminderTimeSpinPicker.h"
#import "UIView+Helpers.h"
#import "UIScrollView+ScrollAdjusters.h"
#import "constants.h"
#import "NotificationHelper.h"
#import "NSObject+Helper.h"
#import "SHEventInfo.h"
@import UserNotifications;

@interface ReminderListView()
@end

@implementation ReminderListView




//I think the reason why I did the class method styled constructor
//was so that calls to 'self' would not get fucked up by subclasses
+(instancetype)newWithDueDateInfo:(id<P_DueDateWrapper>)dueDateInfo{
    ReminderListView *instance = [[ReminderListView alloc] init];
    instance.dueDateInfo = dueDateInfo;
    instance.reminderSet = [dueDateInfo getReminderSet];
    
    [instance commonSetup];
    [instance.addItemsFooter.addItemBtn setTitle:@"Add New Reminder" forState:UIControlStateNormal];
    return instance;
}

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wunused-parameter"

-(NSInteger)tableView:(UITableView *)tableView
numberOfRowsInSection:(NSInteger)section{
    return self.reminderSet.count;
}

#pragma clang diagnostic pop


-(UITableViewCell *)tableView:(UITableView *)tableView
        cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ReminderCellController *cell =
    [ReminderCellController getReminderCell:tableView withParent:self
                                andReminder:self.reminderSet[indexPath.row]];
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
    [[ReminderTimeSpinPicker alloc] initWithDayRange:self.dueDateInfo.maxDaysBefore];
    [self showSHSpinPicker:timePicker];
}


-(void)pickerSelection_action:(SHEventInfo *)eventInfo{
    wrapReturnVoid wrappedCall = ^void(){
        UIPickerView *picker = (UIPickerView *)eventInfo.senderStack[1];
        NSInteger hourRow = [picker selectedRowInComponent:HOUR_OF_DAY_COL];
        NSInteger minuteRow = [picker selectedRowInComponent:MINUTE_COL];
        NSInteger daysCol = picker.numberOfComponents -1;
        NSInteger daysBefore = [picker selectedRowInComponent:daysCol];
        [self insertNewReminder:hourRow minute:minuteRow daysBefore:daysBefore];
        [self addItemToTableAndScale:(self.backendListCount -1)];
        [eventInfo.senderStack addObject:self];
        [super pickerSelection_action:eventInfo];
    };
    [self.interceptor callVoidWrapped:wrappedCall withInfo:nil];
}


-(void)insertNewReminder:(NSInteger)hour minute:(NSInteger)minute
              daysBefore:(NSInteger)daysBefore{
    Reminder *reminder = (Reminder *)[SHData
                                      constructEmptyEntity:Reminder.entity];
    //we only really care about the hour and minute
    reminder.reminderHour = [NSDate
                             createSimpleTimeWithHour:hour
                             minute:minute second:0];
    reminder.daysBeforeDue = [SHMath toIntExact:daysBefore];
    [self.dueDateInfo addNewReminder:reminder];
    NSString *notificationId = @"";
    [NotificationHelper addNewNotificationIfPossible:self.dueDateInfo.taskTitle
                                      notificationId:notificationId
                                            userInfo:self.dueDateInfo.simpleMapable];
}


-(void)deleteCellAt:(NSIndexPath *)indexPath{
    //TODO: test this
    [self.dueDateInfo removeReminder:self.reminderSet[indexPath.row]];
    [self removeItemFromTableAndScale:indexPath];
}


-(NSInteger)backendListCount{
    return self.reminderSet.count;
}


@end
