//
//  SHItemFlexibleListView.h
//  HabitRPG2
//
//  Created by Joel Pridgen on 8/13/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

@protocol SHItemFlexibleListDelegateProtocol;
#import "SHSpinPicker.h"
#import "SHItemFlexibleListDelegateProtocol.h"
#import "SHNestedControlProtocol.h"
#import "SHViewController.h"


@interface SHItemFlexibleListView :SHViewController
<UITableViewDataSource
,UITableViewDelegate>
@property (weak,nonatomic) IBOutlet UITableView *itemTbl;
@property (weak,nonatomic) IBOutlet NSLayoutConstraint *tblHeightConstraint;
@property (weak,nonatomic) SHViewController *linkedViewController;
@property (assign, nonatomic) NSUInteger displayCount;

/*
 inherit from SHItemFlexibleListDelegateProtocol and assign to setChangedelegate to
 be notified when cells are added or deleted or any of its buttons pressed
*/
@property (weak,nonatomic) id<SHItemFlexibleListDelegateProtocol> setChangedelegate;

/*
 abstract: override to provide a way to get the count of the backing list
 for itemTbl
*/
@property (readonly,nonatomic) NSUInteger backendListCount;

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
