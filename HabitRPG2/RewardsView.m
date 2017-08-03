//
//  RewardsView.m
//  HabitRPG2
//
//  Created by Joel Pridgen on 6/24/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import "RewardsView.h"
#import "NSObject+Helper.h"

@implementation RewardsView

+(CGRect)naturalFrame{
    return CGRectMake(0,0,100,100);
}


-(instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        _mainView = [self loadXib:NSStringFromClass(self.class)];
        [self addSubview:_mainView];
    }
    return self;
}

- (IBAction)addRewardsBtn_press_action:(UIButton *)sender forEvent:(UIEvent *)event {
    if(self.delegate){
        [self.delegate addRewardsBtn_press_action:sender
                                         forEvent:event];
    }
}


@end
