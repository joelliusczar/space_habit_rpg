//
//  SHItemFlexibleListView.m
//  HabitRPG2
//
//  Created by Joel Pridgen on 8/13/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#pragma clang diagnostic ignored "-Wunused-parameter"

#import "SHItemFlexibleListView.h"
#import <SHCommon/NSException+SHCommonExceptions.h>
#import <SHCommon/NSObject+Helper.h>
#import <SHCommon/SHSingletonCluster.h>
#import "SHFrontEndConstants.h"
#import "UIView+Helpers.h"
#import "UIScrollView+ScrollAdjusters.h"
#import "UIViewController+Helper.h"
#import "SHEventInfo.h"
#import <SHCommon/SHInterceptor.h>
#import <math.h>


@interface SHItemFlexibleListView()
@end

@implementation SHItemFlexibleListView


-(instancetype)init{
  NSBundle *bundle = [NSBundle bundleForClass:NSClassFromString(@"SHItemFlexibleListView")];
  if(self = [super initWithNibName:@"SHItemFlexibleListViewFull" bundle:bundle]){
    _displayCount = SH_SUB_TABLE_MAX_ROWS;
  }
  return self;
}


CGFloat getInitialHeight(NSUInteger itemCount){
    return itemCount < (NSUInteger)SH_SUB_TABLE_MAX_ROWS?
    SH_SUB_TABLE_CELL_HEIGHT*itemCount:
    calculateMaxTableHeight(SH_SUB_TABLE_CELL_HEIGHT);
}


CGFloat calculateMaxTableHeight(CGFloat changeHeight){
    return SH_SUB_TABLE_MAX_ROWS*fabs(changeHeight);
}



-(void)scrollListToRow:(NSIndexPath *)path{
  UITableViewCell *cell = [self.itemTbl cellForRowAtIndexPath:path];
  CGFloat offset = cell.frame.size.height;
  [self scrollByOffset:offset];
  [self scrollVisibleToControl:self];
  [self.itemTbl scrollToRowAtIndexPath:path
    atScrollPosition:UITableViewScrollPositionBottom
    animated:YES];
}


-(void)commonSetup{
  self.itemTbl.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
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
  [self scrollListToRow:indexPath];
  [self notifyAddNewCell:indexPath];
}


-(void)removeItemFromTableAndScale:(NSIndexPath *)indexPath{
    [self.itemTbl deleteRowsAtIndexPaths:@[indexPath]
      withRowAnimation:UITableViewRowAnimationFade];
    [self notifyDeleteCell:indexPath];
}


-(NSInteger)tableView:(UITableView *)tableView
numberOfRowsInSection:(NSInteger)section{
  @throw [NSException abstractException];
}


-(UITableViewCell *)tableView:(UITableViewCell *)tableView
  cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    @throw [NSException abstractException];
}


-(void)deleteCellAt:(NSIndexPath *)indexPath{
    @throw [NSException abstractException];
}


-(NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView
  editActionsForRowAtIndexPath:(NSIndexPath *)indexPath
{
  __weak SHItemFlexibleListView *weakSelf = self;
  void (^pressedDelete)(UITableViewRowAction *,NSIndexPath *) =
    ^(UITableViewRowAction *action,NSIndexPath *indexPath){
        [weakSelf deleteCellAt:indexPath];
    };
  UITableViewRowAction *openDeleteButton = [UITableViewRowAction
    rowActionWithStyle:UITableViewRowActionStyleNormal
    title:@"Delete"
    handler:pressedDelete];
  openDeleteButton.backgroundColor = UIColor.redColor;
  return @[openDeleteButton];
}


-(void)addItemBtn_press_action{
  SEL delegateSel = @selector(addItemBtn_press_action:);
  if([self.setChangedelegate respondsToSelector:delegateSel]){
    [self.setChangedelegate addItemBtn_press_action];
  }
}


-(IBAction)addItemBtn_press_action:(UIButton *)sender forEvent:(UIEvent *)event {
  [self addItemBtn_press_action];
}


-(void)pickerSelection_action:(SHSpinPicker *)picker{
  SEL delegateSel = @selector(pickerSelection_action:);
  if([self.setChangedelegate respondsToSelector:delegateSel]){
    [self.setChangedelegate pickerSelection_action:picker];
  }
}


-(void)notifyAddNewCell:(NSIndexPath *)indexPath{
  SHItemFlexibleListEventInfo *eventInfo = [[SHItemFlexibleListEventInfo alloc]
    initWithItemFlexibleList:self
    andIndexPath:indexPath];
  SEL delegateSel = @selector(notifyAddNewCell:);
  if([self.setChangedelegate respondsToSelector:delegateSel]){
      [self.setChangedelegate notifyAddNewCell:eventInfo];
  }
}
    
    
-(void)notifyDeleteCell:(NSIndexPath *)indexPath{
      SHItemFlexibleListEventInfo *eventInfo = [[SHItemFlexibleListEventInfo alloc]
       initWithItemFlexibleList:self
        andIndexPath:indexPath];
      SEL delegateSel = @selector(notifyDeleteCell:);
      if([self.setChangedelegate respondsToSelector:delegateSel]){
          [self.setChangedelegate notifyDeleteCell:eventInfo];
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


-(void)scrollVisibleToControl:(UIViewController *)control{
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

-(NSUInteger)backendListCount{
    @throw [NSException abstractException];
}

@end
