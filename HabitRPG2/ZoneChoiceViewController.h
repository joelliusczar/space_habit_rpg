//
//  ZoneChoice.h
//  HabitRPG2
//
//  Created by Joel Pridgen on 10/16/16.
//  Copyright © 2016 Joel Pridgen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Zone+CoreDataClass.h"
#import "ZoneDescriptionViewController.h"
#import "CentralViewControllerP.h"
#import "CustomSwitch.h"

@class ZoneDescriptionViewController;

@interface ZoneChoiceViewController : UIViewController <UITableViewDataSource>
@property (nonatomic,weak) IBOutlet UITableView *zoneChoiceTable;
@property (nonatomic,weak) IBOutlet UIButton *nextBtn;
@property (nonatomic,weak) IBOutlet CustomSwitch *skipSwitch;
@property (nonatomic,weak) UIViewController <CentralViewControllerP> *central;
@property (nonatomic,strong) ZoneDescriptionViewController *descViewController;
+(instancetype)constructWithCentral:(UIViewController <CentralViewControllerP> *)central AndZoneChoices:(NSArray<Zone *> *)zoneChoices;
@end
