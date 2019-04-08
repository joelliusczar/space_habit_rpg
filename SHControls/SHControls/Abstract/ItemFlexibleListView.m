//
//  ItemFlexibleListView.m
//  HabitRPG2
//
//  Created by Joel Pridgen on 8/13/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#pragma clang diagnostic ignored "-Wunused-parameter"

#import "ItemFlexibleListView.h"
#import <SHCommon/NSException+SHCommonExceptions.h>
#import <SHCommon/NSObject+Helper.h>
#import <SHCommon/SingletonCluster.h>
#import "FrontEndConstants.h"
#import "UIView+Helpers.h"
#import "UIScrollView+ScrollAdjusters.h"
#import "UIViewController+Helper.h"
#import "SHEventInfo.h"
#import <SHCommon/Interceptor.h>
#import <math.h>

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
    NSBundle *bundle = [NSBundle bundleForClass:NSClassFromString(@"ItemFlexibleListView")];
    return [bundle loadNibNamed:@"ItemFlexibleListView" owner:self options:nil][0];
}


CGFloat getInitialHeight(NSUInteger itemCount){
    return itemCount < (NSUInteger)SUB_TABLE_MAX_ROWS?
    SUB_TABLE_CELL_HEIGHT*itemCount:
    calculateMaxTableHeight(SUB_TABLE_CELL_HEIGHT);
}


CGFloat calculateMaxTableHeight(CGFloat changeHeight){
    return SUB_TABLE_MAX_ROWS*fabs(changeHeight);
}


-(void)resizeItemListHeightByChange:(CGFloat)change{
    CGFloat maxHeight = calculateMaxTableHeight(change);
    if(change < 0 && (self.itemTbl.contentSize.height + change) > maxHeight){
        return;
    }
    if(self.itemTbl.frame.size.height >= maxHeight){
        return;
    }

    [self.itemTbl resizeHeightByOffset:change];
    [self resizeHeightByOffset:change];
    [self respondToHeightResize:change];
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
    [self setupInitialHeight];
    self.itemTbl.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
}


-(void)setupInitialHeight{
    CGFloat tblHeight = getInitialHeight(self.backendListCount);
    [self resizeItemListHeightByChange:tblHeight];
}


-(void)showSHSpinPicker:(SHSpinPicker *)picker{
    picker.utilityStore = self.utilityStore;
    picker.delegate = self;
    [self.resizeResponder pushViewControllerToNearestParent:picker];
}


-(void)addItemToTableAndScale:(NSInteger)row{
    
    NSAssert(row >= 0,@"row was an invalid index");
    
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
    [self notifyAddNewCell:indexPath];
}


-(void)removeItemFromTableAndScale:(NSIndexPath *)indexPath{
    [self.itemTbl deleteRowsAtIndexPaths:@[indexPath]
                        withRowAnimation:UITableViewRowAnimationFade];
    [self beginUpdate];
    [self resizeItemListHeightByChange:-1*SUB_TABLE_CELL_HEIGHT];
    [self endUpdate];
    [self notifyDeleteCell:indexPath];
}


-(NSInteger)tableView:(UITableView *)tableView
numberOfRowsInSection:(NSInteger)section{
    @throw [NSException abstractException];
}


-(UITableViewCell *)tableView:(UITableViewCell *)tableView
        cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    @throw [NSException abstractException];
}


-(void)deleteCellAt:(NSIndexPath *)indexPath{
    @throw [NSException abstractException];
}


-(NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView
                 editActionsForRowAtIndexPath:(NSIndexPath *)indexPath{
    __weak ItemFlexibleListView *weakSelf = self;
    void (^pressedDelete)(UITableViewRowAction *,NSIndexPath *) =
            ^(UITableViewRowAction *action,NSIndexPath *indexPath){
                wrapReturnVoid wrappedCall = ^void(){
                    [weakSelf deleteCellAt:indexPath];
                };
                [weakSelf.interceptor callVoidWrapped:wrappedCall withInfo:nil];
            };
    UITableViewRowAction *openDeleteButton = [UITableViewRowAction
                                              rowActionWithStyle:UITableViewRowActionStyleNormal
                                              title:@"Delete"
                                              handler:pressedDelete];
    openDeleteButton.backgroundColor = UIColor.redColor;
    return @[openDeleteButton];
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


-(void)notifyAddNewCell:(NSIndexPath *)indexPath{
  __weak ItemFlexibleListView *weakSelf = self;
  wrapReturnVoid wrappedCall = ^void(){
      ItemFlexibleListEventInfo *eventInfo = [[ItemFlexibleListEventInfo alloc]
                                              initWithItemFlexibleList:weakSelf
                                              andIndexPath:indexPath];
      SEL delegateSel = @selector(notifyAddNewCell:);
      if([weakSelf.delegate respondsToSelector:delegateSel]){
          [weakSelf.delegate notifyAddNewCell:eventInfo];
      }
  };
  [self.interceptor callVoidWrapped:wrappedCall withInfo:nil];
}
    
    
-(void)notifyDeleteCell:(NSIndexPath *)indexPath{
  __weak ItemFlexibleListView *weakSelf = self;
  wrapReturnVoid wrappedCall = ^void(){
      ItemFlexibleListEventInfo *eventInfo = [[ItemFlexibleListEventInfo alloc]
                                              initWithItemFlexibleList:weakSelf
                                              andIndexPath:indexPath];
      SEL delegateSel = @selector(notifyDeleteCell:);
      if([weakSelf.delegate respondsToSelector:delegateSel]){
          [weakSelf.delegate notifyDeleteCell:eventInfo];
      }
  };
  [self.interceptor callVoidWrapped:wrappedCall withInfo:nil];
}


-(void)beginUpdate{
  __weak ItemFlexibleListView *weakSelf = self;
  wrapReturnVoid wrappedCall = ^void(){
      SEL delegateSel = @selector(beginUpdate);
      if([weakSelf.resizeResponder respondsToSelector:delegateSel]){
          [weakSelf.resizeResponder beginUpdate];
      }
  };
  [self.interceptor callVoidWrapped:wrappedCall withInfo:nil];
}


-(void)endUpdate{
  __weak ItemFlexibleListView *weakSelf = self;
  wrapReturnVoid wrappedCall = ^void(){
      SEL delegateSel = @selector(endUpdate);
      if([weakSelf.resizeResponder respondsToSelector:delegateSel]){
          [weakSelf.resizeResponder endUpdate];
      }
  };
  [self.interceptor callVoidWrapped:wrappedCall withInfo:nil];
    
}

-(void)respondToHeightResize:(CGFloat)change{
  __weak ItemFlexibleListView *weakSelf = self;
  wrapReturnVoid wrappedCall = ^void(){
      SEL delegateSel = @selector(respondToHeightResize:);
      if([weakSelf.resizeResponder respondsToSelector:delegateSel]){
          [weakSelf.resizeResponder respondToHeightResize:change];
      }
  };
  [self.interceptor callVoidWrapped:wrappedCall withInfo:nil];
}

-(void)scrollByOffset:(CGFloat)offset{
  __weak ItemFlexibleListView *weakSelf = self;
  wrapReturnVoid wrappedCall = ^void(){
      SEL delegateSel = @selector(scrollByOffset:);
      if([weakSelf.resizeResponder respondsToSelector:delegateSel]){
          [weakSelf.resizeResponder scrollByOffset:offset];
      }
  };
  [self.interceptor callVoidWrapped:wrappedCall withInfo:nil];
}


-(void)scrollVisibleToControl:(SHView *)control{
  __weak ItemFlexibleListView *weakSelf = self;
  wrapReturnVoid wrappedCall = ^void(){
      SEL delegateSel = @selector(scrollVisibleToControl:);
      if([weakSelf.resizeResponder respondsToSelector:delegateSel]){
          [weakSelf.resizeResponder scrollVisibleToControl:control];
      }
  };
  [self.interceptor callVoidWrapped:wrappedCall withInfo:nil];
}


-(void)hideKeyboard{
  __weak ItemFlexibleListView *weakSelf = self;
  wrapReturnVoid wrappedCall = ^void(){
      if([weakSelf.resizeResponder respondsToSelector:@selector(hideKeyboard)]){
          [weakSelf.resizeResponder hideKeyboard];
      }
  };
  [self.interceptor callVoidWrapped:wrappedCall withInfo:nil];
}


-(void)resetHeight{
    CGFloat h = self.itemTbl.frame.size.height;
    [self resizeItemListHeightByChange:-h];
    
}


-(void)refreshTable{
    [self.itemTbl reloadData];
}

-(NSInteger)backendListCount{
    @throw [NSException abstractException];
}

@end
