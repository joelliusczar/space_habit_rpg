//
//  House.m
//  HabitRPG2
//
//  Created by Joel Pridgen on 7/10/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import "House.h"

@implementation House

-(void)returnsNothing{
    NSLog(@"%@",@"nothing");
}


-(NSInteger)getFive{
    return 5;
}

-(void)dealloc{
    NSLog(@"%@",@"Deallocating, motherfucker!");
}

@end
