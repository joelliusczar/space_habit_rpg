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
#import "P_CentralViewController.h"
#import <SHControls/SHSwitch.h>

@class ZoneDescriptionViewController;

@interface ZoneChoiceViewController : UIViewController <UITableViewDataSource>
@property (nonatomic,weak) IBOutlet UITableView *zoneChoiceTable;
@property (nonatomic,weak) IBOutlet UIButton *nextBtn;
@property (nonatomic,weak) IBOutlet SHSwitch *skipSwitch;
@property (nonatomic,weak) UIViewController <P_CentralViewController> *central;
@property (nonatomic,strong) ZoneDescriptionViewController *descViewController;
+(instancetype)constructWithCentral:(UIViewController <P_CentralViewController> *)central AndZoneChoices:(NSArray<Zone *> *)zoneChoices;
@end
