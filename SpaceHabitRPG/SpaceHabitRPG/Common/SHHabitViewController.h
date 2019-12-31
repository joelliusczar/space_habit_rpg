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
	SHViewEventsProtocol,
	NSFetchedResultsControllerDelegate>
@property (weak, nonatomic) SHCentralViewController *central;
@property (strong, nonatomic) NSManagedObjectContext *context;
@property (strong, nonatomic) NSFetchedResultsController *habitItemsFetcher;
@property (strong, nonatomic) IBOutlet UILabel *addHabitBtnLbl;
/*addHabitBtn is a view rather than a button because I wanted it to have nested
	elements
*/
@property (strong, nonatomic) IBOutlet SHView *addHabitBtn;
@property (strong, nonatomic) IBOutlet UIImageView *addHabitBtnIcon;
-(instancetype)initWithCentral:(SHCentralViewController *)central
	withContext:(NSManagedObjectContext*)context;

-(void)fetchUpdates;

//abstract
@property (strong, nonatomic) SHViewController<SHEditingSaverProtocol> *habitEditor;
@property (readonly, nonatomic) NSEntityDescription *entityType;
@property (readonly, nonatomic) NSString *entityName;
-(void)setupData;
-(SHHabitCell *)getTableCell:(UITableView*)tableView;
//end abstract


@end

NS_ASSUME_NONNULL_END
