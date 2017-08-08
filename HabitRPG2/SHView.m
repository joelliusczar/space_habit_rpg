//
//  SHView.m
//  HabitRPG2
//
//  Created by Joel Pridgen on 8/7/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import "SHView.h"
#import "NSObject+Helper.h"

@implementation SHView

-(instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        _mainView = [self loadXib:NSStringFromClass(self.class)];
        [self addSubview:_mainView];
        self.frame = _mainView.frame;
    }
    return self;
}


-(instancetype)initWithCoder:(NSCoder *)coder{
    if(self = [super initWithCoder:coder]){
        _mainView = [self loadXib:NSStringFromClass(self.class)];
        [self addSubview:_mainView];
    }
    return self;
}

@end
