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

@interface ZoneChoiceViewController : UIViewController <UITableViewDataSource, ChoiceScreenBase>
+(instancetype)constructWithBase:(UIViewController <ChoiceScreenBase> *)screenBase AndZoneChoices:(NSArray<Zone *> *)zoneChoices;
@end
