//
//  SHView.m
//  HabitRPG2
//
//  Created by Joel Pridgen on 8/7/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import "SHView.h"
#import <SHCommon/NSObject+Helper.h>
#import "UIView+Helpers.h"
#import <SHCommon/Interceptor.h>


@implementation SHView

-(id<P_Interceptor>)interceptor{
    if(nil==_interceptor){
        _interceptor = [[Interceptor alloc] init];
    }
    return _interceptor;
}


-(instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        [self viewAdditionalSetup];
    }
    return self;
}


-(instancetype)initWithCoder:(NSCoder *)coder{
    if(self = [super initWithCoder:coder]){
        [self viewAdditionalSetup];
    }
    return self;
}


-(instancetype)initEmpty{
    if(self = [super initWithFrame:CGRectZero]){}
    return self;
}


-(void)viewAdditionalSetup{
    //only do this part if there is an actual xib to load
    if(![self isMemberOfClass:SHView.class]){ //we're checking that this is a derived class
        _mainView = [self loadDefaultXib];
        [self addSubview:_mainView];
        //this is neccessary because other wise the outer frame
        //is too small and invisibly blocks user actions.
        [self resizeFrame:_mainView.frame.size];
    }
    [self setupCustomOptions];
}

//override in subclass
-(void)setupCustomOptions{}

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
    self.backgroundColor = color;
}


@end
