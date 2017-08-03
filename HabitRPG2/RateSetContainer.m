//
//  RateSetContainerController.m
//  HabitRPG2
//
//  Created by Joel Pridgen on 8/2/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import "RateSetContainer.h"
#import "NSObject+Helper.h"

@interface RateSetContainer ()

@end

@implementation RateSetContainer

-(instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        _mainView = [self loadXib:NSStringFromClass(self.class)];
        [self addSubview:_mainView];
    }
    return self;
}

@end
