//
//  SHEventInfo.m
//  HabitRPG2
//
//  Created by Joel Pridgen on 7/3/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import "SHEventInfo.h"

@implementation SHEventInfo

-(instancetype)init{
    if(self = [super init]){
        _timestamp = [NSDate date].timeIntervalSince1970;
    }
    return self;
}

@end
