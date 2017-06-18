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

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)activeDaySwitch_press_action:(CustomSwitch *)sender forEvent:(UIEvent *)event {
    if(self.delegate){
        [self.delegate anySwitchChanged:sender passedEvent:event];
    }
}


@end
