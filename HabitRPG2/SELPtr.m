//
//  SELWrap.m
//  HabitRPG2
//
//  Created by Joel Pridgen on 9/15/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//
#pragma clang diagnostic ignored "-Wunused-parameter"

#import "SELPtr.h"

@implementation SELPtr

-(void)m_setSelector:(SEL)selector{
    _selector = selector;
}

+(instancetype)sel:(SEL)selector{
    SELPtr *instance = [[SELPtr alloc] init];
    [instance m_setSelector:selector];
    return instance;
}

-(id)copyWithZone:(NSZone *)zone{
    SELPtr *copy = [[[self class] alloc] init];
    if(copy){
        [copy m_setSelector:self.selector];
    }
    return copy;
}

@end
