//
//  StdLibWrapper.m
//  HabitRPG2
//
//  Created by Joel Pridgen on 4/4/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import "StdLibWrapper.h"
#import "stdlib.h"

@implementation StdLibWrapper
    -(u_int32_t)randomUInt:(u_int32_t)offset{
        return arc4random_uniform(offset);
    }
@end
