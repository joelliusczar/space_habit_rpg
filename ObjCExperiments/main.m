//
//  main.m
//  ObjCExperiments
//
//  Created by Joel Pridgen on 11/1/17.
//  Copyright © 2017 Joel Pridgen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import <Foundation/Foundation.h>
#import "MassPrinter.h"
#import "PersonThingUser.h"
#import "Experiments.h"
#import "Experiments+Bravo.h"
#import "ChildMan.h"
#import "XPSideKick.h"

int main(int argc, char * argv[]) {
    @autoreleasepool {
        //Experiments *exp = [[Experiments alloc] init];
        //[exp playWithCharlie];
        [Experiments blockTestMemoryStuff];
        return 0;
    }
}
