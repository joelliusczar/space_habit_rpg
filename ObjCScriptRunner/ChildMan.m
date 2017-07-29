//
//  ChildMan.m
//  HabitRPG2
//
//  Created by Joel Pridgen on 7/20/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import "ChildMan.h"

@implementation ChildMan

-(instancetype)init{
    if(self = [super init]){
        self.contrlNum = 9;
    }
    return self;
}

+(instancetype)newChildMan{
    ChildMan *cm = [ChildMan newParentMan];
    cm.whamjar = 11;
    return cm;
}


-(void)writeOverLocal{
    NSLog(@"%@",@"L-2");
}


-(void)writeOverPublic{
    NSLog(@"%@",@"P-2");
}


@end
