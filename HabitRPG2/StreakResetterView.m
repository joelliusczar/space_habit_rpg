//
//  StreakResetterView.m
//  HabitRPG2
//
//  Created by Joel Pridgen on 6/24/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import "StreakResetterView.h"

@implementation StreakResetterView

+(CGRect)naturalFrame{
    return CGRectMake(0,0,268,62);
}

-(instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        _mainView =
        [[NSBundle mainBundle]
         loadNibNamed:NSStringFromClass(self.class)
         owner:self options:nil][0];
        
        [self addSubview:_mainView];
    }
    return self;
}

- (IBAction)streakResetBtn_press_action:(UIButton *)sender
                               forEvent:(UIEvent *)event {
    if(self.delegate){
        [self.delegate streakResetBtn_press_action:sender
                                          forEvent:event];
    }
}


@end
