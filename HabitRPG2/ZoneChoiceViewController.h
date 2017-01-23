//
//  ZoneChoice.h
//  HabitRPG2
//
//  Created by Joel Pridgen on 10/16/16.
//  Copyright © 2016 Joel Pridgen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChoiceScreenBase.h"
#import "Zone+CoreDataClass.h"
#import "ZoneDescriptionViewController.h"

@class ZoneDescriptionViewController;

@interface ZoneChoiceViewController : UIViewController <UITableViewDataSource, ChoiceScreenBase>
@property (nonatomic,strong) ZoneDescriptionViewController *descViewController;
+(instancetype)constructWithBase:(UIViewController<ChoiceScreenBase> *)screenBase AndZoneChoices:(NSArray<Zone *> *)zoneChoices;
-(void)saveZoneChoice:(Zone *)zoneChoice;
@end
