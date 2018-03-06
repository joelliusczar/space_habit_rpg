//
//  Coverride.m
//  Playground
//
//  Created by Joel Pridgen on 3/3/18.
//  Copyright © 2018 Joel Gillette. All rights reserved.
//

#import "Coverride.h"

void outsideFunc(){
    NSLog(@"Outside og");
}

void outsideNC(){
    NSLog(@"Outside nc");
}

@implementation Coverride

void insideFunc(){
    NSLog(@"Inside og");
}

void insideNC(){
    NSLog(@"Inside nc");
}

-(void)callsItAll{
    insideFunc();
    outsideFunc();
}

@end
