//
//  ZoneChoice.h
//  HabitRPG2
//
//  Created by Joel Pridgen on 10/16/16.
//  Copyright © 2016 Joel Pridgen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SHModels/SHSector+CoreDataClass.h>
#import "ZoneDescriptionViewController.h"
#import "CentralViewController.h"
#import <SHControls/SHSwitch.h>
#import <SHModels/SHSectorDTO.h>

@class ZoneDescriptionViewController;

@interface ZoneChoiceViewController : UIViewController <UITableViewDataSource>
@property (nonatomic,weak) IBOutlet UITableView *zoneChoiceTable;
@property (nonatomic,weak) IBOutlet SHButton *skipButton;
@property (nonatomic,weak) CentralViewController *central;
@property (nonatomic,strong) ZoneDescriptionViewController *descViewController;
+(instancetype)newWithCentral:(CentralViewController *)central AndZoneChoices:(NSArray<SHSectorDTO *> *)zoneChoices;
@end
