//
//  ListItemCell.m
//  HabitRPG2
//
//  Created by Joel Pridgen on 8/13/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import "ListItemCell.h"
#import "NSObject+Helper.h"

@implementation ListItemCell

-(UIView *)loadDefaultXib{
    return [self loadXib:@"ListItemCell"];
}

- (IBAction)addReminderBtn_press_action:(UIButton *)sender forEvent:(UIEvent *)event {
}

@end
