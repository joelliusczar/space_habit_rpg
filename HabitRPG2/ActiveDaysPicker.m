//
//  ActiveDaysPicker.m
//  HabitRPG2
//
//  Created by Joel Pridgen on 6/17/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import "ActiveDaysPicker.h"
#import "CommonUtilities.h"
#import "NSObject+Helper.h"

@interface ActiveDaysPicker ()

@end

@implementation ActiveDaysPicker


- (IBAction)activeDaySwitch_press_action:(CustomSwitch *)sender forEvent:(UIEvent *)event {
    if(self.delegate){
        [self.delegate activeDaySwitch_press_action:sender forEvent:event];
    }
}

@end
