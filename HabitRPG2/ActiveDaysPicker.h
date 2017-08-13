//
//  ActiveDaysPicker.h
//  HabitRPG2
//
//  Created by Joel Pridgen on 6/17/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomSwitch.h"
#import "P_ActiveDaysPickerDelegate.h"
#import "SHView.h"

IB_DESIGNABLE
@interface ActiveDaysPicker : SHView
@property (strong, nonatomic) IBOutletCollection(CustomSwitch) NSArray *activeDaySwitches;
@property (weak,nonatomic) id<P_ActiveDaysPickerDelegate> delegate;
@end
