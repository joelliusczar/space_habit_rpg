//
//  ItemFlexibleListView.h
//  HabitRPG2
//
//  Created by Joel Pridgen on 8/13/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

@protocol P_ItemFlexibleListDelegate;

#import "SHView.h"
#import "AddItemsFooter.h"
#import "P_AddItemsFooterDelegate.h"
#import "EditNavigationController.h"
#import "P_UtilityStore.h"
#import "SHSpinPicker.h"
#import "P_SHSpinPickerDelegate.h"
#import "P_ResizeResponder.h"
#import "P_ItemFlexibleListDelegate.h"



@interface ItemFlexibleListView :SHView
<UITableViewDataSource
,UITableViewDelegate
,P_AddItemsFooterDelegate
,P_SHSpinPickerDelegate>
@property (weak,nonatomic) IBOutlet UITableView *itemTbl;
@property (weak,nonatomic) IBOutlet AddItemsFooter *addItemsFooter;

/*
 utilityStore is a reference to a collection of misc tools that I 
 use throughout
*/
@property (weak,nonatomic) id<P_UtilityStore> utilityStore;

/*
 inherit from P_ItemFlexibleListDelegate and assign to delegate to 
 be notified when cells are added or deleted or any of its buttons pressed
*/
@property (weak,nonatomic) id<P_ItemFlexibleListDelegate> delegate;

/*
 inherit from P_ResizeResponder and assign to resizeResponder to
 be notified of its whenever some resizing action is happening
*/
@property (weak,nonatomic) id<P_ResizeResponder> resizeResponder;

/*
 abstract: override to provide a way to get the count of the backing list
 for itemTbl
*/
@property (readonly,nonatomic) NSInteger backendListCount;

/*
 calculates the size of control based on how many items have previously
 been added to it.
*/
CGFloat getInitialHeight(NSUInteger itemCount);

/*
 resizes control by the given amount and notifies any parent controls
 to also resize
*/
-(void)resizeItemListHeightByChange:(CGFloat)change;
-(void)scrollRemindersListByOffset:(CGFloat)offset;

/*
 handles some initial configuration such as the size
*/
-(void)commonSetup;

/*
 passes a SHSpinPicker to a resizeResponder and shows it
*/
-(void)showSHSpinPicker:(SHSpinPicker *)picker;

-(void)addItemToTableAndScale:(NSInteger)row;
-(void)removeItemFromTableAndScale:(NSIndexPath *)indexPath;
-(void)hideKeyboard;
-(void)refreshTable;
@end
