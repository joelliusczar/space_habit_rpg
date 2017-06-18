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

-(instancetype)new{
    return [[NSBundle mainBundle] loadNibNamed:@"ActiveDaysPicker" owner:self options:nil][0];
}



- (IBAction)activeDaySwitch_press_action:(CustomSwitch *)sender forEvent:(UIEvent *)event {
    if(self.delegate){
        [self.delegate anySwitchChanged:sender passedEvent:event];
    }
}


@end
