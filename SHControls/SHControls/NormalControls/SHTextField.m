//
//  SHTextField.m
//  HabitRPG2
//
//  Created by Joel Pridgen on 10/29/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import "SHTextField.h"
#import <SHCommon/Interceptor.h>

@implementation SHTextField

-(id<P_Interceptor>)interceptor{
    if(nil==_interceptor){
        _interceptor = [[Interceptor alloc] init];
    }
    return _interceptor;
}


-(void)sendAction:(SEL)action to:(id)target forEvent:(UIEvent *)event{
    wrapReturnVoid wrappedCall = ^void(){
        [super sendAction:action to:target forEvent:event];
    };
    [self.interceptor callVoidWrapped:wrappedCall withInfo:nil];
}


-(void)sendActionsForControlEvents:(UIControlEvents)controlEvents{
    wrapReturnVoid wrappedCall = ^void(){
        [super sendActionsForControlEvents:controlEvents];
    };
    [self.interceptor callVoidWrapped:wrappedCall withInfo:nil];
}

@end
