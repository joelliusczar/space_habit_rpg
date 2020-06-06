//
//	SHItemFlexibleListView.m
//	HabitRPG2
//
//	Created by Joel Pridgen on 8/13/17.
//	Copyright © 2017 Joel Pridgen. All rights reserved.
//

#pragma clang diagnostic ignored "-Wunused-parameter"

#import "SHItemFlexibleListView.h"
@import SHCommon;
#import "SHFrontEndConstants.h"
#import "UIView+Helpers.h"
#import "UIViewController+Helper.h"
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


CGFloat calculateMaxTableHeight(CGFloat changeHeight){
	return SH_SUB_TABLE_MAX_ROWS*fabs(changeHeight);
}



-(void)scrollListToRow:(NSIndexPath *)path{
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


-(UISwipeActionsConfiguration *)tableView:(UITableView *)tableView
	leadingSwipeActionsConfigurationForRowAtIndexPath:(NSIndexPath *)indexPath
{
	(void)tableView;
	UIContextualAction *deleteAction = [UIContextualAction
		contextualActionWithStyle:UIContextualActionStyleNormal
		title:@"Delete"
		handler:
			^(UIContextualAction *action,
			UIView *sourceView,
			void (^completionHandler)(BOOL actionPerformed)){
				(void)action; (void)sourceView;
					[self deleteCellAt:indexPath];
		}];
	deleteAction.backgroundColor = UIColor.redColor;
	UISwipeActionsConfiguration *actionConfigs = [UISwipeActionsConfiguration
		configurationWithActions:@[deleteAction]];
	
	return actionConfigs;
}


-(void)addItemBtn_press_action{
	SEL delegateSel = @selector(addItemBtn_press_action);
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

	SEL delegateSel = @selector(notifyAddNewCell:);
	if([self.setChangedelegate respondsToSelector:delegateSel]){
			[self.setChangedelegate notifyAddNewCell:indexPath];
	}
}
	
	
-(void)notifyDeleteCell:(NSIndexPath *)indexPath {

	SEL delegateSel = @selector(notifyDeleteCell:);
	if([self.setChangedelegate respondsToSelector:delegateSel]){
		[self.setChangedelegate notifyDeleteCell:indexPath];
	}
}


-(void)refreshTable{
	[self.itemTbl reloadData];
}

-(NSUInteger)backendListCount{
	@throw [NSException abstractException];
}

@end
