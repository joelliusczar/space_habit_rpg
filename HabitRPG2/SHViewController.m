//
//  SHViewController.m
//  HabitRPG2
//
//  Created by Joel Pridgen on 10/29/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import "SHViewController.h"
#import "Interceptor.h"

@interface SHViewController ()

@end

@implementation SHViewController

-(id<P_Interceptor>)interceptor{
    if(nil==_interceptor){
        _interceptor = [[Interceptor alloc] init];
    }
    return _interceptor;
}

@end
