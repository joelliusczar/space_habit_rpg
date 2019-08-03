//
//  SHItemFlexibleListView.h
//  HabitRPG2
//
//  Created by Joel Pridgen on 8/13/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

@protocol SHItemFlexibleListDelegateProtocol;

#import "SHView.h"
#import "SHAddItemsFooter.h"
#import "SHAddItemsFooterDelegateProtocol.h"
#import "SHSpinPicker.h"
#import "SHResizeResponderProtocol.h"
#import "SHItemFlexibleListDelegateProtocol.h"
#import "SHNestedControlProtocol.h"


@interface SHItemFlexibleListView :SHViewController
<UITableViewDataSource
,UITableViewDelegate>
@property (weak,nonatomic) IBOutlet UITableView *itemTbl;
@property (weak,nonatomic) IBOutlet NSLayoutConstraint *tblHeightConstraint;
@property (weak,nonatomic) UIViewController *linkedViewController;
@property (assign, nonatomic) NSUInteger displayCount;

/*
 inherit from SHItemFlexibleListDelegateProtocol and assign to setChangedelegate to
 be notified when cells are added or deleted or any of its buttons pressed
*/
@property (weak,nonatomic) id<SHItemFlexibleListDelegateProtocol> setChangedelegate;

/*
 inherit from SHResizeResponderProtocol and assign to resizeResponder to
 be notified of its whenever some resizing action is happening
*/
@property (weak,nonatomic) id<SHResizeResponderProtocol> resizeResponder;

/*
 abstract: override to provide a way to get the count of the backing list
 for itemTbl
*/
@property (readonly,nonatomic) NSUInteger backendListCount;

/*
 calculates the size of control based on how many items have previously
 been added to it.
*/
CGFloat getInitialHeight(NSUInteger itemCount);

/*
 handles some initial configuration such as the size
*/
-(void)commonSetup;


-(void)addItemBtn_press_action;
-(void)addItemToTableAndScale:(NSInteger)row;
-(void)removeItemFromTableAndScale:(NSIndexPath *)indexPath;
-(void)hideKeyboard;
-(void)refreshTable;
@end
