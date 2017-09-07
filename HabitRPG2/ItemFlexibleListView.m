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
#import "SHEventInfo.h"

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
        [self respondToHeightResize:change];
    }
}


-(void)scrollRemindersListByOffset:(CGFloat)offset{
    //auto scroll so that reminders remains centered
    [self scrollByOffset:offset];
    [self scrollVisibleToControl:self];
    [self scrollItemTblToLastRow];
}


-(void)scrollItemTblToLastRow{
    NSIndexPath *lastRow = [NSIndexPath
                            indexPathForRow:[self backendListCount] -1
                            inSection:0];
    [self.itemTbl scrollToRowAtIndexPath:lastRow
                        atScrollPosition:UITableViewScrollPositionBottom
                                animated:YES];
}


-(void)commonSetup{
    CGFloat tblHeight = [ItemFlexibleListView getInitialHeight:self.backendListCount];
    [self resizeItemListHeightByChange:tblHeight];
    self.itemTbl.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
}


-(void)showSHSpinPicker:(SHSpinPicker *)picker{
    picker.utilityStore = self.utilityStore;
    picker.delegate = self;
    [self.resizeResponder pushViewControllerToNearestParent:picker];
}


-(void)scaleTableForAddItem:(NSInteger)row{
    NSIndexPath *indexPath = [NSIndexPath
                              indexPathForRow:row
                              inSection:0];
    [self.itemTbl insertRowsAtIndexPaths:@[indexPath]
                        withRowAnimation:UITableViewRowAnimationFade];
    //need the begin/end update lines because buttons will get covered by
    //invisble stuff and not respond
    //also, apparently they tell the table to refresh the heights
    [self beginUpdate];
    [self resizeItemListHeightByChange:SUB_TABLE_CELL_HEIGHT];
    [self endUpdate];
    [self scrollRemindersListByOffset:SUB_TABLE_CELL_HEIGHT];
}


-(NSInteger)tableView:(UITableView *)tableView
numberOfRowsInSection:(NSInteger)section{
    @throw [NSException abstractException];
}


-(UITableViewCell *)tableView:(UITableViewCell *)tableView
        cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    @throw [NSException abstractException];
}


-(void)addItemBtn_press_action:(SHEventInfo *)eventInfo{
    [eventInfo.senderStack addObject:self];
    SEL delegateSel = @selector(addItemBtn_press_action:);
    if([self.delegate respondsToSelector:delegateSel]){
        [self.delegate addItemBtn_press_action:eventInfo];
    }
}


-(void)pickerSelection_action:(SHEventInfo *)eventInfo{
    [eventInfo.senderStack addObject:self];
    SEL delegateSel = @selector(pickerSelection_action:);
    if([self.delegate respondsToSelector:delegateSel]){
        [self.delegate pickerSelection_action:eventInfo];
    }
}


-(void)beginUpdate{
    SEL delegateSel = @selector(beginUpdate);
    if([self.resizeResponder respondsToSelector:delegateSel]){
        [self.resizeResponder beginUpdate];
    }
}


-(void)endUpdate{
    SEL delegateSel = @selector(endUpdate);
    if([self.resizeResponder respondsToSelector:delegateSel]){
        [self.resizeResponder endUpdate];
    }
}

-(void)respondToHeightResize:(CGFloat)change{
    SEL delegateSel = @selector(respondToHeightResize:);
    if([self.resizeResponder respondsToSelector:delegateSel]){
        [self.resizeResponder respondToHeightResize:change];
    }
}

-(void)scrollByOffset:(CGFloat)offset{
    SEL delegateSel = @selector(scrollByOffset:);
    if([self.resizeResponder respondsToSelector:delegateSel]){
        [self.resizeResponder scrollByOffset:offset];
    }
}


-(void)scrollVisibleToControl:(SHView *)control{
    SEL delegateSel = @selector(scrollVisibleToControl:);
    if([self.resizeResponder respondsToSelector:delegateSel]){
        [self.resizeResponder scrollVisibleToControl:control];
    }
}


-(void)hideKeyboard{
    if([self.resizeResponder respondsToSelector:@selector(hideKeyboard)]){
        [self.resizeResponder hideKeyboard];
    }
}


-(void)refreshTable{
    [self.itemTbl reloadData];
}

-(NSInteger)backendListCount{
    @throw [NSException abstractException];
}

@end
