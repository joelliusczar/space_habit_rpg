//
//  replacer.c
//  ObjCPlayground
//
//  Created by Joel Pridgen on 3/3/18.
//  Copyright © 2018 Joel Gillette. All rights reserved.
//
#import <Foundation/Foundation.h>
#import "Playground/Playground/Coverride.h"

void insideFunc(){
    NSLog(@"inside has been replaced");
}

void outsideFunc(){
    NSLog(@"Outside has been replaced");
}
