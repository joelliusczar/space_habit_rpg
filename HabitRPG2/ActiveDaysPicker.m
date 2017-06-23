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

-(instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        _mainView = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self.class) owner:self options:nil][0];
        [self addSubview:_mainView];
    }
    return self;
}

- (IBAction)activeDaySwitch_press_action:(CustomSwitch *)sender forEvent:(UIEvent *)event {
    if(self.delegate){
        [self.delegate anySwitchChanged:sender passedEvent:event];
    }
}


@end
