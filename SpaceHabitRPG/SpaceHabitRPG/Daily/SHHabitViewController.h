//
//  SHHabitViewController.h
//  SpaceHabitRPG
//
//  Created by Joel Pridgen on 12/20/19.
//  Copyright © 2019 Joel Gillette. All rights reserved.
//

#import "SHCentralViewController.h"
#import "SHEditingSaverProtocol.h"
#import "SHHabitCell.h"
#import <sqlite3.h>
@import UIKit;
@import SHControls;
@import SHModels;
@import SHUtils_C;


NS_ASSUME_NONNULL_BEGIN

@interface SHHabitViewController : SHViewController<UITableViewDelegate,
	UITableViewDataSource,
	UIGestureRecognizerDelegate>
@property (weak, nonatomic) SHCentralViewController *central;
@property (strong, nonatomic) IBOutlet UILabel *addHabitBtnLbl;
/*addHabitBtn is a view rather than a button because I wanted it to have nested
	elements
*/
@property (strong, nonatomic) IBOutlet UIView *addHabitBtn;
@property (strong, nonatomic) IBOutlet UIImageView *addHabitBtnIcon;
@property (strong, nonatomic) IBOutlet UITapGestureRecognizer *addHabitGesture;
@property (copy, nonatomic) void (^onOpenAddHabit)(void);
@property (readonly, nonatomic) SHErrorCode (*insertHabit)(sqlite3 *, struct SHHabitBase const *, int64_t *);
@property (readonly, nonatomic) struct SHSerialQueue *dbQueue;
@property (readonly, nonatomic) const struct SHDatetimeProvider *dateProvider;
@property (readonly, nonatomic) struct SHTableChangeActions tableChangeActions;
-(instancetype)initWithCentral:(SHCentralViewController *)central;

-(void)fetchUpdates:(SHErrorCode (*)(struct SHModelsQueueStore *queueStoreItem))fetchFn;
-(NSUInteger)getSectionCount;

//abstract
@property (readonly, nonatomic) const char *tableName;
-(void)setupData;
-(SHHabitCell *)getTableCell:(UITableView*)tableView;
-(SHViewController<SHEditingSaverProtocol> *)buildHabitEditor;
//end abstract

@end

NS_ASSUME_NONNULL_END
