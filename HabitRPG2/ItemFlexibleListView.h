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

@interface ItemFlexibleListView :
SHView<UITableViewDataSource,P_AddItemsFooterDelegate>
@property (weak,nonatomic) IBOutlet UITableView *itemTbl;
@property (strong,nonatomic) id<P_UtilityStore> utilityStore;
@property (weak,nonatomic) EditNavigationController *backViewController;
@property (weak,nonatomic) IBOutlet AddItemsFooter *addItemsFooter;
@end
