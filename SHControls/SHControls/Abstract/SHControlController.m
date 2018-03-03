//
//  SHControlController.m
//  HabitRPG2
//
//  Created by Joel Pridgen on 7/25/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import "SHControlController.h"
#import <SHCommon/NSObject+Helper.h>

@implementation SHControlController

-(instancetype)initWithNibName:(NSString *)nibName{
    if(self = [super init]){
        _mainView = [self loadXib:nibName];
    }
    return self;
}


@end
