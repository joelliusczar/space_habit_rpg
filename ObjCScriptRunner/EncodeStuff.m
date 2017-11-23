//
//  EncodeStuff.m
//  HabitRPG2
//
//  Created by Joel Pridgen on 11/20/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import "EncodeStuff.h"

@implementation EncodeStuff

-(NSString *)whatItDo:(id)t{
    NSLog(@"hash %lu ",[t hash]);
    const char * tStr = @encode(typeof(t));
    return [NSString stringWithUTF8String:tStr];
}

@end
