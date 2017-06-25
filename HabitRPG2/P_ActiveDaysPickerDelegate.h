//
//  P_ActiveDaysPickerDelegate.h
//  HabitRPG2
//
//  Created by Joel Pridgen on 6/17/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "CustomSwitch.h"
#import "P_CommonDelegate.h"

@protocol P_ActiveDaysPickerDelegate <NSObject,P_CommonDelegate>
-(void)activeDaySwitch_press_action:(CustomSwitch *)sender forEvent:(UIEvent *)event;
@end
