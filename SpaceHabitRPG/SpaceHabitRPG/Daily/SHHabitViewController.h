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
@import UIKit;
@import CoreData;
@import SHControls;


NS_ASSUME_NONNULL_BEGIN

@interface SHHabitViewController : SHViewController<UITableViewDelegate,
	UITableViewDataSource,
	UIGestureRecognizerDelegate>
@property (weak, nonatomic) SHCentralViewController *central;
@property (strong, nonatomic) NSManagedObjectContext *context;
@property (strong, nonatomic) IBOutlet UILabel *addHabitBtnLbl;
/*addHabitBtn is a view rather than a button because I wanted it to have nested
	elements
*/
@property (strong, nonatomic) IBOutlet UIView *addHabitBtn;
@property (strong, nonatomic) IBOutlet UIImageView *addHabitBtnIcon;
@property (strong, nonatomic) IBOutlet UITapGestureRecognizer *addHabitGesture;
@property (copy, nonatomic) void (^onOpenAddHabit)(void);
-(instancetype)initWithCentral:(SHCentralViewController *)central
	withContext:(NSManagedObjectContext*)context;

-(void)fetchUpdates;

//abstract
@property (readonly, nonatomic) NSEntityDescription *entityType;
@property (readonly, nonatomic) NSString *entityName;
-(void)setupData;
-(SHHabitCell *)getTableCell:(UITableView*)tableView;
-(SHViewController<SHEditingSaverProtocol> *)buildHabitEditor;
//end abstract


@end

NS_ASSUME_NONNULL_END
