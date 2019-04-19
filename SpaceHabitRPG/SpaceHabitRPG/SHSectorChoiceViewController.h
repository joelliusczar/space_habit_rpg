//
//  ZoneChoice.h
//  HabitRPG2
//
//  Created by Joel Pridgen on 10/16/16.
//  Copyright © 2016 Joel Pridgen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SHModels/SHSector+CoreDataClass.h>
#import "SHSectorDescriptionViewController.h"
#import "SHCentralViewController.h"
#import <SHControls/SHSwitch.h>
#import <SHModels/SHSectorDTO.h>

@class SHSectorDescriptionViewController;

@interface SHSectorChoiceViewController : UIViewController <UITableViewDataSource>
@property (nonatomic,weak) IBOutlet UITableView *zoneChoiceTable;
@property (nonatomic,weak) IBOutlet SHButton *skipButton;
@property (nonatomic,weak) SHCentralViewController *central;
@property (nonatomic,strong) SHSectorDescriptionViewController *descViewController;
+(instancetype)newWithCentral:(SHCentralViewController *)central AndZoneChoices:(NSArray<SHSectorDTO *> *)zoneChoices;
@end
