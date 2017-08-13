//
//  SHView.m
//  HabitRPG2
//
//  Created by Joel Pridgen on 8/7/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import "SHView.h"
#import "NSObject+Helper.h"
#import "UIView+Helpers.h"

@implementation SHView

-(instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        _mainView = [self loadXib:NSStringFromClass(self.class)];
        [self addSubview:_mainView];
        //this is neccessary because other wise the outer frame
        //is too small and invisibly blocks user actions.
        [self resizeFrame:_mainView.frame.size];
    }
    return self;
}


-(instancetype)initWithCoder:(NSCoder *)coder{
    if(self = [super initWithCoder:coder]){
        _mainView = [self loadXib:NSStringFromClass(self.class)];
        [self addSubview:_mainView];
        [self resizeFrame:_mainView.frame.size];
    }
    return self;
}

-(void)changeBackgroundColorTo:(UIColor *)color{
    self.mainView.backgroundColor = color;
}

@end
