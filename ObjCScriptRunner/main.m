//
//  main.m
//  ObjCScriptRunner
//
//  Created by Joel Pridgen on 7/7/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MassPrinter.h"
#import "PersonThingUser.h"
#import "Experiments.h"
#import "ChildMan.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        ChildMan *cm = [ChildMan newChildMan];
        NSLog(@"%ld",cm.whamjar);
        ChildMan *cm2 = [ChildMan newParentMan];
        NSLog(@"%ld",cm2.contrlNum);
    }
    return 0;
}
