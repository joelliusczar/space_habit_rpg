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
+(instancetype)newWithDueDateInfo:(id<P_DueDateWrapper>)dueDateInfo
                 andBackViewController:(EditNavigationController *)backViewController{
    ReminderListView *instance = [[ReminderListView alloc] init];
    instance.dueDateInfo = dueDateInfo = dueDateInfo;
    instance.reminderSet = [dueDateInfo getReminderSet];
    instance.backViewController = backViewController;
    
    CGFloat tblHeight = instance.reminderSet.count<SUB_TABLE_MAX_ROWS?
        SUB_TABLE_CELL_HEIGHT*instance.reminderSet.count:
        SUB_TABLE_MAX_HEIGHT;
    [instance resizeRemindersListHeightByOffset:tblHeight];
    instance.itemTbl.tableFooterView = [[UIView alloc]
                                            initWithFrame:CGRectZero];
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
    timePicker.utilityStore = self.utilityStore;
    timePicker.delegate = self;
    [ViewHelper pushViewToFront:timePicker OfParent:self.backViewController];
}


-(void)pickerSelection_action:(UIPickerView *)sender
                     forEvent:(TimeSpinPickerEventInfo *)event{
    
    wrapReturnVoid wrappedCall = ^void(){
        [self.backViewController enableSave];
        [self insertNewReminder:event.selectedHourRow
                         minute:event.selectedMinRow
                     daysBefore:event.selectedDaysBeforeRow];
        NSIndexPath *indexPath = [NSIndexPath
                                  indexPathForRow:self.reminderSet.count-1
                                  inSection:0];
        [self.itemTbl
         insertRowsAtIndexPaths:@[indexPath]
         withRowAnimation:UITableViewRowAnimationFade];
        //need the begin/end update lines because buttons will get covered by
        //invisble stuff and not respond
        //also, apparently they tell the table to refresh the heights
        [self.backViewController.editingScreen.controlsTbl beginUpdates];
        [self resizeRemindersListHeightByOffset:SUB_TABLE_CELL_HEIGHT];
        [self scrollRemindersListByOffset:SUB_TABLE_CELL_HEIGHT];
        [self.backViewController.editingScreen.controlsTbl endUpdates];
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


-(void)resizeRemindersListHeightByOffset:(CGFloat)offset{
    if(self.itemTbl.frame.size.height < SUB_TABLE_MAX_HEIGHT){
        [self.itemTbl resizeHeightByOffset:offset];
        [self.mainView resizeHeightByOffset:offset];
        [self resizeHeightByOffset:offset];
    }
}


-(void)scrollRemindersListByOffset:(CGFloat)offset{
    //auto scroll so that reminders remains centered
    [self.backViewController scrollByOffset:SUB_TABLE_CELL_HEIGHT];
    [self.itemTbl scrollByOffset:SUB_TABLE_CELL_HEIGHT];
}


@end
