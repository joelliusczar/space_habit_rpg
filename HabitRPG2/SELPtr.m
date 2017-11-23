//
//  SELWrap.m
//  HabitRPG2
//
//  Created by Joel Pridgen on 9/15/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//


#import "SELPtr.h"

@implementation SELPtr


+(instancetype)sel:(SEL)selector{
    SELPtr *instance = [[SELPtr alloc] init];
    instance->_selector = selector;
    instance->_selectorName = NSStringFromSelector(selector);
    return instance;
}


+(instancetype)selName:(NSString *)selectorName{
    SEL selector = NSSelectorFromString(selectorName);
    return [SELPtr sel:selector];
}


#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wunused-parameter"

-(id)copyWithZone:(NSZone *)zone{
    return [SELPtr sel:self.selector];
}

#pragma clang diagnostic pop

-(NSUInteger)hash{
    return self.selectorName.hash;
}

-(BOOL)isEqual:(id)object{
    if(![object isKindOfClass:self.class]){
        return NO;
    }
    SELPtr *obj = (SELPtr *)object;
    return self.selector == obj.selector;
}

@end
