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

@interface ItemFlexibleListView :SHView
<UITableViewDataSource
,P_AddItemsFooterDelegate
,P_SHSpinPickerDelegate>
@property (weak,nonatomic) IBOutlet UITableView *itemTbl;
@property (strong,nonatomic) id<P_UtilityStore> utilityStore;
@property (weak,nonatomic) EditNavigationController *backViewController;
@property (weak,nonatomic) IBOutlet AddItemsFooter *addItemsFooter;
@property (readonly,nonatomic) NSInteger backendListCount;
+(CGFloat)getInitialHeight:(NSUInteger)itemCount;
-(void)resizeItemListHeightByChange:(CGFloat)change;
-(void)scrollRemindersListByOffset:(CGFloat)offset;
-(void)resizeAndScrollByChange:(CGFloat)change;
-(void)commonSetup;
-(void)showSHSpinPicker:(SHSpinPicker *)picker;
@end
