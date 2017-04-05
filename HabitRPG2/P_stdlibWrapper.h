//
//  P_stdlibWrapper.h
//  HabitRPG2
//
//  Created by Joel Pridgen on 4/4/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol P_stdlibWrapper <NSObject>
    -(u_int32_t)randomUInt:(u_int32_t)offset;
@end
