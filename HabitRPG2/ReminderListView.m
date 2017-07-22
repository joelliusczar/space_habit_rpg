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
@import UserNotifications;

@interface ReminderListView()
@end

@implementation ReminderListView


+(CGRect)naturalFrame{
    return CGRectMake(0,0,300,100);
}


-(instancetype)initWithDueDateInfo:(NSObject<P_DueDateWrapper> *)dueDateInfo
                 andBackViewController:(EditNavigationController *)backViewController
                         andLocale:(NSLocale *)locale{
    
    if(self = [self initDefault]){
        _dueDateInfo = dueDateInfo;
        _reminderSet = [dueDateInfo getReminderSet];
        _locale = locale;
        _backViewController = backViewController;
    }
    return self;
}


-(void)viewDidLoad{
    [super viewDidLoad];
    AddItemsFooter *footerControl = [[AddItemsFooter alloc] initDefault];
    self.reminderTbl.tableFooterView = footerControl.view;
    footerControl.delegate = self;
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
    ReminderTimeSpinPicker *timePicker =
    [[ReminderTimeSpinPicker alloc] initWithLocale:self.locale
                                       andDayRange:self.dueDateInfo.maxDaysBefore];
    timePicker.delegate = self;
    [ViewHelper pushViewToFront:timePicker OfParent:self.backViewController];
}


-(void)pickerSelection_action:(UIPickerView *)sender
                     forEvent:(TimeSpinPickerEventInfo *)event{
    
    wrapReturnVoid wrappedCall = ^void(){
        [self insertNewReminder:event.selectedHourRow
                         minute:event.selectedMinRow
                     daysBefore:event.selectedDaysBeforeRow];
        NSIndexPath *indexPath = [NSIndexPath
                                  indexPathForRow:self.reminderSet.count-1
                                  inSection:0];
        [self.reminderTbl
         insertRowsAtIndexPaths:@[indexPath]
         withRowAnimation:UITableViewRowAnimationFade];
        //auto scroll so that reminders remains centered
        [self.backViewController scrollByOffset:44];
        [self.view sizeToFit];
        //[self resizeRemindersListHeightByOffset:44];
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
}


-(void)resizeRemindersListHeightByOffset:(NSInteger)offset{
    [self.view resizeHeightByOffset:offset];
    //[self.reminderTbl resizeHeightByOffset:offset];
}

@end
