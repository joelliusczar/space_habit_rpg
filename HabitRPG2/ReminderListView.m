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
@import UserNotifications;

@interface ReminderListView()
@property (strong,nonatomic) AddItemsFooter *footerControl;
@end

@implementation ReminderListView


+(CGRect)naturalFrame{
    return CGRectMake(0,0,300,100);
}

-(AddItemsFooter *)footerControl{
    if(nil==_footerControl){
        _footerControl = [[AddItemsFooter alloc]initDefault];
    }
    return _footerControl;
}


-(instancetype)initWithDueDateInfo:(NSObject<P_DueDateWrapper> *)dueDateInfo{
    if(self = [self initDefault]){
        _dueDateInfo = dueDateInfo;
        _reminderSet = [dueDateInfo getReminderSet];
        
    }
    return self;
}

-(void)viewDidLoad{
    [super viewDidLoad];
    self.reminderList.tableFooterView = self.footerControl.view;
    self.footerControl.delegate = self;
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
    [ViewHelper pushViewToFront:self.footerControl OfParent:self];
}


-(void)pickerSelection_action:(UIPickerView *)sender
                     forEvent:(TimeSpinPickerEventInfo *)event{
    
    wrapReturnVoid wrappedCall = ^void(){
        Reminder *reminder =
        (Reminder *)[SHData constructEmptyEntity:Reminder.entity];
        
        //we only really care out the hour and minute, so I'm just storing
        //it on my birthday
        reminder.reminderHour =
        [NSDate createDateTime:1988 month:4 day:27 hour:event.selectedHourRow
                        minute:event.selectedMinRow second:0];
        reminder.daysBeforeDue = [SHMath longToIntExact:event.selectedDaysBeforeRow];
        [self.dueDateInfo addNewReminder:reminder];
    };
    [Interceptor callVoidWrapped:wrappedCall withInfo:nil];
}

@end
