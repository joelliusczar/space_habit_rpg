//
//  WeekdaySwitch.h
//  HabitRPG2
//
//  Created by Joel Pridgen on 7/11/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//



#import <UIKit/UIKit.h>
#import "CustomSwitch.h"
#import "P_CustomSwitch.h"

IB_DESIGNABLE
@interface WeekdaySwitch : UIView<P_CustomSwitch>
@property (assign,nonatomic) IBInspectable NSInteger dayFlag;
@property (weak,nonatomic) IBOutlet UILabel *lblDay;
@property (weak,nonatomic) IBOutlet CustomSwitch *btnSwitch;
@end
