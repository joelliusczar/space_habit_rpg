//
//  VarWrapper.m
//  HabitRPG2
//
//  Created by Joel Pridgen on 11/12/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import "VarWrapper.h"
#import "CommonTypeDefs.h"

@implementation VarWrapper


-(instancetype)init:(id)item, ...{
    if(self = [self init]){
        _item = item;
        va_list args;
        va_start(args,item);
        id arg = nil;
        NSString *baseString = @"setItem%d:";
        int count = 2;
        while((arg = va_arg(args,id))){
            NSString *propName = [NSString stringWithFormat:baseString,count];
            SEL selector = NSSelectorFromString(propName);
            if([self respondsToSelector:selector]){
                setter impl = (setter)[self methodForSelector:selector];
                impl(self,selector,arg);
            }
            else{
                break;
            }
        }
        va_end(args);
        
    }
    return self;
}

@end


@implementation PairWrapper
@end
