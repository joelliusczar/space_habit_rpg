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
@import UserNotifications;

@interface ReminderListView()
@end

@implementation ReminderListView




//I think the reason why I did the class method styled constructor
//was so that calls to 'self' would not get fucked up by subclasses
+(instancetype)newWithDueDateInfo:(id<P_DueDateWrapper>)dueDateInfo{
    ReminderListView *instance = [[ReminderListView alloc] init];
    instance.dueDateInfo = dueDateInfo = dueDateInfo;
    instance.reminderSet = [dueDateInfo getReminderSet];
    
    [instance commonSetup];
    instance.addItemsFooter.addItemLbl.text = @"Add New Reminder";
    return instance;
}


-(NSInteger)tableView:(UITableView *)tableView
numberOfRowsInSection:(NSInteger)section{
    return self.reminderSet.count;
}


-(UITableViewCell *)tableView:(UITableView *)tableView
        cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ReminderCellController *cell =
    [ReminderCellController getReminderCell:tableView withParent:self
                                andReminder:self.reminderSet[indexPath.row]];
    cell.lblRowDesc.text = [NSString stringWithFormat:@"%ld",indexPath.row];
    return cell;
}


-(void)addItemBtn_press_action:(UIButton *)sender forEvent:(UIEvent *)event{
    //the reason I was using a temp model earlier is because
    //the model that was getting passed through here
    //earlier only had the original value.
    ReminderTimeSpinPicker *timePicker =
    [[ReminderTimeSpinPicker alloc] initWithDayRange:self.dueDateInfo.maxDaysBefore];
    [self showSHSpinPicker:timePicker];
}


-(void)pickerSelection_action:(UIPickerView *)sender
                     forEvent:(UIEvent *)event{
    
    wrapReturnVoid wrappedCall = ^void(){
        NSInteger hourRow = [sender selectedRowInComponent:HOUR_OF_DAY_COL];
        NSInteger minuteRow = [sender selectedRowInComponent:MINUTE_COL];
        NSInteger daysCol = sender.numberOfComponents -1;
        NSInteger daysBefore = [sender selectedRowInComponent:daysCol];
        [self insertNewReminder:hourRow minute:minuteRow daysBefore:daysBefore];
        [self scaleTableForAddItem];
        [super pickerSelection_action:sender forEvent:event];
    };
    [Interceptor callVoidWrapped:wrappedCall withInfo:nil];
}


-(void)insertNewReminder:(NSInteger)hour minute:(NSInteger)minute
              daysBefore:(NSInteger)daysBefore{
    Reminder *reminder = (Reminder *)[SHData
                                      constructEmptyEntity:Reminder.entity];
    //we only really care about the hour and minute
    reminder.reminderHour = [NSDate
                             createSimpleTime:hour
                             minute:minute second:0];
    reminder.daysBeforeDue = [SHMath toIntExact:daysBefore];
    [self.dueDateInfo addNewReminder:reminder];
    NSString *notificationId = @"";
    [NotificationHelper addNewNotificationIfPossible:self.dueDateInfo.taskTitle
                                      notificationId:notificationId
                                            userInfo:self.dueDateInfo.simpleMapable];
}


-(NSInteger)backendListCount{
    return self.reminderSet.count;
}


@end
