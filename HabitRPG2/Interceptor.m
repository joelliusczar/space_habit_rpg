//
//  Interceptor.m
//  HabitRPG2
//
//  Created by Joel Pridgen on 6/13/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import "Interceptor.h"

@implementation Interceptor

-(void)callVoidWrapped:(wrapReturnVoid)callMe withInfo:(id)info{
    [Interceptor callVoidWrapped:callMe withInfo:info];
}


+(void)callVoidWrapped:(wrapReturnVoid)callMe withInfo:(id)info{
    //[self handleInterceptedInfo:info];
    //NSArray<NSString *> *callStack = NSThread.callStackSymbols;
    callMe();
}


-(BOOL)callBoolWrapped:(wrapReturnBool)callMe withInfo:(id)info{
    @try{
        return callMe();
    }
    @catch(NSException *ex){
        NSLog(@"%@",@"got em bool");
    }
    
}

+(void)handleInterceptedInfo:(id)info{
    if(nil==info){}
    else if([info isKindOfClass:NSString.class]){
        //NSLog(@"%@",info);
    }
    else if([info isKindOfClass:NSDictionary.class]){}
    else if([info isKindOfClass:NSArray.class]){}
}

@end
