//
//  SHItemFlexibleListView.h
//  HabitRPG2
//
//  Created by Joel Pridgen on 8/13/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

@protocol P_ItemFlexibleListDelegate;

#import "SHView.h"
#import "SHAddItemsFooter.h"
#import "SHAddItemsFooterDelegateProtocol.h"
#import "SHSpinPicker.h"
#import "SHSpinPickerDelegateProtocol.h"
#import "SHResizeResponderProtocol.h"
#import "SHItemFlexibleListDelegateProtocol.h"



@interface SHItemFlexibleListView :SHView
<UITableViewDataSource
,UITableViewDelegate
,SHAddItemsFooterDelegateProtocol
,SHSpinPickerDelegateProtocol>
@property (weak,nonatomic) IBOutlet UITableView *itemTbl;
@property (weak,nonatomic) IBOutlet SHAddItemsFooter *addItemsFooter;


/*
 inherit from P_ItemFlexibleListDelegate and assign to delegate to 
 be notified when cells are added or deleted or any of its buttons pressed
*/
@property (weak,nonatomic) id<SHItemFlexibleListDelegateProtocol> delegate;

/*
 inherit from SHResizeResponderProtocol and assign to resizeResponder to
 be notified of its whenever some resizing action is happening
*/
@property (weak,nonatomic) id<SHResizeResponderProtocol> resizeResponder;

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
-(void)resetHeight;
-(void)refreshTable;
-(void)setupInitialHeight;
@end
