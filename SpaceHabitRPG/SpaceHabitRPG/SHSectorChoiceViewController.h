//
//  SectorChoice.h
//  HabitRPG2
//
//  Created by Joel Pridgen on 10/16/16.
//  Copyright © 2016 Joel Pridgen. All rights reserved.
//

#import "SHSectorDescriptionViewController.h"
#import "SHCentralViewController.h"
@import UIKit;
@import SHControls;
@import SHModels;

@class SHSectorDescriptionViewController;

@interface SHSectorChoiceViewController : UIViewController <UITableViewDataSource>
@property (weak,nonatomic) IBOutlet UITableView *sectorChoiceTable;
@property (strong,nonatomic) SHSectorDescriptionViewController *descViewController;
@property (copy,nonatomic) void (^onSelectionAction)(SHSector*);
-(instancetype)initWithSectors:(NSArray<SHSector*>*)sectors
	withOnSelectionAction:(void (^)(SHSector*))onSelectionAction;
@end
