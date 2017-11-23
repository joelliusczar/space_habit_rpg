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
#import "Experiments+Bravo.h"
#import "ChildMan.h"
#import "XPSideKick.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        //Experiments *exp = [[Experiments alloc] init];
        //[exp playWithCharlie];
        [Experiments underbarWeakStuff];
    }
    return 0;
}
