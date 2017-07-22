//
//  ParentMan.m
//  HabitRPG2
//
//  Created by Joel Pridgen on 7/20/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import "ParentMan.h"

@implementation ParentMan

-(instancetype)init{
    if(self = [super init]){
        _contrlNum = 7;
    }
    return self;
}

+(instancetype)newParentMan{
    ParentMan *pm = [[ParentMan alloc] init];
    return pm;
}

@end
