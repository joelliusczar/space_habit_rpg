//
//  AddItemsFooter.m
//  HabitRPG2
//
//  Created by Joel Pridgen on 7/1/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import "AddItemsFooter.h"

@implementation AddItemsFooter

-(IBAction)addItemBtn_press_action:(UIButton *)sender forEvent:(UIEvent *)event {
    [self.delegate addItemBtn_press_action:sender forEvent:event];
}

@end
