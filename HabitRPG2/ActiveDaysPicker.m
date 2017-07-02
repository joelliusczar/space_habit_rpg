//
//  ActiveDaysPicker.m
//  HabitRPG2
//
//  Created by Joel Pridgen on 6/17/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import "ActiveDaysPicker.h"

@interface ActiveDaysPicker ()

@end

@implementation ActiveDaysPicker

+(CGRect)naturalFrame{
    return CGRectMake(0,0,278,179);
}


- (IBAction)activeDaySwitch_press_action:(CustomSwitch *)sender forEvent:(UIEvent *)event {
    if(self.delegate){
        [self.delegate activeDaySwitch_press_action:sender forEvent:event];
    }
}


@end
