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
@import UserNotifications;

NSDate *testDate = nil; //TODO remove

@implementation ReminderListView

@synthesize dueDateInfo = _dueDateInfo;
@synthesize reminderSet = _reminderSet;

+(CGRect)naturalFrame{
    return CGRectMake(0,0,300,100);
}

+(void)initialize{ //TODO remove
    testDate = [NSDate dateWithTimeIntervalSince1970:1498443328];
}

-(instancetype)initWithDueDateInfo:(NSObject<P_DueDateWrapper> *)dueDateInfo{
    if(self = [self initWithFrame:self.class.naturalFrame]){
        _dueDateInfo = dueDateInfo;
        _reminderSet = [dueDateInfo getReminderSet];
        
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        _mainView = [[NSBundle mainBundle]
                     loadNibNamed:NSStringFromClass(self.class)
                     owner:self options:nil][0];
        
        [self addSubview:_mainView];
    }
    return self;
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

}

@end
