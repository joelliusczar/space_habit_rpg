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
#import "CentralViewController.h"

@class ZoneDescriptionViewController;

@interface ZoneChoiceViewController : UIViewController <UITableViewDataSource>
@property (nonatomic,weak) CentralViewController *central;
@property (nonatomic,strong) ZoneDescriptionViewController *descViewController;
+(instancetype)constructWithCentral:(CentralViewController *)central AndZoneChoices:(NSArray<Zone *> *)zoneChoices;
-(void)saveZoneChoice:(Zone *)zoneChoice;
@end
