//
//  Interceptor.m
//  HabitRPG2
//
//  Created by Joel Pridgen on 6/13/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import "Interceptor.h"

@implementation Interceptor

+(void)callVoidWrapped:(wrapReturnVoid)callMe withInfo:(id)info{
    [self handleInterceptedInfo:info];
    NSArray<NSString *> *callStack = NSThread.callStackSymbols;
    NSLog(@"%@",callStack[1]);
    callMe();
}

+(int32_t)callInt32Wrapped:(wrapReturnInt32)callMe withInfo:(id)info{
    return callMe();
}

+(void)handleInterceptedInfo:(id)info{
    if(nil==info){}
    else if([info isKindOfClass:NSString.class]){
        NSLog(@"%@",info);
    }
    else if([info isKindOfClass:NSDictionary.class]){}
    else if([info isKindOfClass:NSArray.class]){}
}

@end