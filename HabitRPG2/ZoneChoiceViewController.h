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

@class ZoneDescriptionViewController;

@interface ZoneChoiceViewController : UIViewController <UITableViewDataSource>
@property (nonatomic,weak) UIViewController <CentralViewControllerP> *central;
@property (nonatomic,strong) ZoneDescriptionViewController *descViewController;
+(instancetype)constructWithCentral:(UIViewController <CentralViewControllerP> *)central AndZoneChoices:(NSArray<Zone *> *)zoneChoices;
-(void)saveZoneChoice:(Zone *)zoneChoice;
@end
