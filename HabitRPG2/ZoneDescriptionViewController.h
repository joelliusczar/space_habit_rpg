//
//  ZoneDescriptionViewController.h
//  HabitRPG2
//
//  Created by Joel Pridgen on 1/20/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZoneChoiceViewController.h"
#import "Zone+CoreDataClass.h"

@interface ZoneDescriptionViewController : UIViewController
-(instancetype)init:(ZoneChoiceViewController *)prevScreen WithZone:(Zone *)zone;
@end
