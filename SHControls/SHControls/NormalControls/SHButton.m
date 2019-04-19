//
//  SHButton.m
//  HabitRPG2
//
//  Created by Joel Pridgen on 10/29/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import "SHButton.h"
#import <SHCommon/SHInterceptor.h>

@implementation SHButton


-(id<SHInterceptorProtocol>)interceptor{
    if(nil==_interceptor){
        _interceptor = [[SHInterceptor alloc] init];
    }
    return _interceptor;
}

-(void)sendAction:(SEL)action to:(id)target forEvent:(UIEvent *)event{
    shWrapReturnVoid wrappedCall = ^void(){
        [super sendAction:action to:target forEvent:event];
    };
    [self.interceptor callVoidWrapped:wrappedCall withInfo:nil];
}


-(void)sendActionsForControlEvents:(UIControlEvents)controlEvents{
    shWrapReturnVoid wrappedCall = ^void(){
        [super sendActionsForControlEvents:controlEvents];
    };
    [self.interceptor callVoidWrapped:wrappedCall withInfo:nil];
}

@end
