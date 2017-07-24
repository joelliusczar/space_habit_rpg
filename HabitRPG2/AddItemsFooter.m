//
//  AddItemsFooter.m
//  HabitRPG2
//
//  Created by Joel Pridgen on 7/1/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import "AddItemsFooter.h"

@implementation AddItemsFooter

-(instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        UIView *view = [self loadXib];
        view.frame = frame;
        [self addSubview:view];
    }
    return self;
}


-(instancetype)initWithCoder:(NSCoder *)coder{
    if(self = [super initWithCoder:coder]){
        UIView *view = [self loadXib];
        [self addSubview:view];
    }
    return self;
}


-(UIView *)loadXib{
    return [[NSBundle bundleForClass:self.class]
            loadNibNamed:NSStringFromClass(self.class)
            owner:self
            options: nil][0];
}


-(IBAction)addItemBtn_press_action:(UIButton *)sender forEvent:(UIEvent *)event {
    if(self.delegate){
        [self.delegate addItemBtn_press_action:sender forEvent:event];
    }
}

@end
