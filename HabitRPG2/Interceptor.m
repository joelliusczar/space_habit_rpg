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
    NSLog(@"%@",info);
    callMe();
}

+(int32_t)callInt32Wrapped:(wrapReturnInt32)callMe withInfo:(id)info{
    return callMe();
}

@end
