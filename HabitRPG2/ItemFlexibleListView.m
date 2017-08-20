//
//  ItemFlexibleListView.m
//  HabitRPG2
//
//  Created by Joel Pridgen on 8/13/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import "ItemFlexibleListView.h"
#import "NSException+SHCommonExceptions.h"
#import "NSObject+Helper.h"
#import "SingletonCluster.h"
#import "constants.h"
#import "UIView+Helpers.h"
#import "UIScrollView+ScrollAdjusters.h"
#import "ViewHelper.h"

@interface ItemFlexibleListView()
@end

@implementation ItemFlexibleListView


-(id<P_UtilityStore>)utilityStore{
    if(nil==_utilityStore){
        _utilityStore = SharedGlobal;
    }
    return _utilityStore;
}


-(UIView *)loadDefaultXib{
    return [self loadXib:@"ItemFlexibleListView"];
}


+(CGFloat)getInitialHeight:(NSUInteger)itemCount{
    return itemCount < SUB_TABLE_MAX_ROWS?
        SUB_TABLE_CELL_HEIGHT*itemCount:
        SUB_TABLE_MAX_HEIGHT;
}


-(void)resizeItemListHeightByChange:(CGFloat)change{
    if(self.itemTbl.frame.size.height < SUB_TABLE_MAX_HEIGHT){
        [self.itemTbl resizeHeightByOffset:change];
        [self resizeHeightByOffset:change];
        if(self.holderView){
            [self.holderView resizeHeightByOffset:change];
        }
    }
}


-(void)scrollRemindersListByOffset:(CGFloat)offset{
    //auto scroll so that reminders remains centered
    [self.backViewController scrollByOffset:SUB_TABLE_CELL_HEIGHT];
    [self.itemTbl scrollByOffset:SUB_TABLE_CELL_HEIGHT];
}


-(void)resizeAndScrollByChange:(CGFloat)change{
    //need the begin/end update lines because buttons will get covered by
    //invisble stuff and not respond
    //also, apparently they tell the table to refresh the heights
    [self.backViewController.editingScreen.controlsTbl beginUpdates];
    [self resizeItemListHeightByChange:SUB_TABLE_CELL_HEIGHT];
    [self scrollRemindersListByOffset:SUB_TABLE_CELL_HEIGHT];
    [self.backViewController.editingScreen.controlsTbl endUpdates];
}


-(void)commonSetup{
    CGFloat tblHeight = [ItemFlexibleListView getInitialHeight:self.backendListCount];
    [self resizeItemListHeightByChange:tblHeight];
    self.itemTbl.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
}


-(void)showSHSpinPicker:(SHSpinPicker *)picker{
    picker.utilityStore = self.utilityStore;
    picker.delegate = self;
    [ViewHelper pushViewToFront:picker OfParent:self.backViewController];
}


-(NSInteger)tableView:(UITableView *)tableView
numberOfRowsInSection:(NSInteger)section{
    @throw [NSException abstractException];
}


-(UITableViewCell *)tableView:(UITableViewCell *)tableView
        cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    @throw [NSException abstractException];
}


-(void)addItemBtn_press_action:(UIButton *)sender
                      forEvent:(UIEvent *)event{
    @throw [NSException abstractException];
}


-(void)pickerSelection_action:(UIPickerView *)picker forEvent:(UIEvent *)event{
    @throw [NSException abstractException];
}


-(NSInteger)backendListCount{
    @throw [NSException abstractException];
}

@end
