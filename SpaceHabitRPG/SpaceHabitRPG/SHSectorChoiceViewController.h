//
//  SectorChoice.h
//  HabitRPG2
//
//  Created by Joel Pridgen on 10/16/16.
//  Copyright © 2016 Joel Pridgen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SHModels/SHSector.h>
#import "SHSectorDescriptionViewController.h"
#import "SHCentralViewController.h"
#import <SHControls/SHSwitch.h>
#import <SHModels/SHSectorDTO.h>

@class SHSectorDescriptionViewController;

@interface SHSectorChoiceViewController : UIViewController <UITableViewDataSource>
@property (nonatomic,weak) IBOutlet UITableView *sectorChoiceTable;
@property (nonatomic,weak) IBOutlet SHButton *skipButton;
@property (nonatomic,weak) SHCentralViewController *central;
@property (nonatomic,strong) SHSectorDescriptionViewController *descViewController;
+(instancetype)newWithCentral:(SHCentralViewController *)central AndSectorChoices:(NSArray<SHSectorDTO *> *)sectorChoices;
@end
