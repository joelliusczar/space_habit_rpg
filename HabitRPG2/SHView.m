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
        _mainView = [self loadDefaultXib];
        [self addSubview:_mainView];
        //this is neccessary because other wise the outer frame
        //is too small and invisibly blocks user actions.
        [self resizeFrame:_mainView.frame.size];
    }
    return self;
}


-(instancetype)initWithCoder:(NSCoder *)coder{
    if(self = [super initWithCoder:coder]){
        _mainView = [self loadDefaultXib];
        [self addSubview:_mainView];
        [self resizeFrame:_mainView.frame.size];
    }
    return self;
}

//I'm depending on subclasses being able to override this
-(UIView *)loadDefaultXib{
    return [self loadXib:(NSStringFromClass(self.class))];
}

//so that I don't have to always be resizing both self and mainView
-(void)resizeHeightByOffset:(CGFloat)offset{
    [super resizeHeightByOffset:offset];
    [self.mainView resizeHeightByOffset:offset];
}


-(void)resizeFrame:(CGSize)size{
    [super resizeFrame:size];
    [self.mainView resizeFrame:size];
}


-(void)changeBackgroundColorTo:(UIColor *)color{
    self.mainView.backgroundColor = color;
}

@end
