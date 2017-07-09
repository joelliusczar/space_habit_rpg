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
@import UserNotifications;

@interface ReminderListView()
@end

@implementation ReminderListView


+(CGRect)naturalFrame{
    return CGRectMake(0,0,300,100);
}


-(instancetype)initWithDueDateInfo:(NSObject<P_DueDateWrapper> *)dueDateInfo
                 andBackViewController:(UIViewController *)backViewController
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
    self.reminderList.tableFooterView = footerControl.view;
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
    return cell;
}


-(void)addItemBtn_press_action:(UIButton *)sender forEvent:(UIEvent *)event{
    ReminderTimeSpinPicker *timePicker =
    [[ReminderTimeSpinPicker alloc] initWithLocale:self.locale
                                       andDayRange:self.dueDateInfo.maxDaysBefore];
    [ViewHelper pushViewToFront:timePicker OfParent:self.backViewController];
}


-(void)pickerSelection_action:(UIPickerView *)sender
                     forEvent:(TimeSpinPickerEventInfo *)event{
    
    wrapReturnVoid wrappedCall = ^void(){
        Reminder *reminder =
        (Reminder *)[SHData constructEmptyEntity:Reminder.entity];
        
        //we only really care out the hour and minute
        reminder.reminderHour =
        [NSDate createSimpleTime:event.selectedHourRow
                          minute:event.selectedMinRow second:0];
        
        reminder.daysBeforeDue = [SHMath toIntExact:event.selectedDaysBeforeRow];
        [self.dueDateInfo addNewReminder:reminder];
    };
    [Interceptor callVoidWrapped:wrappedCall withInfo:nil];
}

@end
