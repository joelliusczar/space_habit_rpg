//
//  MockStdLibWrapper.m
//  HabitRPG2
//
//  Created by Joel Pridgen on 4/6/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import "MockStdLibWrapper.h"

@interface MockStdLibWrapper()
    
@end

@implementation MockStdLibWrapper

    -(uint32_t)randomUInt:(u_int32_t)offset{
        return self.mockRandom(offset);
    }
@end
