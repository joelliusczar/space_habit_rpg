//
//  KeyToken.m
//  HabitRPG2
//
//  Created by Joel Pridgen on 11/24/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import "KeyToken.h"

@implementation KeyToken

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wunused-parameter"

-(id)copyWithZone:(NSZone *)zone{
    return self;
}

#pragma clang diagnostic pop

-(NSUInteger)hash{
    return (NSUInteger)self;
}

-(BOOL)isEqual:(id)object{
    return self == object;
}

@end
