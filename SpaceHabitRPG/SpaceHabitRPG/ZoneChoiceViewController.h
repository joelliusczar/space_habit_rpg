//
//  ZoneChoice.h
//  HabitRPG2
//
//  Created by Joel Pridgen on 10/16/16.
//  Copyright © 2016 Joel Pridgen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SHModels/Zone+CoreDataClass.h>
#import "ZoneDescriptionViewController.h"
#import "CentralViewController.h"
#import <SHControls/SHSwitch.h>
#import <SHModels/SHZoneDTO.h>

@class ZoneDescriptionViewController;

@interface ZoneChoiceViewController : UIViewController <UITableViewDataSource>
@property (nonatomic,weak) IBOutlet UITableView *zoneChoiceTable;
@property (nonatomic,weak) IBOutlet SHButton *skipButton;
@property (nonatomic,weak) CentralViewController *central;
@property (nonatomic,strong) ZoneDescriptionViewController *descViewController;
+(instancetype)newWithCentral:(CentralViewController *)central AndZoneChoices:(NSArray<ZoneDTO *> *)zoneChoices;
@end
