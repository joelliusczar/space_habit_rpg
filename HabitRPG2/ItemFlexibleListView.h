//
//  ItemFlexibleListView.h
//  HabitRPG2
//
//  Created by Joel Pridgen on 8/13/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

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
@property (weak,nonatomic) id<P_UtilityStore> utilityStore;
@property (weak,nonatomic) id<P_ItemFlexibleListDelegate> delegate;
@property (weak,nonatomic) id<P_ResizeResponder> resizeResponder;
@property (readonly,nonatomic) NSInteger backendListCount;
+(CGFloat)getInitialHeight:(NSUInteger)itemCount;
-(void)resizeItemListHeightByChange:(CGFloat)change;
-(void)scrollRemindersListByOffset:(CGFloat)offset;
-(void)commonSetup;
-(void)showSHSpinPicker:(SHSpinPicker *)picker;
-(void)scaleTableForAddItem:(NSInteger)row;
-(void)scaleTableForRemoveItem:(NSIndexPath *)indexPath;
-(void)hideKeyboard;
-(void)refreshTable;
@end
