//
//  SHMath.m
//  HabitRPG2
//
//  Created by Joel Pridgen on 7/3/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import "SHMath.h"

@implementation SHMath

+(BOOL)isPowerOfTwo:(NSInteger)num{
    return (num&(num-1))==0;
}

+(int)toIntExact:(long)num{
    if(num>INT32_MAX || num<INT32_MIN){
        @throw [NSException
                exceptionWithName:NSRangeException
                reason:@"num was too big or too negative" userInfo:nil];
    }
    return (int)num;
}

@end
